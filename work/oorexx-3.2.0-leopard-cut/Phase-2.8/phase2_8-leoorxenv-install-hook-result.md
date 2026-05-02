# Phase 2.8 leoorxenv Install Hook Result

## Purpose

This document records the Phase 2.8 test result for installing `leoorxenv.sh` automatically during `make install`.

Phase 2.7 introduced:

```text
tools/templates/leoorxenv.sh.in
tools/generate_leoorxenv.sh
````

Phase 2.8 integrates the activation script into the install step.

## Buildsystem Integration

The install hook generates:

```text
<prefix>/bin/leoorxenv.sh
```

from:

```text
tools/templates/leoorxenv.sh.in
```

during `make install`.

The integration was added to:

```text
src/oorexx-3.2.0-leopard/Makefile.am
src/oorexx-3.2.0-leopard/Makefile.in
```

`Makefile.in` is intentionally updated together with `Makefile.am` so the legacy build flow does not depend on regenerating Autotools output during the test.

## Placeholder Correction

Initial test v1 installed the file, but the placeholder remained unresolved:

```sh
LEOOREXX_HOME="@prefix@"
```

This caused activation to fall back to existing system tools such as:

```text
/usr/bin/rexx
/usr/bin/rxqueue
```

Root cause:

```text
@prefix@ is an Autoconf-style placeholder and is unsafe for this template path.
```

The placeholder was changed to:

```text
__LEOOREXX_PREFIX__
```

After this correction, the install hook generated the correct prefix-specific file.

## Test Prefix

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2
```

## Generated File

Installed file:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/leoorxenv.sh
```

Generated content included:

```sh
LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

## Environment Reset

Before activation:

```sh
unset LEOOREXX_HOME
unset NLSPATH
unset DYLD_LIBRARY_PATH

PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH
```

## Activation Result

After sourcing the installed file:

```sh
. "$LEOO_PREFIX/bin/leoorxenv.sh"
```

Observed:

```text
LEOOREXX_HOME=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2
DYLD_LIBRARY_PATH=unset
```

Tool discovery:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rexx
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rxqueue
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rxsubcom
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rxdelipc
```

This confirms that the installed prefix is used and no fallback to `/usr/bin/rexx` occurs.

## Runtime Smoke

### rxqueue

```text
rxqueue --help

REX131: The syntax of the command is incorrect
install-hook v2 rxqueue rc=0
```

### rxsubcom

```text
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
install-hook v2 rxsubcom missing rc=30
```

## Result

Phase 2.8 install hook passed.

The build/install system now automatically installs a generated `leoorxenv.sh` into:

```text
<prefix>/bin/leoorxenv.sh
```

The generated file correctly activates the installed LeooRexx prefix using:

```text
LEOOREXX_HOME
PATH
NLSPATH
```

and does not require:

```text
DYLD_LIBRARY_PATH
```

## Remaining Follow-Up

`DESTDIR` packaging behavior should be verified separately.

The current Phase 2.8 result proves direct `prefix=... make install` behavior.  

