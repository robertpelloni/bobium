#!/bin/bash
# apply-patches.sh - Deterministically applies bobium patch layers to chromium/src

set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
PATCH_DIR="$REPO_ROOT/patches"
CHROMIUM_SRC_DIR="$REPO_ROOT/chromium/src"

echo "============================================================"
echo " bobium: Chromium Patch Engine"
echo "============================================================"

if [ ! -d "$PATCH_DIR" ]; then
    echo "Error: patches directory not found!"
    exit 1
fi

if [ ! -d "$CHROMIUM_SRC_DIR" ]; then
    echo "Notice: Chromium src directory ($CHROMIUM_SRC_DIR) not found. Run fetch-chromium.sh first."
    exit 0
fi

apply_patch() {
    local patch_path="$1"
    if [ -f "$patch_path" ]; then
        echo "Applying $(basename "$patch_path")..."
        git -C "$CHROMIUM_SRC_DIR" apply "$patch_path"
    fi
}

# Sequence Standard: Apply ungoogled-chromium base patches FIRST to prevent context collisions
echo "--- 1. Ungoogled Base Patches ---"
if compgen -G "$PATCH_DIR/ungoogled/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/ungoogled/*.patch | sort); do
        apply_patch "$p"
    done
fi

# Apply bobium privacy customizations
echo "--- 2. Privacy Patches ---"
if compgen -G "$PATCH_DIR/privacy/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/privacy/*.patch | sort); do
        apply_patch "$p"
    done
fi

# Apply Manifest V2 preservation patches
echo "--- 3. Adblock (MV2 Preservation) Patches ---"
if compgen -G "$PATCH_DIR/adblock/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/adblock/*.patch | sort); do
        apply_patch "$p"
    done
fi

# Apply Tab Hibernation Engine performance patches
echo "--- 4. Performance & Hibernation Patches ---"
if compgen -G "$PATCH_DIR/performance/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/performance/*.patch | sort); do
        apply_patch "$p"
    done
fi

# Apply Portable Vault Mode patches
echo "--- 5. Portable Mode Patches ---"
if compgen -G "$PATCH_DIR/portable/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/portable/*.patch | sort); do
        apply_patch "$p"
    done
fi

# Apply bobium branding patches
echo "--- 6. Branding Patches ---"
if compgen -G "$PATCH_DIR/branding/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/branding/*.patch | sort); do
        apply_patch "$p"
    done
fi

echo "============================================================"
echo " All bobium patches applied successfully."
echo "============================================================"
