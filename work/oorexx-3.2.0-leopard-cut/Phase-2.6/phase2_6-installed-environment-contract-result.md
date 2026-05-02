# Phase 2.6 Installed Environment Contract Result

## Purpose

This document records the Phase 2.6 installed environment contract result for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2.5 proved that LeooRexx works from an installed prefix when the runtime environment is set manually.

Phase 2.6 verifies a minimal activation contract for the installed command-line runtime.

## Test Prefix

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
````

## Environment Script

A test activation script was created at:

```text
<prefix>/bin/leoorxenv.sh
```

Content:

```sh
# LeooRexx environment for Mac OS X 10.5.8 PowerPC

LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

`DYLD_LIBRARY_PATH` was intentionally not set.

## Clean IPC Baseline

Before the test, no LeooRexx processes were running.

Initial IPC state:

```text
Semaphores:
<empty>

Shared Memory:
m 65536 0x07021999 --rw-r--r-- root wheel
m 65537 0x60022006 --rw-r--r-- root wheel
```

Only unrelated root/wheel system shared-memory entries were present.

## Environment Activation

The shell was reset with:

```sh
unset LEOOREXX_HOME
unset NLSPATH
unset DYLD_LIBRARY_PATH

PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH
```

Then the activation script was sourced:

```sh
. "$LEOO_PREFIX/bin/leoorxenv.sh"
```

Observed environment:

```text
LEOOREXX_HOME=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
NLSPATH=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/%N:/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/%N.cat:/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexx.cat
DYLD_LIBRARY_PATH=unset
```

Tool discovery:

```text
rexx     -> <prefix>/bin/rexx
rxqueue  -> <prefix>/bin/rxqueue
rxsubcom -> <prefix>/bin/rxsubcom
rxdelipc -> <prefix>/bin/rxdelipc
```

## Runtime Tool Smoke

### rexx

```text
rexx -v
Open Object Rexx Interpreter Version 3.2.0 for MACOSX
Build date: May  2 2026
env rexx -v rc=255
```

Interpretation:

```text
The installed interpreter prints version information correctly.
The rc=255 behavior is legacy tool behavior for this invocation and not an environment failure.
```

### rxqueue

```text
rxqueue --help
REX131: The syntax of the command is incorrect
env rxqueue help rc=0
```

Interpretation:

```text
rxqueue can find the installed message catalog through NLSPATH.
```

### rxsubcom

```text
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
env rxsubcom missing query rc=30
```

Interpretation:

```text
rxsubcom runs and returns the expected non-zero result for a missing registration.
```

### rxdelipc

```text
rxdelipc -h
env rxdelipc help rc=0
```

Interpretation:

```text
rxdelipc runs and prints help successfully.
```

## Queue Smoke Through Environment Contract

A Rexx script created a named queue, used installed `rxqueue` to write two lines, read the values back, and deleted the queue.

Result:

```text
env queue smoke start
NEW_QUEUE=LEOO_ENV_QUEUE
OLD_QUEUE=SESSION
RXQUEUE_RC=0
QUEUED_BEFORE=2
PULL=alpha
PULL=beta
QUEUED_AFTER=0
env queue smoke rc=0
```

Interpretation:

```text
The queue runtime path works through the activation script.
```

## Subcommand Smoke Through Environment Contract

The installed `rxsubcom` tool was tested through drop, query, register, query, drop, and query.

Result:

```text
env pre-clean DROP rc=30
env QUERY before REGISTER rc=30
env REGISTER rc=0
env QUERY after REGISTER rc=0
env DROP after REGISTER rc=0
env QUERY after DROP rc=30
```

Interpretation:

```text
The subcommand registry path works through the activation script.
```

## IPC State After Test

Final IPC state:

```text
Semaphores:
s 655360 0x72053308 --ra------- admin staff

Shared Memory:
m 524292 0x72053308 --rw------- admin staff
```

Interpretation:

```text
Only the normal RexxAPI anchor remained.
No additional private shared-memory residue was observed.
```

## Final Environment Contract

For the basic installed command-line runtime, the required environment is:

```sh
LEOOREXX_HOME="<prefix>"
PATH="$LEOOREXX_HOME/bin:$PATH"
NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
```

The basic installed CLI runtime does not require:

```sh
DYLD_LIBRARY_PATH
```

## Conclusion

Phase 2.6 passed.

The installed LeooRexx command-line runtime can be activated cleanly through a minimal environment script using:

```text
LEOOREXX_HOME
PATH
NLSPATH
```

This establishes the first installed runtime environment contract for LeooRexx on Mac OS X 10.5.8 PowerPC.  

