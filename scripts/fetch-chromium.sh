#!/bin/bash
# fetch-chromium.sh - Automates the cloning and syncing of the Chromium source tree

set -e

CHROMIUM_DIR="chromium"

echo "============================================================"
echo " bobium: Chromium Source Fetcher"
echo "============================================================"

# Ensure depot_tools is present
if [ ! -d "depot_tools" ]; then
    echo "-> Cloning depot_tools..."
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi

export PATH="$PWD/depot_tools:$PATH"

if [ ! -d "$CHROMIUM_DIR" ]; then
    echo "-> Fetching Chromium source (this will take a VERY long time and requires ~30GB of space)..."
    mkdir "$CHROMIUM_DIR"
    cd "$CHROMIUM_DIR"
    fetch --nohooks chromium
    echo "-> Running gclient sync..."
    gclient sync --with_branch_heads --with_tags
else
    echo "-> Chromium directory already exists. Syncing..."
    cd "$CHROMIUM_DIR"
    gclient sync -D --with_branch_heads --with_tags
fi

echo "-> Chromium source ready in $CHROMIUM_DIR/src."
