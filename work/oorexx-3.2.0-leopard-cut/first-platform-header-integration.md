Goal:
Introduce LeooRexxPlatform.h into the active Leopard source cut without changing behavior.

Candidate:
kernel/platform/unix/PlatformDefinitions.h

First integration rule:
Include the new header, but do not replace legacy macros yet.

Validation:
Build must still complete.
./rexx -v must still work.
REXX_BIN=./rexx smoke test must still pass.

