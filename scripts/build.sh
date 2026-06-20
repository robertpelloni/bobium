#!/usr/bin/env bash
# build.sh
# Configures and builds the Chromium source with bobium args.
set -e

BOBIUM_ROOT=$(pwd)
CHROMIUM_SRC="$BOBIUM_ROOT/chromium/src"
DEPOT_TOOLS_DIR="$BOBIUM_ROOT/depot_tools"

export PATH="$PATH:$DEPOT_TOOLS_DIR"

echo "=== bobium: Build Pipeline ==="

if [ ! -d "$CHROMIUM_SRC" ]; then
    echo "Error: Chromium source not found. Run fetch-chromium.sh first."
    exit 1
fi

cd "$CHROMIUM_SRC"

# Generate build files
echo "Generating Ninja configuration via GN..."
gn gen out/Release --args='is_debug=false is_official_build=true symbol_level=0'

# Compile
echo "Compiling via autoninja..."
autoninja -C out/Release chrome

echo "=== Build complete! ==="
