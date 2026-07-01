#!/bin/bash
# test_telemetry_performance.sh - Validates Telemetry removal and VFS Tab Hibernation

set -e

SCRIPT_DIR=$(dirname "$0")
REPO_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)
TARGET_BIN="$REPO_ROOT/chromium/out/Release/chrome"
NET_LOG_PATH="/tmp/bobium_telemetry_test.json"

echo "[+] Running Telemetry and Tab Performance checks..."

if [ ! -f "$TARGET_BIN" ]; then
    echo "  -> ERROR: Target binary not found. Please compile first."
    exit 1
fi

echo "  -> Launching browser in headless mode to capture net-logs..."
"$TARGET_BIN" --headless --disable-gpu --log-net-log="$NET_LOG_PATH" --dump-dom https://example.com > /dev/null 2>&1 || true

if [ ! -f "$NET_LOG_PATH" ]; then
    echo "  -> ERROR: Failed to generate net-log."
    exit 1
fi

echo "  -> Parsing net-log for Google endpoint pings..."
BANNED_ENDPOINTS=("clients4.google.com" "update.googleapis.com" "safebrowsing.google.com" "gstatic.com")

ERROR_FOUND=0
for endpoint in "${BANNED_ENDPOINTS[@]}"; do
    if grep -q "$endpoint" "$NET_LOG_PATH"; then
        echo "    -> ERROR: Found $endpoint in network traffic. Telemetry patch failed!"
        ERROR_FOUND=1
    else
        echo "    -> Verifying $endpoint is unreachable/blocked... OK"
    fi
done

if [ "$ERROR_FOUND" -ne 0 ]; then
    echo "Failing suite due to telemetry leak."
    exit 1
fi

echo "  -> Telemetry verified blocked."

echo "  -> Triggering Tab Hibernation Simulation Python script..."
"$SCRIPT_DIR/simulate_tab_hibernation.py"

echo "[+] Telemetry & Tab Performance checks passed."
