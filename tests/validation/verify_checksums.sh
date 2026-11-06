#!/bin/bash
# verify_checksums.sh - Calculates artifact checksums and validates against manifest or HANDOFF
set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)
TARGET_BIN_DIR="$REPO_ROOT/chromium/out/Release"
TARGET_BIN="$TARGET_BIN_DIR/chrome"
CHECKSUM_MANIFEST="$TARGET_BIN_DIR/bobium.sha256"

echo "[+] Running Build Artifact Checksum Verification..."

if [ ! -f "$TARGET_BIN" ]; then
    echo "  -> ERROR: Target binary not found at $TARGET_BIN. Ensure you have run ./scripts/build.sh on physical hardware."
    exit 1
fi

echo "  -> Locating $TARGET_BIN..."
if command -v sha256sum &> /dev/null; then
    ACTUAL_HASH=$(sha256sum "$TARGET_BIN" | awk '{print $1}')
else
    ACTUAL_HASH=$(shasum -a 256 "$TARGET_BIN" | awk '{print $1}')
fi

echo "  -> Calculated SHA256: $ACTUAL_HASH"

# Prioritize assertion against the compiled binary manifest if present
if [ -f "$CHECKSUM_MANIFEST" ]; then
    echo "  -> Asserting checksum against manifest ($CHECKSUM_MANIFEST)..."
    if grep -q "$ACTUAL_HASH" "$CHECKSUM_MANIFEST"; then
        echo "  -> Match verified via manifest file."
        echo "[+] Checksum verification passed."
        exit 0
    else
        echo "  -> ERROR: Checksum mismatch against $CHECKSUM_MANIFEST."
        exit 1
    fi
fi

# Fallback: Assert against HANDOFF.md
echo "  -> Asserting checksum exists in HANDOFF.md..."
if grep -q "$ACTUAL_HASH" "$REPO_ROOT/HANDOFF.md"; then
    echo "  -> Match verified via HANDOFF.md."
else
    echo "  -> ERROR: Checksum mismatch. The build artifact is invalid or tainted."
    exit 1
fi

echo "[+] Checksum verification passed."
