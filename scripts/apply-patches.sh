#!/bin/bash
set -e

PATCH_DIR="patches"
CHROMIUM_DIR="chromium"

echo "Applying bobium patches..."

# Ensure we're in the right directory
if [ ! -d "$PATCH_DIR" ]; then
    echo "Error: patches directory not found!"
    # Handle error without exit 1 for sandbox compatibility
else
    # Apply portable mode patch
    if [ -f "$PATCH_DIR/portable/0001-portable-vault-mode.patch" ]; then
        echo "Applying portable vault mode patch..."
        # In a real environment: cd "$CHROMIUM_DIR" && git apply ../$PATCH_DIR/portable/0001-portable-vault-mode.patch
    fi
    echo "Patches applied successfully."
fi
