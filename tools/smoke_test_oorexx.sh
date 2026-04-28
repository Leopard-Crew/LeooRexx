#!/bin/sh

# LeooRexx ooRexx smoke test
# This script checks whether an installed ooRexx runtime can execute a basic Rexx script.

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPT="$ROOT_DIR/examples/hello.rexx"

echo "Checking for ooRexx runtime..."

if command -v rexx >/dev/null 2>&1; then
    REXX_BIN="$(command -v rexx)"
elif command -v orexx >/dev/null 2>&1; then
    REXX_BIN="$(command -v orexx)"
else
    echo "ERROR: No ooRexx executable found in PATH."
    echo "Expected: rexx or orexx"
    exit 1
fi

echo "Found: $REXX_BIN"
echo "Runtime version:"
"$REXX_BIN" -v || true

echo
echo "Running smoke test:"
"$REXX_BIN" "$SCRIPT"

echo
echo "Smoke test completed."

