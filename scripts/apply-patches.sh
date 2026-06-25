#!/bin/bash
set -e

PATCH_DIR="patches"
CHROMIUM_DIR="chromium"

echo "Applying bobium patches..."

if [ ! -d "$PATCH_DIR" ]; then
    echo "Error: patches directory not found!"
else
    # Apply portable mode patch
    if [ -f "$PATCH_DIR/portable/0001-portable-vault-mode.patch" ]; then
        echo "Applying portable vault mode patch..."
        if [ -d "$CHROMIUM_DIR" ]; then
            cd "$CHROMIUM_DIR" && git apply ../$PATCH_DIR/portable/0001-portable-vault-mode.patch
            cd ..
        else
            echo "Warning: $CHROMIUM_DIR directory not found, skipping patch application."
        fi
    fi

    # Apply adblock/MV2 patches
    if [ -f "$PATCH_DIR/adblock/0001-preserve-manifest-v2.patch" ]; then
        echo "Applying preserve manifest v2 patch..."
        if [ -d "$CHROMIUM_DIR" ]; then
            cd "$CHROMIUM_DIR" && git apply ../$PATCH_DIR/adblock/0001-preserve-manifest-v2.patch
            cd ..
        else
            echo "Warning: $CHROMIUM_DIR directory not found, skipping patch application."
        fi
    fi

    # Apply privacy patches
    if [ -f "$PATCH_DIR/privacy/0001-default-privacy-settings.patch" ]; then
        echo "Applying default privacy settings patch..."
        if [ -d "$CHROMIUM_DIR" ]; then
            cd "$CHROMIUM_DIR" && git apply ../$PATCH_DIR/privacy/0001-default-privacy-settings.patch
            cd ..
        else
            echo "Warning: $CHROMIUM_DIR directory not found, skipping patch application."
        fi
    fi

    # Apply ungoogled telemetry patches
    if [ -d "$PATCH_DIR/ungoogled" ]; then
        echo "Applying ungoogled telemetry removal patches..."
        # Sort to ensure they apply in numerical order
        for patch in $(ls "$PATCH_DIR/ungoogled"/*.patch | sort); do
            if [ -f "$patch" ]; then
                echo "Applying $patch..."
                if [ -d "$CHROMIUM_DIR" ]; then
                    cd "$CHROMIUM_DIR" && git apply "../$patch"
                    cd ..
                else
                    echo "Warning: $CHROMIUM_DIR directory not found, skipping patch application."
                fi
            fi
        done
    fi

    echo "Patches applied successfully."
fi
