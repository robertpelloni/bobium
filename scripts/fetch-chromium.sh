#!/usr/bin/env bash
# fetch-chromium.sh
# Script to robustly set up depot_tools and fetch the 30GB+ Chromium source.
set -e

# Setup directories
BOBIUM_ROOT=$(pwd)
DEPOT_TOOLS_DIR="$BOBIUM_ROOT/depot_tools"
CHROMIUM_DIR="$BOBIUM_ROOT/chromium"

echo "=== bobium: Fetching Chromium Source ==="
echo "WARNING: This will download >30GB of data and take significant time."

# 1. Fetch or update depot_tools
if [ ! -d "$DEPOT_TOOLS_DIR" ]; then
    echo "Cloning depot_tools..."
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git "$DEPOT_TOOLS_DIR"
else
    echo "Updating depot_tools..."
    cd "$DEPOT_TOOLS_DIR"
    git pull
    cd "$BOBIUM_ROOT"
fi

export PATH="$PATH:$DEPOT_TOOLS_DIR"

# 2. Fetch Chromium source (or sync if it exists)
if [ ! -d "$CHROMIUM_DIR" ]; then
    mkdir -p "$CHROMIUM_DIR"
    cd "$CHROMIUM_DIR"
    echo "Initializing Chromium fetch (no hooks)..."
    fetch --nohooks chromium
else
    echo "Chromium directory exists. Syncing..."
    cd "$CHROMIUM_DIR/src"
    git fetch
fi

# 3. Run hooks to finalize with robust recovery loop
echo "Running gclient hooks (with auto-retry for network drops)..."
cd "$CHROMIUM_DIR/src"
MAX_RETRIES=3
RETRY_COUNT=0
while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    gclient runhooks && break || {
        RETRY_COUNT=$((RETRY_COUNT+1))
        echo "gclient runhooks failed. Retrying ($RETRY_COUNT/$MAX_RETRIES) in 10 seconds..."
        sleep 10
    }
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo "Error: gclient runhooks failed after maximum retries. Please check network/dependencies."
    exit 1
fi

echo "=== Chromium source fetched successfully! ==="
