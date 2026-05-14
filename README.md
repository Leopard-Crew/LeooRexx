# LeooRexx

## LeoUTF8 Integration Status

LeooRexx can currently consume LeoUTF8 as an external Leopard-Crew brick.

This is a controlled external consumer proof, not an ooRexx interpreter-core integration.

Confirmed on Mac OS X 10.5.8 PowerPC:

~~~text
LeoUTF8
  -> dist/LeoUTF8
  -> LeooRexx external consumer probe
~~~

The probe verifies:

- LeoUTF8 header discovery
- linking against `libLeoUTF8Core.a`
- UTF-8 validation
- Unicode codepoint counting
- NFD normalization
- Unicode case folding
- LeoUTF8 buffer cleanup through `LeoUTF8Free`

Probe:

~~~text
Probe/LeoUTF8Consumer/leoo_utf8_consumer_probe.c
~~~

Build script:

~~~text
tools/build_leoutf8_consumer_probe.sh
~~~

Documentation:

~~~text
docs/integration/leoutf8-consumer.md
docs/findings/LEOOREXX-FIND-0001-leoutf8-external-consumer.md
~~~

This does not yet change Rexx string semantics and does not patch the ooRexx interpreter core.

