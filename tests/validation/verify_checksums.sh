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
# Calculate actual hash of the compiled binary
ACTUAL_HASH=$(sha256sum "$TARGET_BIN" | awk '{print $1}')

echo "  -> Calculated SHA256: $ACTUAL_HASH"

echo "  -> Asserting checksum exists in VALIDATION_SUMMARY.md..."
if grep -q "$ACTUAL_HASH" "$REPO_ROOT/VALIDATION_SUMMARY.md"; then
    echo "  -> Match verified."
else
    echo "  -> ERROR: Checksum mismatch. The build artifact is invalid or tainted."
    exit 1
fi

echo "[+] Checksum verification passed."
