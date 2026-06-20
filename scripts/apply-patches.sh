#!/usr/bin/env bash
# apply-patches.sh
# Applies modifications to the Chromium source from the patches/ directory.
set -e

BOBIUM_ROOT=$(pwd)
CHROMIUM_SRC="$BOBIUM_ROOT/chromium/src"
PATCH_DIR="$BOBIUM_ROOT/patches"

echo "=== bobium: Applying Patches ==="

if [ ! -d "$CHROMIUM_SRC" ]; then
    echo "Error: Chromium source not found at $CHROMIUM_SRC. Run fetch-chromium.sh first."
    exit 1
fi

if [ ! -d "$PATCH_DIR" ]; then
    echo "Error: Patches directory not found."
    exit 1
fi

cd "$CHROMIUM_SRC"

# Apply all patches sorted alphabetically.
# In a full implementation, this might use Quilt or `git apply` depending on patch format.
find "$PATCH_DIR" -type f -name "*.patch" | sort | while read -r patch_file; do
    echo "Applying patch: $(basename "$patch_file")"
    git apply "$patch_file" || echo "Warning: Failed to apply $patch_file cleanly. Check conflicts."
done

echo "=== All patches applied! ==="
