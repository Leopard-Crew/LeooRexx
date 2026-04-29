#!/bin/sh

# LeooRexx platform residue scanner.
# This script scans the current Leopard source cut for foreign platform markers.

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src/oorexx-3.2.0-leopard"
OUT_DIR="$ROOT_DIR/work/oorexx-3.2.0-leopard-cut/audit"
OUT_FILE="$OUT_DIR/platform-residue-scan.txt"

if [ ! -d "$SRC_DIR" ]; then
    echo "ERROR: Source cut not found: $SRC_DIR"
    exit 1
fi

mkdir -p "$OUT_DIR"

{
    echo "LeooRexx platform residue scan"
    echo "Source: $SRC_DIR"
    echo

    echo "Marker counts:"
    echo "WINDOWS/WIN32: $(grep -R -I -E 'WINDOWS|WIN32|_WIN32|platform/windows' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo "OS/2/OS2/PM/Dos*: $(grep -R -I -E 'OS/2|OS2|Presentation Manager|WinInitialize|DosGet|DosSet|DosUnset|DosAlloc|DosFree' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo "AIX: $(grep -R -I -E 'AIX|OPSYS_AIX' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo "SUN/SOLARIS: $(grep -R -I -E 'SUN|OPSYS_SUN|SOLARIS|SunOS' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo "LINUX/OPSYS_LINUX: $(grep -R -I -E 'LINUX|OPSYS_LINUX' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo "DARWIN/MACOSX: $(grep -R -I -E 'DARWIN|darwin|MACOSX|Mac OS X|MacOSX' "$SRC_DIR" | wc -l | tr -d ' ')"
    echo

    echo "Platform directories:"
    find "$SRC_DIR" -type d \( \
        -iname '*windows*' -o \
        -iname '*unix*' -o \
        -iname '*platform*' \
    \) | sort
    echo

    echo "Foreign platform files:"
    find "$SRC_DIR" -type f \( \
        -iname '*windows*' -o \
        -iname '*win32*' -o \
        -iname '*.bat' -o \
        -iname '*aix*' -o \
        -iname '*sun*' \
    \) | sort
    echo

    echo "Top LINUX/OPSYS_LINUX hit files:"
    grep -R -I -l -E 'LINUX|OPSYS_LINUX' "$SRC_DIR" \
        | sed "s|$SRC_DIR/||" \
        | sort \
        | head -100
} > "$OUT_FILE"

cat "$OUT_FILE"

