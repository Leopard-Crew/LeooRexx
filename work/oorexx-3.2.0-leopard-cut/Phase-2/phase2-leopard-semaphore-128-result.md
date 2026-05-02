# Phase 2 Leopard Semaphore 128 Result

## Purpose

This document records the verification result for the Leopard-specific RexxAPI compact semaphore capacity profile.

## Change Under Test

The compact Leopard RexxAPI semaphore profile was raised from:

```text
MAXSEM     = 48
MAXUTILSEM = 32
````

to:

```text
MAXSEM     = 128
MAXUTILSEM = 64
```

The RexxAPI semaphore set is created with the reserved global API member included.

## Test Build

```text
build-work/leopard-semaphore-128-test
```

## Clean IPC Baseline

Before testing, the old RexxAPI semaphore and shared-memory anchor were removed manually.

The remaining shared-memory entries were unrelated `root/wheel` system entries.

## Fresh Default Anchor Test

```text
leopard 128 fresh start
q=LEOO_128_FRESH_QUEUE
leopard 128 fresh rc=0
```

Result:

```text
PASS
```

A fresh default HOME-based RexxAPI anchor can be created with the new 128/64 capacity profile.

## Queue Capacity Delete Verification

The verification script used:

```text
MAX_ATTEMPT=80
```

The test was run twice back-to-back.

## First Run Result

```text
LeooRexx queue capacity delete verify start
MAX_ATTEMPT=80
CREATE_OK_AT=1 NAME=LEOO_VERIFY_QUEUE_1
CREATE_OK_AT=10 NAME=LEOO_VERIFY_QUEUE_10
CREATE_OK_AT=20 NAME=LEOO_VERIFY_QUEUE_20
CREATE_OK_AT=23 NAME=LEOO_VERIFY_QUEUE_23
CREATE_OK_AT=24 NAME=LEOO_VERIFY_QUEUE_24
CREATE_OK_AT=60 NAME=LEOO_VERIFY_QUEUE_60
CREATE_OK_AT=63 NAME=LEOO_VERIFY_QUEUE_63
CREATE_FAIL_AT=64
CREATED_TOTAL=63
DELETE_QUEUE=LEOO_VERIFY_QUEUE_63 RC=0
...
DELETE_QUEUE=LEOO_VERIFY_QUEUE_1 RC=0
DELETE_FAILURES=0
CREATE_AFTER_CLEANUP=LEOO_VERIFY_AFTER_CLEANUP
leopard 128 delete verify max80 rc=0
```

## Second Run Result

```text
LeooRexx queue capacity delete verify start
MAX_ATTEMPT=80
CREATE_OK_AT=1 NAME=LEOO_VERIFY_QUEUE_1
CREATE_OK_AT=10 NAME=LEOO_VERIFY_QUEUE_10
CREATE_OK_AT=20 NAME=LEOO_VERIFY_QUEUE_20
CREATE_OK_AT=23 NAME=LEOO_VERIFY_QUEUE_23
CREATE_OK_AT=24 NAME=LEOO_VERIFY_QUEUE_24
CREATE_OK_AT=60 NAME=LEOO_VERIFY_QUEUE_60
CREATE_OK_AT=63 NAME=LEOO_VERIFY_QUEUE_63
CREATE_FAIL_AT=64
CREATED_TOTAL=63
DELETE_QUEUE=LEOO_VERIFY_QUEUE_63 RC=0
...
DELETE_QUEUE=LEOO_VERIFY_QUEUE_1 RC=0
DELETE_FAILURES=0
CREATE_AFTER_CLEANUP=LEOO_VERIFY_AFTER_CLEANUP
leopard 128 delete verify max80 second rc=0
```

## IPC State After Verification

```text
Semaphores:
s 458752 0x72053308 --ra------- admin staff

Shared Memory:
m 458754 0x72053308 --rw------- admin staff
```

Only the normal RexxAPI default anchor remained.

No additional queue-memory residue was observed.

## Capacity Explanation

With:

```text
MAXSEM = 128
```

queue semaphore members are available as:

```text
1..128
```

The default `SESSION` queue consumes two semaphore members.

Each named queue consumes two semaphore members.

Therefore:

```text
128 total queue semaphore members
- 2 SESSION queue members
= 126 remaining members

126 / 2 = 63 named queues
```

The observed boundary is therefore correct:

```text
CREATE_FAIL_AT=64
CREATED_TOTAL=63
```

## Conclusion

The Leopard-specific compact semaphore profile with:

```text
MAXSEM     = 128
MAXUTILSEM = 64
```

is verified on Mac OS X 10.5.8 PowerPC for:

```text
- fresh default RexxAPI anchor creation
- 63 named queue capacity
- clean deletion of all created queues
- immediate queue creation after cleanup
- repeated boundary verification
- no additional IPC residue beyond the normal RexxAPI anchor
```

This profile is suitable as the next stable Leopard runtime capacity baseline.  

