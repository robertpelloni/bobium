#!/bin/bash
# package_release.sh - Packages binary distribution and calculates handoff checksums

set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
TARGET_BIN="$REPO_ROOT/chromium/out/Release/chrome"

echo "============================================================"
echo " bobium: Binary Packager & Checksum Generator"
echo "============================================================"

if [ ! -f "$TARGET_BIN" ]; then
    echo "  [FAIL] Target binary not found at $TARGET_BIN. Ensure build.sh completed successfully."
    exit 1
fi

echo "-> Calculating SHA256 checksum for artifact..."
# Cross-platform SHA256 handling
if command -v sha256sum &> /dev/null; then
    ACTUAL_HASH=$(sha256sum "$TARGET_BIN" | awk '{print $1}')
elif command -v shasum &> /dev/null; then
    ACTUAL_HASH=$(shasum -a 256 "$TARGET_BIN" | awk '{print $1}')
else
    echo "  [FAIL] Neither sha256sum nor shasum found."
    exit 1
fi
echo "  [OK] SHA256: $ACTUAL_HASH"

echo "-> Writing signature to build manifest..."
echo "$ACTUAL_HASH" > "$REPO_ROOT/chromium/out/Release/bobium.sha256"

echo "============================================================"
echo " Packaging complete. Release is ready for validation."
echo "============================================================"
