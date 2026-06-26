#!/bin/bash
# build.sh - Automates the gn gen and autoninja build process for bobium

set -e

CHROMIUM_DIR="chromium"
OUT_DIR="out/Release"

echo "============================================================"
echo " bobium: Chromium Build Orchestrator"
echo "============================================================"

if [ ! -d "$CHROMIUM_DIR" ]; then
    echo "ERROR: Chromium source directory not found!"
    echo "Please run ./scripts/fetch-chromium.sh first."
else
    cd "$CHROMIUM_DIR"

    # Ensure depot_tools is in PATH
    if [ -d "../depot_tools" ]; then
        export PATH="$PWD/../depot_tools:$PATH"
    fi

    echo "-> Generating build files via GN..."
    # We pass the args from the BUILD_INSTRUCTIONS.md to ensure privacy and optimization
    gn gen "$OUT_DIR" --args='is_debug=false dcheck_always_on=false is_component_build=false symbol_level=0 blink_symbol_level=0 enable_hangout_services_extension=false enable_mdns=false google_api_key="" google_default_client_id="" google_default_client_secret="" safe_browsing_mode=0 use_thin_lto=true'

    echo "-> Compiling bobium (This will take hours)..."
    autoninja -C "$OUT_DIR" chrome

    echo "============================================================"
    echo " Build Complete! Binary is located in $CHROMIUM_DIR/$OUT_DIR"
    echo "============================================================"
fi
