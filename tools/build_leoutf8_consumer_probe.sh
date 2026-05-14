#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LEOUTF8_DIST="${LEOUTF8_DIST:-"$ROOT/../LeoUTF8/dist/LeoUTF8"}"

BUILD_DIR="$ROOT/build-work/leoutf8-consumer"
SOURCE="$ROOT/Probe/LeoUTF8Consumer/leoo_utf8_consumer_probe.c"
BINARY="$BUILD_DIR/leoo_utf8_consumer_probe"

CC="/usr/bin/gcc"

echo "LeooRexx LeoUTF8 consumer build"
echo "Root:         $ROOT"
echo "LeoUTF8 dist: $LEOUTF8_DIST"
echo "Source:       $SOURCE"
echo "Binary:       $BINARY"
echo

if [ ! -f "$LEOUTF8_DIST/include/LeoUTF8.h" ]; then
    echo "Missing LeoUTF8 header: $LEOUTF8_DIST/include/LeoUTF8.h" >&2
    echo "Run 'make dist' in the LeoUTF8 project first." >&2
    exit 1
fi

if [ ! -f "$LEOUTF8_DIST/lib/libLeoUTF8Core.a" ]; then
    echo "Missing LeoUTF8 core library: $LEOUTF8_DIST/lib/libLeoUTF8Core.a" >&2
    echo "Run 'make dist' in the LeoUTF8 project first." >&2
    exit 1
fi

mkdir -p "$BUILD_DIR"

"$CC" \
    -Os -arch ppc -mmacosx-version-min=10.5 \
    -std=c99 \
    -Wall -Wextra -pedantic \
    -I "$LEOUTF8_DIST/include" \
    "$SOURCE" \
    "$LEOUTF8_DIST/lib/libLeoUTF8Core.a" \
    -o "$BINARY"

echo
echo "Running LeooRexx LeoUTF8 consumer probe..."
"$BINARY"

echo
echo "LeooRexx LeoUTF8 consumer build completed successfully."
