# LEOOREXX-FIND-0001: LeoUTF8 external consumer proof

## Summary

LeooRexx can consume LeoUTF8 as an external Leopard-Crew brick.

This has been proven on Mac OS X 10.5.8 PowerPC by building and running a
standalone LeooRexx-side probe against the LeoUTF8 staged distribution.

This is not an ooRexx interpreter-core integration.

## Host

- System: Mac OS X 10.5.8 Leopard
- Architecture: PowerPC
- Consumer project: LeooRexx
- Provider project: LeoUTF8

## Provider Artifact

LeoUTF8 was consumed from:

~~~text
../LeoUTF8/dist/LeoUTF8
~~~

Expected provider layout:

~~~text
dist/LeoUTF8/
├── include/
│   └── LeoUTF8.h
└── lib/
    └── libLeoUTF8Core.a
~~~

## Consumer Probe

Probe source:

~~~text
Probe/LeoUTF8Consumer/leoo_utf8_consumer_probe.c
~~~

Build script:

~~~text
tools/build_leoutf8_consumer_probe.sh
~~~

## Run Command

From the LeooRexx project root:

~~~sh
./tools/build_leoutf8_consumer_probe.sh
~~~

## Confirmed Output

The probe successfully reported:

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

## What Is Proven

The LeooRexx repository can:

- find `LeoUTF8.h` from an external staged LeoUTF8 distribution
- link against `libLeoUTF8Core.a`
- call `LeoUTF8Version`
- validate UTF-8 byte input
- count Unicode codepoints
- normalize UTF-8 to NFD
- apply Unicode case folding
- release returned LeoUTF8 buffers with `LeoUTF8Free`

## What Is Not Proven

This finding does not prove:

- Rexx string model integration
- ooRexx interpreter-core UTF-8 support
- LeooRexx ADDRESS environment support
- Foundation/CoreFoundation bridge integration
- HFS+ filename policy integration
- public LeooRexx UTF-8 API readiness

## Architectural Meaning

This is the first confirmed brick-to-brick integration:

~~~text
LeoUTF8
  -> dist/LeoUTF8
  -> LeooRexx external consumer probe
~~~

The integration is deliberately external.

No ooRexx interpreter source code was modified.

## Policy

LeooRexx may consume LeoUTF8 as a separate capability brick.

Interpreter-core changes remain locked until:

- the boundary model is stable
- a private helper layer exists
- build workflow risk is acceptable
- UTF-8 semantics for Rexx strings are explicitly designed

## Status

Accepted as the first LeoUTF8 integration finding for LeooRexx.
