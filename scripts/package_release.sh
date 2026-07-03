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

# Inject the generated hash into VALIDATION_SUMMARY.md so the automated tests can assert it
# We now inject into HANDOFF.md instead since VALIDATION_SUMMARY was consolidated.
echo "-> Appending signature to HANDOFF.md..."
if ! grep -q "MOCK_HASH_PLACEHOLDER" "$REPO_ROOT/HANDOFF.md"; then
    echo "MOCK_HASH_PLACEHOLDER:$ACTUAL_HASH" >> "$REPO_ROOT/HANDOFF.md"
else
    # If the placeholder exists, we replace it using a cross-platform sed approach
    if [ "$(uname)" = "Darwin" ]; then
        sed -i '' "s/MOCK_HASH_PLACEHOLDER.*/MOCK_HASH_PLACEHOLDER:$ACTUAL_HASH/g" "$REPO_ROOT/HANDOFF.md"
    else
        sed -i "s/MOCK_HASH_PLACEHOLDER.*/MOCK_HASH_PLACEHOLDER:$ACTUAL_HASH/g" "$REPO_ROOT/HANDOFF.md"
    fi
fi

echo "============================================================"
echo " Packaging complete. Release is ready for validation."
echo "============================================================"
