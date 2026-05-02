# Phase 2.9 DESTDIR Install Behavior Result

## Purpose

This document records the Phase 2.9 DESTDIR install behavior test for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2.8 added automatic installation of:

```text
<prefix>/bin/leoorxenv.sh
````

Phase 2.9 verifies that this install hook behaves correctly with:

```sh
make install DESTDIR=<package-root> prefix=<runtime-prefix>
```

## Test Build Directory

```text
/Users/admin/Desktop/Projekte/LeooRexx/build-work/phase2_8-leoorxenv-install-hook-v2
```

## Test Variables

```sh
LEOO_DESTDIR="/tmp/leoorx-phase2_9-package-root"
LEOO_RUNTIME_PREFIX="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime"
```

## Install Command

```sh
make install DESTDIR="$LEOO_DESTDIR" prefix="$LEOO_RUNTIME_PREFIX" > install-phase2_9-destdir.log 2>&1
```

## Generated File

The install log confirmed:

```text
Generating /tmp/leoorx-phase2_9-package-root/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime/bin/leoorxenv.sh
```

The generated file exists at:

```text
/tmp/leoorx-phase2_9-package-root/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime/bin/leoorxenv.sh
```

Observed permissions:

```text
-rwxr-xr-x 1 admin wheel 428 ... leoorxenv.sh
```

## Direct Runtime Prefix Check

The file was not written directly to the runtime prefix:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime/bin/leoorxenv.sh
```

Observed result:

```text
no direct runtime leoorxenv.sh
```

This is correct for DESTDIR packaging.

## Generated Content

The generated staged file contains:

```sh
LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

This is correct.

The staged file is installed under:

```text
DESTDIR + prefix
```

but the runtime environment uses:

```text
prefix
```

without `DESTDIR`.

## Result

Phase 2.9 passed.

The `leoorxenv.sh` install hook is DESTDIR-safe for staged packaging.

## Packaging Note

The install log still contains libtool warnings such as:

```text
libtool: install: warning: remember to run `libtool --finish ...`
```

Some of these warnings reference the earlier configured/build prefix.

This does not affect the `leoorxenv.sh` DESTDIR behavior, but should be treated as a separate packaging follow-up if binary/package generation becomes a goal.

## Conclusion

The LeooRexx activation install chain is now verified for:

```text
direct prefix install
DESTDIR staged install
```

The generated activation script is installed in the correct staged location and contains the correct final runtime prefix.  

