#!/bin/sh

# LeooRexx source inventory helper.
# This script summarizes the current Leopard source cut tree.

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src/oorexx-3.2.0-leopard"

if [ ! -d "$SRC_DIR" ]; then
    echo "ERROR: Source cut not found: $SRC_DIR"
    exit 1
fi

echo "Source inventory for: $SRC_DIR"
echo

echo "Top-level entries:"
find "$SRC_DIR" -maxdepth 1 -mindepth 1 -print | sort
echo

echo "File counts by top-level directory:"
for dir in "$SRC_DIR"/*; do
    if [ -d "$dir" ]; then
        name="$(basename "$dir")"
        count="$(find "$dir" -type f | wc -l | tr -d ' ')"
        echo "$name: $count"
    fi
done
echo

echo "Source file counts:"
echo "C files:      $(find "$SRC_DIR" -type f -name '*.c' | wc -l | tr -d ' ')"
echo "C++ files:    $(find "$SRC_DIR" -type f -name '*.cpp' | wc -l | tr -d ' ')"
echo "Headers:      $(find "$SRC_DIR" -type f \( -name '*.h' -o -name '*.hpp' \) | wc -l | tr -d ' ')"
echo "Rexx files:   $(find "$SRC_DIR" -type f \( -name '*.rex' -o -name '*.orx' \) | wc -l | tr -d ' ')"
echo "Makefiles:    $(find "$SRC_DIR" -type f \( -name 'Makefile' -o -name 'Makefile.in' -o -name 'Makefile.am' \) | wc -l | tr -d ' ')"
echo

echo "Platform directories:"
find "$SRC_DIR" -type d \( -iname '*unix*' -o -iname '*windows*' -o -iname '*platform*' \) | sort

