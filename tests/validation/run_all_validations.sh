#!/bin/bash
# run_all_validations.sh - Executes the full bobium validation suite post-build

set -e

SCRIPT_DIR=$(dirname "$0")

echo "============================================================"
echo " bobium: Post-Build Validation Suite"
echo "============================================================"

"$SCRIPT_DIR/test_mv2_portable.sh"
"$SCRIPT_DIR/test_telemetry_performance.sh"
"$SCRIPT_DIR/verify_checksums.sh"

echo "============================================================"
echo " All Validations Passed. Build is certified."
echo "============================================================"
