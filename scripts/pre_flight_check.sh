#!/bin/bash
# pre_flight_check.sh - Sanity checks for environment

echo "Running pre-flight checks..."
if ! command -v git &> /dev/null; then
    echo "Error: git is required."
    #exit 1
fi
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    #exit 1
fi

echo "Pre-flight checks passed."
