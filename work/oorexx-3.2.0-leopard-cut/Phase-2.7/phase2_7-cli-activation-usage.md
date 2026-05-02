# Phase 2.7 CLI Activation Usage

## Purpose

This document describes the current command-line activation model for an installed LeooRexx prefix on Mac OS X 10.5.8 PowerPC.

It is based on the verified Phase 2.6 installed environment contract.

## Installed Prefix

Current tested prefix:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
````

## Activation Script

Current tested activation file:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

## Activate LeooRexx in Terminal

Use:

```sh
. /Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

This sets:

```sh
LEOOREXX_HOME="<prefix>"
PATH="$LEOOREXX_HOME/bin:$PATH"
NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
```

## Verify Activation

After activation:

```sh
echo "$LEOOREXX_HOME"
which rexx
which rxqueue
which rxsubcom
which rxdelipc
```

Expected:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
<prefix>/bin/rexx
<prefix>/bin/rxqueue
<prefix>/bin/rxsubcom
<prefix>/bin/rxdelipc
```

## Basic Runtime Checks

```sh
rexx -v
rxqueue --help
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
rxdelipc -h
```

Expected behavior:

```text
rexx -v prints version information.
rxqueue --help reports REX131 and returns rc=0.
rxsubcom missing query returns rc=30.
rxdelipc -h prints help and returns rc=0.
```

## DYLD_LIBRARY_PATH

For the verified basic command-line runtime:

```text
DYLD_LIBRARY_PATH is not required.
```

Do not set it globally for normal CLI use.

If extension loading or embedding later proves that a library path is needed, that must be handled as a separate runtime contract.

## Queue Smoke Example

```sh
cat > /tmp/leoo-cli-queue-smoke.rexx <<'SCRIPT'
/* LeooRexx CLI queue smoke test */

say "cli queue smoke start"

newq = rxqueue('create', 'LEOO_CLI_QUEUE')
say "NEW_QUEUE=" || newq

oldq = rxqueue('set', newq)
say "OLD_QUEUE=" || oldq

address sh "printf 'alpha\nbeta\n' | rxqueue /FIFO" newq
say "RXQUEUE_RC=" || rc

say "QUEUED_BEFORE=" || queued()

do while queued() > 0
  parse pull line
  say "PULL=" || line
end

say "QUEUED_AFTER=" || queued()

call rxqueue 'delete', newq
call rxqueue 'set', oldq

exit 0
SCRIPT

rexx /tmp/leoo-cli-queue-smoke.rexx </dev/null
echo "cli queue smoke rc=$?"
```

Expected result:

```text
cli queue smoke start
NEW_QUEUE=LEOO_CLI_QUEUE
OLD_QUEUE=SESSION
RXQUEUE_RC=0
QUEUED_BEFORE=2
PULL=alpha
PULL=beta
QUEUED_AFTER=0
cli queue smoke rc=0
```

## Subcommand Smoke Example

```sh
rxsubcom DROP LEOO_CLI_SUBCOM fake_cli_subcom.dylib >/dev/null 2>&1
echo "cli pre-clean DROP rc=$?"

rxsubcom QUERY LEOO_CLI_SUBCOM fake_cli_subcom.dylib >/dev/null 2>&1
echo "cli QUERY before REGISTER rc=$?"

rxsubcom REGISTER LEOO_CLI_SUBCOM fake_cli_subcom.dylib FakeEntryPoint
echo "cli REGISTER rc=$?"

rxsubcom QUERY LEOO_CLI_SUBCOM fake_cli_subcom.dylib
echo "cli QUERY after REGISTER rc=$?"

rxsubcom DROP LEOO_CLI_SUBCOM fake_cli_subcom.dylib
echo "cli DROP after REGISTER rc=$?"

rxsubcom QUERY LEOO_CLI_SUBCOM fake_cli_subcom.dylib >/dev/null 2>&1
echo "cli QUERY after DROP rc=$?"
```

Expected result:

```text
cli pre-clean DROP rc=30
cli QUERY before REGISTER rc=30
cli REGISTER rc=0
cli QUERY after REGISTER rc=0
cli DROP after REGISTER rc=0
cli QUERY after DROP rc=30
```

## Design Rule

The CLI activation model is local and explicit.

It does not require:

```text
- global shell profile changes
- global DYLD_LIBRARY_PATH
- system-wide hacks
```

Optional shell profile integration may be offered later as user convenience, but it is not part of the required architecture.

## Status

```text
CLI activation usage: documented
Basic CLI environment: verified
DYLD_LIBRARY_PATH for basic CLI: not required
```

