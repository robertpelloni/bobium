#!/bin/bash
# verify_checksums.sh - Calculates artifact checksums and validates against SUMMARY
set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)

echo "[+] Running Build Artifact Checksum Verification..."

TARGET_BIN="$REPO_ROOT/chromium/out/Release/chrome"

if [ ! -f "$TARGET_BIN" ]; then
    echo "  -> ERROR: Target binary not found at $TARGET_BIN. Ensure you have run ./scripts/build.sh on physical hardware."
    exit 1
fi

echo "  -> Locating $TARGET_BIN..."
# Calculate actual hash of the compiled binary using cross-platform shasum detection
if command -v sha256sum &> /dev/null; then
    ACTUAL_HASH=$(sha256sum "$TARGET_BIN" | awk '{print $1}')
else
    ACTUAL_HASH=$(shasum -a 256 "$TARGET_BIN" | awk '{print $1}')
fi

echo "  -> Calculated SHA256: $ACTUAL_HASH"

echo "  -> Asserting checksum matches generated build signature..."
EXPECTED_HASH_FILE="$REPO_ROOT/chromium/out/Release/bobium.sha256"

if [ ! -f "$EXPECTED_HASH_FILE" ]; then
    echo "  -> ERROR: Expected checksum file not found at $EXPECTED_HASH_FILE. Run package_release.sh first."
    exit 1
fi

if grep -q "$ACTUAL_HASH" "$EXPECTED_HASH_FILE"; then
    echo "  -> Match verified."
else
    echo "  -> ERROR: Checksum mismatch. The build artifact is invalid or tainted."
    exit 1
fi

echo "[+] Checksum verification passed."
