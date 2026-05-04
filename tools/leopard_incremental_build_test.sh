#!/bin/sh

# LeooRexx Leopard/PPC incremental build-and-smoke-test helper.
# This script reuses an existing build directory when possible.

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src/oorexx-3.2.0-leopard"
BUILD_ROOT="$ROOT_DIR/build-work"
BUILD_NAME="${1:-leoo-incremental}"
BUILD_DIR="$BUILD_ROOT/$BUILD_NAME"
PREFIX="$HOME/opt/leoo-oorexx-3.2.0-$BUILD_NAME"

echo "LeooRexx Leopard incremental build test"
echo "Root:   $ROOT_DIR"
echo "Source: $SRC_DIR"
echo "Build:  $BUILD_DIR"
echo "Prefix: $PREFIX"
echo

if [ ! -d "$SRC_DIR" ]; then
    echo "ERROR: Source cut not found: $SRC_DIR"
    exit 1
fi

SYSTEM_NAME="$(uname -s)"
MACHINE_NAME="$(uname -m)"

if [ "$SYSTEM_NAME" != "Darwin" ]; then
    echo "ERROR: This test must run on Darwin / Mac OS X."
    exit 1
fi

case "$MACHINE_NAME" in
    ppc|powerpc|Power*)
        ;;
    *)
        echo "ERROR: This test must run on PowerPC."
        exit 1
        ;;
esac

mkdir -p "$BUILD_ROOT"

if [ ! -d "$BUILD_DIR" ]; then
    echo "Creating build directory from source cut..."
    cp -R "$SRC_DIR" "$BUILD_DIR"
else
    echo "Reusing existing build directory."
fi

cd "$BUILD_DIR"

if [ ! -f Makefile ]; then
    echo "Configuring..."
    CC=/usr/bin/gcc \
    CXX=/usr/bin/g++ \
    CFLAGS="-Os -arch ppc -mmacosx-version-min=10.5" \
    CXXFLAGS="-Os -arch ppc -mmacosx-version-min=10.5" \
    ./configure --prefix="$PREFIX"
else
    echo "Makefile exists; skipping configure."
fi

echo "Building..."
make 2>&1 | tee "build-$BUILD_NAME.log"

echo "Testing self-built interpreter..."
./rexx -e "say 'LeooRexx incremental build test passed: $BUILD_NAME'"

echo "Running smoke test..."
REXX_BIN=./rexx "$ROOT_DIR/tools/smoke_test_oorexx.sh"

echo
echo "Incremental build test completed successfully."
echo "Build directory: $BUILD_DIR"
echo "Build log:       $BUILD_DIR/build-$BUILD_NAME.log"

