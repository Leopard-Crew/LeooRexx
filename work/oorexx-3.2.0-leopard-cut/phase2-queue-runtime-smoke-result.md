# Phase 2 Queue Runtime Smoke Result

## Purpose

This document records the first positive RexxAPI queue runtime smoke test after Phase 1 platform identity cleanup and warning-clean baseline.

## Build Used

```text
build-work/warning-clean-baseline
````

## Environment

The build-directory runtime tools require the message catalog:

```sh
export NLSPATH="$PWD/%N:$PWD/%N.cat:$PWD/rexx.cat"
```

## Initial Findings

A naive external queue test using `rxqueue /FIFO SESSION` followed by `queued()` in a later Rexx process returned:

```text
QUEUED_BEFORE=0
```

This means the default `SESSION` queue behavior is not sufficient as a cross-process smoke test in this setup.

A safer and correct test pattern was taken from the original sample logic:

```rexx
newq = rxqueue('create', 'LEOO_TEST_QUEUE')
oldq = rxqueue('set', newq)
address sh "printf 'alpha\nbeta\n' | ./rxqueue /FIFO" newq
```

## FIFO Test

Result:

```text
LeooRexx created queue smoke start
NEW_QUEUE=LEOO_TEST_QUEUE
OLD_QUEUE=SESSION
RXQUEUE_RC=0
QUEUED_BEFORE=2
PULL=alpha
PULL=beta
QUEUED_AFTER=0
created queue smoke rc=0
```

Status:

```text
PASS
```

## LIFO Test

Result:

```text
LeooRexx created queue LIFO smoke start
NEW_QUEUE=LEOO_TEST_QUEUE_LIFO
OLD_QUEUE=SESSION
RXQUEUE_RC=0
QUEUED_BEFORE=2
PULL=beta
PULL=alpha
QUEUED_AFTER=0
created queue lifo smoke rc=0
```

Status:

```text
PASS
```

## Safety Notes

Do not use `parse pull` blindly in queue tests without checking `queued()` first.

If the queue is empty, `parse pull` can read from standard input and may accidentally consume following shell input during interactive testing.

Do not run `rxqueue` without explicit input or a safe operation. Without input, default FIFO behavior can block waiting for stdin.

## Interpretation

The following runtime path is confirmed working:

```text
Rexx rxqueue('create')
Rexx rxqueue('set')
external rxqueue /FIFO or /LIFO
Rexx queued()
Rexx parse pull
Rexx rxqueue('delete')
```

## Remaining Work

```text
- Investigate default SESSION queue behavior separately
- Add controlled queue smoke scripts under a tools/tests area later
- Continue toward RexxAPI semaphore limit tests
- Continue toward controlled subcommand registration/query/drop tests
```

## Conclusion

The LeooRexx warning-clean build has a working RexxAPI queue bridge for explicitly created named queues in both FIFO and LIFO modes.  

