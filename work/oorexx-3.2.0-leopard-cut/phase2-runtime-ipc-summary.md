# Phase 2 Runtime / IPC Summary

## Purpose

This document summarizes the Phase 2 runtime and IPC stabilization work for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2 focused on proving that the Leopard-cut ooRexx runtime can build cleanly and provide stable RexxAPI IPC behavior under repeatable runtime tests.

## Final Baseline

Current final Phase 2 baseline:

```text
MAXSEM     = 128
MAXUTILSEM = 64
````

Verified named queue capacity:

```text
63 named queues
```

## Confirmed Results

### Warning-Clean Build Baseline

The build was verified warning-clean after targeted cleanup work.

Resolved warning classes included:

```text
- NumberString unsigned comparison warnings
- extern initializer warnings
- MemorySegmentPool operator new warning
- RexxUtil NULL arithmetic warnings
```

### Runtime IPC Tool Baseline

The following runtime tools were confirmed present and executable from build output:

```text
rexx
rexxc
rxqueue
rxsubcom
rxdelipc
rxmigrate
```

### Queue Runtime Smoke

The queue runtime path was verified using created named queues.

Confirmed:

```text
- rxqueue FIFO writes into a created Rexx queue
- rxqueue LIFO writes into a created Rexx queue
- Rexx scripts can read back queued values correctly
- FIFO order is preserved
- LIFO order is preserved
```

### Subcommand Runtime Smoke

The subcommand registry path was verified.

Confirmed:

```text
- missing subcommand query returns expected non-zero result
- register succeeds
- query after register succeeds
- drop succeeds
- query after drop returns expected non-zero result
```

### Repeatability

Repeated runtime IPC operations were verified.

Confirmed:

```text
- queue create / write / read / delete works repeatedly
- subcommand register / query / drop works repeatedly
```

### Fresh RXHOME Anchor Bug

A separate bug was isolated:

```text
Fresh RXHOME anchor initialization can trigger an invalid runtime state / bus error.
```

This is not part of the verified default HOME-based runtime baseline and remains a separate follow-up issue.

### RexxAPI Reserved Semaphore Member

The RexxAPI semaphore set creation was corrected to include the reserved global API semaphore member.

Result:

```text
createsem(..., MAXSEM+1)
```

This ensures that queue semaphore member indexing has a valid reserved member available.

### Queue_Detach Final Cleanup

Queue_Detach final cleanup was corrected.

Fixed issues:

```text
- duplicate delete_queue_sem(current) call removed
- apidata->qbase == NULL comparison fixed to assignment
- apidata->qbasememId reset after queue memory pool removal
```

### Leopard Semaphore Capacity Profile

The compact Leopard RexxAPI semaphore profile was raised from:

```text
MAXSEM     = 48
MAXUTILSEM = 32
```

to:

```text
MAXSEM     = 128
MAXUTILSEM = 64
```

This was verified on Mac OS X 10.5.8 PowerPC.

### Queue Capacity Verification

With MAXSEM=128:

```text
CREATE_FAIL_AT=64
CREATED_TOTAL=63
DELETE_FAILURES=0
CREATE_AFTER_CLEANUP=LEOO_VERIFY_AFTER_CLEANUP
```

The verification was run twice back-to-back successfully.

## Capacity Formula

With:

```text
MAXSEM = 128
```

the available queue semaphore members are:

```text
1..128
```

The default SESSION queue consumes two semaphore members.

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

## Final Phase 2 Interpretation

Phase 2 establishes a stable Leopard runtime / IPC baseline.

The runtime is now verified for:

```text
- clean build output
- basic Rexx execution
- queue IPC
- subcommand registry IPC
- repeated IPC operations
- boundary queue creation
- clean deletion after boundary tests
- stable default HOME-based RexxAPI anchor behavior
```

## Remaining Known Issue

The fresh RXHOME anchor bug remains intentionally separate.

It should be investigated later as a dedicated issue and should not block the default Leopard runtime baseline.

## Conclusion

Phase 2 is complete.

LeooRexx now has a verified Leopard-specific runtime and IPC baseline suitable for continued Leopard-native integration work.  

