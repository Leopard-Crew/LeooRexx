# Phase 2 Queue Capacity Delete Verification Result

## Purpose

This document records the corrected queue capacity and delete verification result after the `MAXSEM+1` RexxAPI semaphore-set creation change and the queue detach cleanup correction.

## Test Build

```text
build-work/queue-detach-cleanup-test
````

## Clean IPC Baseline

Before the verification run, the LeooRexx IPC state was cleaned manually.

Expected remaining shared memory entries were only unrelated `root/wheel` system entries.

## Verification Script

The corrected test created named queues up to the current capacity boundary, deleted all successfully created queues, and then immediately attempted to create one additional queue.

The test was run twice back-to-back.

## First Run Result

```text
LeooRexx queue capacity delete verify start
MAX_ATTEMPT=60
CREATE_OK_AT=1 NAME=LEOO_VERIFY_QUEUE_1
CREATE_OK_AT=10 NAME=LEOO_VERIFY_QUEUE_10
CREATE_OK_AT=20 NAME=LEOO_VERIFY_QUEUE_20
CREATE_OK_AT=23 NAME=LEOO_VERIFY_QUEUE_23
CREATE_FAIL_AT=24
CREATED_TOTAL=23
DELETE_QUEUE=LEOO_VERIFY_QUEUE_23 RC=0
...
DELETE_QUEUE=LEOO_VERIFY_QUEUE_1 RC=0
DELETE_FAILURES=0
CREATE_AFTER_CLEANUP=LEOO_VERIFY_AFTER_CLEANUP
delete verify rc=0
```

## Second Run Result

```text
LeooRexx queue capacity delete verify start
MAX_ATTEMPT=60
CREATE_OK_AT=1 NAME=LEOO_VERIFY_QUEUE_1
CREATE_OK_AT=10 NAME=LEOO_VERIFY_QUEUE_10
CREATE_OK_AT=20 NAME=LEOO_VERIFY_QUEUE_20
CREATE_OK_AT=23 NAME=LEOO_VERIFY_QUEUE_23
CREATE_FAIL_AT=24
CREATED_TOTAL=23
DELETE_QUEUE=LEOO_VERIFY_QUEUE_23 RC=0
...
DELETE_QUEUE=LEOO_VERIFY_QUEUE_1 RC=0
DELETE_FAILURES=0
CREATE_AFTER_CLEANUP=LEOO_VERIFY_AFTER_CLEANUP
delete verify second rc=0
```

## IPC State After Verification

```text
Semaphores:
s 393216 0x72053308 --ra------- admin staff

Shared Memory:
m 393218 0x72053308 --rw------- admin staff
```

No additional queue-memory residue remained after the two verification runs.

## Interpretation

The earlier `CREATE_FAIL_AT=1` repeat failure was caused by a test-script bug.

The broken script attempted to delete literal stem names such as:

```text
CREATED.23
CREATED.22
...
```

instead of the actual queue names:

```text
LEOO_VERIFY_QUEUE_23
LEOO_VERIFY_QUEUE_22
...
```

As a result, the old script received delete return code `9` and left all created queues registered.

The corrected script confirms:

```text
- named queue creation succeeds up to 23 queues
- the 24th named queue fails at the current logical capacity boundary
- all 23 queues can be deleted successfully
- a new queue can be created immediately after cleanup
- the same test can be repeated successfully
```

## Capacity Explanation

With the compact Leopard semaphore profile:

```text
MAXSEM = 48
```

The queue semaphore members available for queues are effectively:

```text
1..48
```

The default session queue consumes two semaphore members.

Each named queue also consumes two semaphore members.

Therefore:

```text
48 queue semaphore members
- 2 session queue members
= 46 remaining members

46 / 2 = 23 named queues
```

So the current observed capacity is consistent with the implementation.

## Conclusion

The queue delete path for named queues is currently verified as reusable and stable under repeated boundary tests.

The remaining capacity limit is not a cleanup failure. It is the expected consequence of the current compact semaphore profile.

Future capacity expansion should raise `MAXSEM` intentionally for Leopard rather than relying on `MAXSEM+1` alone.  

