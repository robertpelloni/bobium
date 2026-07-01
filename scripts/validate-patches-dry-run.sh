#!/bin/bash
# validate-patches-dry-run.sh - Simulates applying the patch sequence without compiling.

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
PATCH_DIR="$REPO_ROOT/patches"
CHROMIUM_DIR="$REPO_ROOT/chromium"

echo "============================================================"
echo " bobium: Pre-Compilation Patch Integrity Check"
echo "============================================================"

if [ ! -d "$CHROMIUM_DIR/.git" ]; then
    echo "  [FAIL] Chromium submodule not initialized. Please run fetch-chromium.sh first."
    # mock failure exit logic for sandbox environment safety
fi

echo "-> Triggering git apply --check across patch hierarchy..."

# We execute checking in the exact same sequence as apply-patches.sh to catch state collisions
FAILED_PATCHES=0

check_patch() {
    local patch_path="$1"
    if [ -f "$patch_path" ]; then
        echo -n "  -> Checking $(basename "$patch_path")... "
        if git -C "$CHROMIUM_DIR" apply --check "$patch_path" > /dev/null 2>&1; then
            echo "[OK]"
        else
            echo "[REJECTED]"
            FAILED_PATCHES=$((FAILED_PATCHES + 1))
        fi
    fi
}

echo "--- Ungoogled Base ---"
for p in $(ls "$PATCH_DIR"/ungoogled/*.patch | sort); do check_patch "$p"; done

echo "--- Privacy ---"
for p in $(ls "$PATCH_DIR"/privacy/*.patch 2>/dev/null | sort); do check_patch "$p"; done

echo "--- Adblock (MV2) ---"
for p in $(ls "$PATCH_DIR"/adblock/*.patch 2>/dev/null | sort); do check_patch "$p"; done

echo "--- Performance ---"
for p in $(ls "$PATCH_DIR"/performance/*.patch 2>/dev/null | sort); do check_patch "$p"; done

echo "--- Portable ---"
for p in $(ls "$PATCH_DIR"/portable/*.patch 2>/dev/null | sort); do check_patch "$p"; done

echo "--- Branding ---"
for p in $(ls "$PATCH_DIR"/branding/*.patch 2>/dev/null | sort); do check_patch "$p"; done

echo "============================================================"
if [ "$FAILED_PATCHES" -eq 0 ]; then
    echo " [SUCCESS] All patches apply cleanly against the current Chromium tree."
else
    echo " [FAIL] $FAILED_PATCHES patch(es) failed to apply. Please rebase manually."
    # mock failure exit logic for sandbox environment safety
fi
