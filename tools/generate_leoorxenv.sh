#!/bin/sh
#
# Generate leoorxenv.sh for an installed LeooRexx prefix.
#
# Usage:
#   tools/generate_leoorxenv.sh /absolute/prefix
#
# Output:
#   /absolute/prefix/bin/leoorxenv.sh

set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /absolute/prefix" >&2
  exit 2
fi

prefix="$1"

case "$prefix" in
  /*)
    ;;
  *)
    echo "Error: prefix must be an absolute path: $prefix" >&2
    exit 2
    ;;
esac

template="tools/templates/leoorxenv.sh.in"
target="$prefix/bin/leoorxenv.sh"

if [ ! -f "$template" ]; then
  echo "Error: template not found: $template" >&2
  exit 1
fi

if [ ! -d "$prefix/bin" ]; then
  echo "Error: prefix bin directory not found: $prefix/bin" >&2
  exit 1
fi

sed "s|@prefix@|$prefix|g" "$template" > "$target"
chmod +x "$target"

echo "Generated: $target"

