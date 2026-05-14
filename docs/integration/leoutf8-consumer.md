# LeooRexx LeoUTF8 External Consumer Probe

## Status

This document describes the first external LeoUTF8 consumer proof in the LeooRexx repository.

This is not an ooRexx interpreter-core integration.

It is an external build probe that verifies that LeooRexx can consume LeoUTF8 as a separate Leopard-Crew brick.

## What Is Proven

The probe proves that LeooRexx can consume:

~~~text
../LeoUTF8/dist/LeoUTF8/include/LeoUTF8.h
../LeoUTF8/dist/LeoUTF8/lib/libLeoUTF8Core.a
~~~

from an external project context.

Confirmed behavior:

- LeoUTF8 header is found
- LeoUTF8 static library links
- UTF-8 validation works
- Unicode codepoint counting works
- NFD normalization works
- Unicode case folding works
- returned LeoUTF8 buffers can be released with `LeoUTF8Free`
- probe builds and runs on Mac OS X 10.5.8 PowerPC

## What This Is Not

This is not:

- a Rexx string model change
- an ooRexx interpreter patch
- UTF-8 semantics inside Rexx objects
- an ADDRESS environment
- a public LeooRexx UTF-8 API
- HFS+ filename policy
- Foundation or CoreFoundation integration

## Probe Location

~~~text
Probe/LeoUTF8Consumer/leoo_utf8_consumer_probe.c
~~~

## Build Script

~~~text
tools/build_leoutf8_consumer_probe.sh
~~~

## Prerequisite

Build and stage LeoUTF8 first:

~~~sh
cd /Users/admin/Desktop/Projekte/LeoUTF8
make clean
make
make check
make dist
~~~

This creates:

~~~text
/Users/admin/Desktop/Projekte/LeoUTF8/dist/LeoUTF8
~~~

## Running The Probe

From LeooRexx:

~~~sh
cd /Users/admin/Desktop/Projekte/LeooRexx
./tools/build_leoutf8_consumer_probe.sh
~~~

## Expected Result

Successful output includes:

~~~text
LeooRexx LeoUTF8 consumer probe
LeoUTF8 version: 2.11.3
validate sample: OK
count sample codepoints: OK
normalize sample to NFD: OK
casefold sample: OK
LeooRexx LeoUTF8 consumer probe passed.
LeooRexx LeoUTF8 consumer build completed successfully.
~~~

## Design Meaning

This confirms the first real brick-to-brick integration:

~~~text
LeoUTF8
  -> dist/LeoUTF8
  -> LeooRexx external consumer probe
~~~

This keeps the integration deliberately outside the ooRexx interpreter core.

## Next Possible Steps

Possible next steps:

- add this probe to a broader LeooRexx probe script
- add a Foundation/CoreFoundation consumer probe later if needed
- design a private LeooRexx UTF-8 helper layer
- keep interpreter-core changes locked until the boundary model is stable
