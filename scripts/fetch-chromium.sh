#!/bin/bash
# fetch-chromium.sh - Fetches Chromium source via depot_tools

set -e

CHROMIUM_DIR="chromium"

echo "============================================================"
echo " bobium: Chromium Source Fetcher"
echo "============================================================"

# Ensure depot_tools is in PATH
if [ ! -d "depot_tools" ]; then
    echo "Cloning depot_tools..."
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi
export PATH="$PWD/depot_tools:$PATH"

if [ -d "$CHROMIUM_DIR" ]; then
    echo "Chromium directory already exists. Running gclient sync..."
    cd "$CHROMIUM_DIR"
    gclient sync
else
    echo "Fetching Chromium source (this will take hours and >30GB disk space)..."
    mkdir -p "$CHROMIUM_DIR"
    cd "$CHROMIUM_DIR"
    fetch --nohooks chromium
    echo "Running gclient sync..."
    gclient sync
fi

echo "============================================================"
echo " Fetch Complete!"
echo "============================================================"
