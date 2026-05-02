# Phase 2 Runtime / IPC Repeatability Result

## Purpose

This document records a small repeatability baseline for LeooRexx Runtime / IPC behavior after:

```text
- Phase 1 platform identity cleanup
- warning-clean baseline
- Runtime / IPC tool baseline
- Queue runtime smoke test
- Subcommand runtime smoke test
````

The goal was not to stress semaphore limits yet, but to verify that repeated clean create/register/delete cycles remain stable.

## Build Used

```text
build-work/warning-clean-baseline
```

## Environment

```sh
export NLSPATH="$PWD/%N:$PWD/%N.cat:$PWD/rexx.cat"
```

## Queue Repeatability Test

The queue test executed 20 cycles of:

```text
rxqueue('create')
rxqueue('set')
external rxqueue /FIFO
queued()
parse pull
rxqueue('delete')
restore previous queue
```

Result:

```text
QUEUE_REPEAT_ITERATIONS=20
QUEUE_REPEAT_FAILURES=0
queue repeat rc=0
```

Status:

```text
PASS
```

## Subcommand Registry Repeatability Test

The subcommand test executed 20 cycles of:

```text
DROP pre-clean
REGISTER
QUERY registered
DROP
QUERY dropped
```

Result:

```text
SUBCOM_REPEAT_ITERATIONS=20
SUBCOM_REPEAT_FAILURES=0
subcom repeat rc=0
```

Status:

```text
PASS
```

## Leopard Shell Note

The first attempted shell loop used:

```sh
seq 1 20
```

This failed on Leopard because `seq` was not available:

```text
-bash: seq: command not found
```

The valid test used a POSIX-style counter loop:

```sh
i=1
while [ "$i" -le 20 ]; do
  ...
  i=$((i + 1))
done
```

Future Leopard test scripts should avoid assuming GNU userland helpers such as `seq`.

## Interpretation

The basic IPC paths are stable across repeated clean operations:

```text
Queue create/write/read/delete x20
Subcommand register/query/drop x20
```

## Remaining Work

```text
- Controlled semaphore limit tests
- MAXSEM=48 / MAXUTILSEM=32 behavior validation
- Larger but still bounded queue/subcommand stress tests
- SESSION queue behavior classification
- Dynamic subcommand LOAD test with a deliberate minimal module
```

## Conclusion

LeooRexx Runtime / IPC behavior is repeatable for small controlled queue and subcommand registry cycles on the warning-clean Leopard/PPC build.  
