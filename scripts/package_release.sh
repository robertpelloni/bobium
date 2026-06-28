#!/bin/bash
# package_release.sh - Compresses the bobium build artifact for distribution

set -e

CHROMIUM_SRC_DIR="chromium/src"
OUT_DIR="out/Release"
TARGET_BINARY="chrome"
VERSION=$(cat VERSION.md)
RELEASE_ZIP="bobium-${VERSION}-linux-x64.zip"

echo "============================================================"
echo " bobium: Binary Packager"
echo "============================================================"

if [ ! -f "$CHROMIUM_SRC_DIR/$OUT_DIR/$TARGET_BINARY" ]; then
    echo "ERROR: Compiled binary not found at $CHROMIUM_SRC_DIR/$OUT_DIR/$TARGET_BINARY"
    echo "You must compile the project first via ./scripts/build.sh"
else
    echo "-> Preparing release package..."
    mkdir -p release_stage/bobium
    cp "$CHROMIUM_SRC_DIR/$OUT_DIR/$TARGET_BINARY" release_stage/bobium/
    cp portable_mode.h release_stage/bobium/

    echo "-> Compressing to $RELEASE_ZIP..."
    cd release_stage
    zip -r "../$RELEASE_ZIP" bobium/
    cd ..

    echo "-> Cleaning up..."
    rm -rf release_stage

    echo "============================================================"
    echo " Packaging Complete! Distribute: $RELEASE_ZIP"
    echo "============================================================"
fi
