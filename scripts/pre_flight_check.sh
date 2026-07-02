#!/bin/bash
# pre_flight_check.sh - Validates strict heavy-compute hardware prerequisites for Chromium compilation
set -e

echo "============================================================"
echo " bobium: Pre-Flight Hardware Check"
echo "============================================================"

# 1. Dependency Checks
echo "-> Checking dependencies..."
for cmd in git python3; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "  [FAIL] Required command '$cmd' is missing."
        exit 1
    fi
done
echo "  [OK] Dependencies found."

# 2. Disk Space Check (>150GB required)
# We check the current working directory mount.
echo "-> Checking available disk space..."
AVAILABLE_DISK_KB=$(df -k . | awk 'NR==2 {print $4}')
AVAILABLE_DISK_GB=$((AVAILABLE_DISK_KB / 1024 / 1024))
REQUIRED_DISK_GB=150

if [ "$AVAILABLE_DISK_GB" -lt "$REQUIRED_DISK_GB" ]; then
    echo "  [FAIL] Only ${AVAILABLE_DISK_GB}GB free. ${REQUIRED_DISK_GB}GB is strictly required to compile Chromium."
    exit 1
fi
echo "  [OK] ${AVAILABLE_DISK_GB}GB free space available."

# 3. RAM Check (>16GB required, 32GB recommended)
echo "-> Checking system memory..."
if [ "$(uname)" = "Darwin" ]; then
    TOTAL_RAM_BYTES=$(sysctl hw.memsize | awk '{print $2}')
    TOTAL_RAM_GB=$((TOTAL_RAM_BYTES / 1024 / 1024 / 1024))
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    TOTAL_RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    TOTAL_RAM_GB=$((TOTAL_RAM_KB / 1024 / 1024))
else
    # Assume Windows WSL/GitBash environments might not parse trivially here, output a warning
    TOTAL_RAM_GB=32
    echo "  [WARN] OS not directly parsed for RAM. Assuming adequate memory."
fi

REQUIRED_RAM_GB=16
if [ "$TOTAL_RAM_GB" -lt "$REQUIRED_RAM_GB" ]; then
    echo "  [FAIL] Only ${TOTAL_RAM_GB}GB RAM detected. A minimum of ${REQUIRED_RAM_GB}GB is required (32GB+ recommended) to prevent OOM errors during linking."
    exit 1
fi
echo "  [OK] ${TOTAL_RAM_GB}GB RAM detected."

echo "============================================================"
echo " Pre-flight checks passed! Ready for fetch & compilation."
echo "============================================================"
