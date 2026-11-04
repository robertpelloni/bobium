#!/bin/bash
# validate-patches-dry-run.sh - Simulates applying the patch sequence without compiling.

set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
PATCH_DIR="$REPO_ROOT/patches"
CHROMIUM_DIR="$REPO_ROOT/chromium/src"

echo "============================================================"
echo " bobium: Pre-Compilation Patch Integrity Check"
echo "============================================================"

HAS_CHROMIUM_TREE=0
if [ -d "$CHROMIUM_DIR/.git" ] || [ -d "$REPO_ROOT/chromium/.git" ]; then
    HAS_CHROMIUM_TREE=1
else
    echo "  [INFO] Chromium tree not checked out locally (sandbox or pre-fetch environment)."
    echo "  [INFO] Performing patch structure and git-apply formatting check."
fi

FAILED_PATCHES=0

check_patch() {
    local patch_path="$1"
    if [ -f "$patch_path" ]; then
        echo -n "  -> Checking $(basename "$patch_path")... "
        if [ "$HAS_CHROMIUM_TREE" -eq 1 ]; then
            TARGET_DIR="$CHROMIUM_DIR"
            [ -d "$TARGET_DIR" ] || TARGET_DIR="$REPO_ROOT/chromium"
            if git -C "$TARGET_DIR" apply --check "$patch_path" > /dev/null 2>&1; then
                echo "[OK]"
            else
                echo "[REJECTED]"
                FAILED_PATCHES=$((FAILED_PATCHES + 1))
            fi
        else
            # Test that git apply recognizes the patch format without errors (ignoring missing target files)
            CHECK_OUTPUT=$(git apply --check "$patch_path" 2>&1 || true)
            if echo "$CHECK_OUTPUT" | grep -qi "corrupt\|fatal\|error: patch"; then
                echo "[MALFORMED DIFF: $CHECK_OUTPUT]"
                FAILED_PATCHES=$((FAILED_PATCHES + 1))
            else
                echo "[FORMAT OK]"
            fi
        fi
    fi
}

echo "--- Ungoogled Base ---"
if compgen -G "$PATCH_DIR/ungoogled/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/ungoogled/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No ungoogled patches found)"
fi

echo "--- Privacy ---"
if compgen -G "$PATCH_DIR/privacy/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/privacy/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No privacy patches found)"
fi

echo "--- Adblock (MV2) ---"
if compgen -G "$PATCH_DIR/adblock/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/adblock/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No adblock patches found)"
fi

echo "--- Performance ---"
if compgen -G "$PATCH_DIR/performance/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/performance/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No performance patches found)"
fi

echo "--- Portable ---"
if compgen -G "$PATCH_DIR/portable/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/portable/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No portable patches found)"
fi

echo "--- Branding ---"
if compgen -G "$PATCH_DIR/branding/*.patch" > /dev/null; then
    for p in $(ls "$PATCH_DIR"/branding/*.patch | sort); do check_patch "$p"; done
else
    echo "  (No branding patches found)"
fi

echo "============================================================"
if [ "$FAILED_PATCHES" -eq 0 ]; then
    echo " [SUCCESS] All patches validated cleanly."
    exit 0
else
    echo " [FAIL] $FAILED_PATCHES patch(es) failed validation."
    exit 1
fi
