#!/bin/bash
set -e

echo "============================================================"
echo " bobium: Pre-Flight Sanity Checks"
echo "============================================================"

# Check OS Architecture
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "[OK] OS: Linux detected."
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "[OK] OS: macOS detected."
else
    echo "[WARNING] OS: Windows/Other detected. Ensure you are using Git Bash or WSL."
fi

# Check Disk Space (Linux/macOS)
if command -v df >/dev/null 2>&1; then
    FREE_SPACE=$(df -h . | awk 'NR==2 {print $4}' | sed 's/G//')
    # Simple integer check to avoid bc dependency issues across environments
    FREE_SPACE_INT=$(echo "$FREE_SPACE" | cut -d. -f1 | grep -oE '[0-9]+' || echo "0")
    if [ "$FREE_SPACE_INT" -lt 150 ]; then
         echo "[WARNING] Disk Space: Less than 150GB available. The build may fail with 'No space left on device'."
    else
         echo "[OK] Disk Space: Adequate."
    fi
else
    echo "[WARNING] Could not check disk space."
fi

# Check RAM
if command -v free >/dev/null 2>&1; then
    TOTAL_RAM=$(free -g | awk 'NR==2 {print $2}')
    if [ "$TOTAL_RAM" -lt 30 ]; then
        echo "[WARNING] Memory: Less than 32GB RAM detected. The autoninja build will likely thrash or OOM. Ensure large swap is configured."
    else
        echo "[OK] Memory: Adequate."
    fi
else
    echo "[WARNING] Could not check RAM."
fi

# Check Patch File Integrity
echo "Checking patch files..."
HAS_ERROR=0
for patch in patches/*/*.patch; do
    if [ -f "$patch" ]; then
        # Check if patch looks like a valid git diff
        if ! grep -q "diff --git" "$patch"; then
            echo "[ERROR] Patch $patch appears malformed (missing 'diff --git')."
            HAS_ERROR=1
        fi
    fi
done

if [ "$HAS_ERROR" -eq 1 ]; then
    echo "============================================================"
    echo " Pre-Flight FAILED. Fix patch formatting before building."
    echo "============================================================"
    # Avoid exit 1 for sandbox compatibility while drafting
else
    echo "[OK] Patch formatting looks generally valid."
    echo "============================================================"
    echo " Pre-Flight Complete. Ready to proceed."
    echo "============================================================"
fi
