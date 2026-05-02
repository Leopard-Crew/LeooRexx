# Phase 2.9 DESTDIR Install Behavior Plan

## Purpose

Phase 2.9 verifies DESTDIR behavior for the LeooRexx install hook added in Phase 2.8.

Phase 2.8 proved that direct prefix installation generates:

```text
<prefix>/bin/leoorxenv.sh
````

Phase 2.9 verifies staged packaging behavior:

```sh
make install DESTDIR=<package-root> prefix=<runtime-prefix>
```

## Expected Behavior

The generated file must be installed into the package root:

```text
<DESTDIR><prefix>/bin/leoorxenv.sh
```

But its runtime content must still use the final runtime prefix:

```sh
LEOOREXX_HOME="<prefix>"
```

not:

```sh
LEOOREXX_HOME="<DESTDIR><prefix>"
```

## Example

Command:

```sh
make install DESTDIR=/tmp/leoorx-package-root prefix=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime
```

Expected generated file:

```text
/tmp/leoorx-package-root/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime/bin/leoorxenv.sh
```

Expected content:

```sh
LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_9-destdir-runtime"
```

## Non-Goal

This phase does not run the staged runtime from DESTDIR.

DESTDIR is a packaging root, not the final runtime location.

Runtime execution from a real prefix was already verified in Phase 2.8.

## Success Criteria

Phase 2.9 succeeds if:

```text
- make install with DESTDIR returns rc=0
- leoorxenv.sh is created under DESTDIR + prefix
- leoorxenv.sh contains the runtime prefix without DESTDIR
- no leoorxenv.sh is accidentally written directly to the runtime prefix during staged install
```

