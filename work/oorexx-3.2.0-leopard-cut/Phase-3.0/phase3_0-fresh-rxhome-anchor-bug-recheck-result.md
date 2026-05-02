# Phase 3.0 Fresh RXHOME Anchor Bug Recheck Result

## Purpose

This document records the Phase 3.0 recheck of the previously observed fresh `RXHOME` anchor initialization bug.

Earlier testing had shown a failure pattern when using a fresh custom `RXHOME` anchor file:

```text
q=
Bus error
rc=138
````

The purpose of this phase was to verify whether the bug is still reproducible on the current LeooRexx runtime/install baseline.

## Current Baseline

The recheck was performed after the following verified phases:

```text
phase2-runtime-ipc-baseline
phase2_5-install-prefix-smoke
phase2_6-installed-environment-contract
phase2_7-activation-packaging
phase2_8-leoorxenv-install-hook
phase2_9-destdir-install-behavior
```

Test prefix:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2
```

## Environment

The installed activation script was used:

```sh
. "$LEOO_PREFIX/bin/leoorxenv.sh"
```

Observed:

```text
LEOOREXX_HOME=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2
RXHOME=unset
DYLD_LIBRARY_PATH=unset
```

Tools resolved from the installed prefix:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rexx
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rxqueue
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/rxdelipc
```

## Clean IPC Baseline

Before testing, old LeooRexx IPC remnants were removed.

Clean baseline:

```text
Semaphores:
<empty>

Shared Memory:
m 65536 0x07021999 --rw-r--r-- root wheel
m 65537 0x60022006 --rw-r--r-- root wheel
```

Only unrelated root/wheel system shared-memory entries remained.

## Default HOME Control Test

Command:

```sh
unset RXHOME

rexx -e "say 'default HOME control start'; q=rxqueue('create','LEOO_DEFAULT_HOME_CONTROL'); say 'q='q; if q <> '' then call rxqueue 'delete', q; exit 0" </dev/null
```

Result:

```text
default HOME control start
q=LEOO_DEFAULT_HOME_CONTROL
default HOME control rc=0
```

Interpretation:

```text
The default HOME-based RexxAPI anchor path works on the current baseline.
```

## Fresh RXHOME Test

Fresh RXHOME anchor:

```sh
export RXHOME="/tmp/leoo-rxhome-fresh-current/rexxapi.anchor"

rm -rf /tmp/leoo-rxhome-fresh-current
mkdir -p /tmp/leoo-rxhome-fresh-current
: > "$RXHOME"
chmod 600 "$RXHOME"
```

Observed anchor file:

```text
-rw------- 1 admin wheel 0 ... /tmp/leoo-rxhome-fresh-current/rexxapi.anchor
```

Command:

```sh
rexx -e "say 'fresh RXHOME current start'; q=rxqueue('create','LEOO_RXHOME_FRESH_CURRENT'); say 'q='q; if q <> '' then call rxqueue 'delete', q; exit 0" </dev/null
```

Result:

```text
fresh RXHOME current start
q=LEOO_RXHOME_FRESH_CURRENT
fresh RXHOME current rc=0
```

IPC diff showed creation of matching semaphore and shared-memory keys:

```text
Semaphore:
s 786432 0x7205873a --ra-ra---- admin staff

Shared Memory:
m 655364 0x7205873a --rw-rw---- admin staff
```

Interpretation:

```text
The fresh RXHOME anchor initialized successfully.
No Bus error occurred.
The created semaphore and shared-memory anchor use the same key.
```

## Fresh RXHOME Repeat Test

Command:

```sh
rexx -e "say 'fresh RXHOME repeat start'; q=rxqueue('create','LEOO_RXHOME_FRESH_REPEAT'); say 'q='q; if q <> '' then call rxqueue 'delete', q; exit 0" </dev/null
```

Result:

```text
fresh RXHOME repeat start
q=LEOO_RXHOME_FRESH_REPEAT
fresh RXHOME repeat rc=0
```

IPC state remained consistent:

```text
Semaphore:
s 786432 0x7205873a --ra-ra---- admin staff

Shared Memory:
m 655364 0x7205873a --rw-rw---- admin staff
```

Interpretation:

```text
The fresh RXHOME anchor can also be reused successfully.
```

## Result

The previously observed fresh RXHOME anchor bug is not reproducible on the current baseline.

Current status:

```text
fresh RXHOME initialization: pass
fresh RXHOME reuse: pass
Bus error: not reproduced
rc=138 failure: not reproduced
```

## Likely Explanation

The bug was likely resolved indirectly by earlier runtime/IPC fixes, especially:

```text
- creating the RexxAPI semaphore set with the reserved member
- Queue_Detach final cleanup correction
- cleaner IPC baseline handling during testing
```

This is an inference based on observed behavior. No additional code patch was required in Phase 3.0.

## Conclusion

Phase 3.0 passed.

The fresh RXHOME anchor bug should be treated as:

```text
historical / resolved on current baseline / not reproducible
```

No immediate code change is required.  

