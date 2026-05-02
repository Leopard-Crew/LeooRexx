# Phase 2.5 Install / Prefix Smoke Result

## Purpose

This document records the Phase 2.5 install / prefix smoke result for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2 verified runtime and IPC behavior from build output.

Phase 2.5 verifies that the same runtime works from a clean installed Leopard prefix.

## Build Directory

```text
build-work/phase2_5-install-prefix-smoke
````

## Build Warning Check

```text
No warnings.
```

## Install Prefix

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
```

## Install Result

```text
install rc=0
```

`make install` completed successfully.

## Installed Runtime Layout

The following required installed files were present:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexx
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexx.cat
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexxc
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rxdelipc
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rxmigrate
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rxqueue
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rxsubcom
```

Additional installed runtime files included:

```text
oorexx-config
rexx.img
rxftp.cls
rxregexp.cls
```

## Installed Environment

The installed runtime was tested with:

```text
PATH=<prefix>/bin:$PATH
NLSPATH=<prefix>/bin/%N:<prefix>/bin/%N.cat:<prefix>/bin/rexx.cat
```

## Installed `rexx -v`

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexx
Open Object Rexx Interpreter Version 3.2.0 for MACOSX
Build date: May  2 2026
```

Result:

```text
installed rexx rc=255
```

Interpretation:

```text
The installed interpreter prints version information correctly.
The rc=255 behavior is legacy tool behavior for this invocation and not an install failure.
```

## Installed `rxqueue` Catalog Smoke

```text
rxqueue --help
REX131: The syntax of the command is incorrect
installed rxqueue help rc=0
```

Result:

```text
PASS
```

The installed `rxqueue` can find the installed message catalog.

## Installed `rxsubcom` Missing Query Smoke

```text
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
installed rxsubcom missing query rc=30
```

Result:

```text
PASS
```

The missing registration query returns the expected non-zero result.

## Installed `rxdelipc -h`

```text
rxdelipc -h
installed rxdelipc help rc=0
```

Result:

```text
PASS
```

The installed IPC cleanup helper runs and prints help successfully.

## Installed Queue Smoke

A Rexx script created a named queue, wrote two lines through installed `rxqueue`, read them back, and deleted the queue.

Result:

```text
installed queue smoke start
NEW_QUEUE=LEOO_INSTALLED_QUEUE
OLD_QUEUE=SESSION
RXQUEUE_RC=0
QUEUED_BEFORE=2
PULL=alpha
PULL=beta
QUEUED_AFTER=0
installed queue smoke rc=0
```

Interpretation:

```text
The installed queue runtime path works.
```

## Installed Subcommand Smoke

The installed `rxsubcom` tool was tested through drop, query, register, query, drop, and query.

Result:

```text
subcom-only pre-clean DROP rc=30
subcom-only QUERY before REGISTER rc=30
subcom-only REGISTER rc=0
subcom-only QUERY after REGISTER rc=0
subcom-only DROP after REGISTER rc=0
subcom-only QUERY after DROP rc=30
```

Interpretation:

```text
The installed subcommand registry path works.
```

## Isolated IPC Check: Queue Smoke

After running only the installed queue smoke, the IPC state was:

```text
Semaphores:
s 524288 0x72053308 --ra------- admin staff

Shared Memory:
m 393220 0x72053308 --rw------- admin staff
```

Interpretation:

```text
Only the normal RexxAPI anchor remained.
No additional queue-memory residue was observed.
```

## Isolated IPC Check: Subcommand Smoke

After running only the installed subcommand smoke, the IPC state was:

```text
Semaphores:
s 589824 0x72053308 --ra------- admin staff

Shared Memory:
m 458756 0x72053308 --rw------- admin staff
```

Interpretation:

```text
Only the normal RexxAPI anchor remained.
No additional private shared-memory residue was observed.
```

## Conclusion

Phase 2.5 install / prefix smoke passed.

LeooRexx now works from a clean installed Leopard prefix for:

```text
- installed interpreter startup
- installed message catalog lookup
- installed rxqueue tool behavior
- installed rxsubcom registry behavior
- installed rxdelipc helper behavior
- installed queue IPC smoke
- installed subcommand IPC smoke
```

The installed runtime behaves consistently with the Phase 2 build-work runtime baseline.

