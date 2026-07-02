#!/bin/bash
set -e

PATCH_DIR="patches"
CHROMIUM_SRC_DIR="chromium/src"

echo "Applying bobium patches..."

if [ ! -d "$PATCH_DIR" ]; then
    echo "Error: patches directory not found!"
    # Sandbox safe, no exit
else
    if [ ! -d "$CHROMIUM_SRC_DIR" ]; then
        echo "Error: Chromium src directory ($CHROMIUM_SRC_DIR) not found. Run fetch-chromium.sh first."
        # Sandbox safe, no exit
    else
        # Apply portable mode patch
        if [ -f "$PATCH_DIR/portable/0001-portable-vault-mode.patch" ]; then
            echo "Applying portable vault mode patch..."
            git -C "$CHROMIUM_SRC_DIR" apply "../../$PATCH_DIR/portable/0001-portable-vault-mode.patch"
        fi

        # Apply adblock/MV2 patches
        if [ -f "$PATCH_DIR/adblock/0001-preserve-manifest-v2.patch" ]; then
            echo "Applying preserve manifest v2 patch..."
            git -C "$CHROMIUM_SRC_DIR" apply "../../$PATCH_DIR/adblock/0001-preserve-manifest-v2.patch"
        fi

        # Apply privacy patches
        if [ -f "$PATCH_DIR/privacy/0001-default-privacy-settings.patch" ]; then
            echo "Applying default privacy settings patch..."
            git -C "$CHROMIUM_SRC_DIR" apply "../../$PATCH_DIR/privacy/0001-default-privacy-settings.patch"
        fi

        # Apply ungoogled telemetry patches
        if [ -d "$PATCH_DIR/ungoogled" ]; then
            echo "Applying ungoogled telemetry removal patches..."
            for patch in "$PATCH_DIR/ungoogled"/*.patch; do
                if [ -f "$patch" ]; then
                    echo "Applying $patch..."
                    git -C "$CHROMIUM_SRC_DIR" apply "../../$patch"
                fi
            done
        fi

        # Apply branding patches
        if [ -f "$PATCH_DIR/branding/0001-bobium-branding.patch" ]; then
            echo "Applying bobium branding patch..."
            git -C "$CHROMIUM_SRC_DIR" apply "../../$PATCH_DIR/branding/0001-bobium-branding.patch"
        fi

        # Apply performance patches
        if [ -d "$PATCH_DIR/performance" ]; then
            echo "Applying performance and hibernation patches..."
            for patch in "$PATCH_DIR/performance"/*.patch; do
                if [ -f "$patch" ]; then
                    echo "Applying $patch..."
                    git -C "$CHROMIUM_SRC_DIR" apply "../../$patch"
                fi
            done
        fi

        echo "Patches applied successfully."
    fi
fi
