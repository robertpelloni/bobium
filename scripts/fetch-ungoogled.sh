#!/bin/bash
# fetch-ungoogled.sh - Downloads and unpacks ungoogled-chromium patch sets

set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
UNGOOGLED_DIR="$REPO_ROOT/patches/ungoogled"

echo "============================================================"
echo " bobium: Ungoogled-Chromium Patch Set Fetcher"
echo "============================================================"

mkdir -p "$UNGOOGLED_DIR"

echo "-> Checking for upstream ungoogled-chromium patch source..."
UPSTREAM_REPO="https://github.com/ungoogled-software/ungoogled-chromium.git"

TEMP_CLONE=$(mktemp -d -t ungoogled_clone_XXXXXX)

echo "-> Fetching ungoogled-chromium patch archive to $TEMP_CLONE..."
if command -v git &> /dev/null; then
    # Shallow clone to minimize network footprint
    if git clone --depth 1 "$UPSTREAM_REPO" "$TEMP_CLONE" 2>/dev/null; then
        if [ -d "$TEMP_CLONE/patches" ]; then
            echo "-> Synchronizing patches into $UNGOOGLED_DIR while preserving series ordering..."
            find "$TEMP_CLONE/patches" -type f -name "*.patch" | sort | while read -r patch_file; do
                fname=$(basename "$patch_file")
                cp "$patch_file" "$UNGOOGLED_DIR/$fname"
            done
            echo "  [OK] Successfully refreshed ungoogled patches."
        fi
    else
        echo "  [WARN] Remote fetch failed or network offline. Preserving existing ungoogled patches."
    fi
    rm -rf "$TEMP_CLONE"
else
    echo "  [WARN] Git not found. Skipping remote fetch."
    rm -rf "$TEMP_CLONE"
fi

echo "============================================================"
echo " Ungoogled patch synchronization complete."
echo "============================================================"
