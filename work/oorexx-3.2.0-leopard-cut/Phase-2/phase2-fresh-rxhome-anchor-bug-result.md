# Phase 2 Fresh RXHOME Anchor Bug Result

## Purpose

This document records a controlled finding around fresh `RXHOME` anchor initialization.

The test was performed while investigating the RexxAPI queue semaphore boundary and the `MAXSEM+1` correction.

## Summary

A fresh `RXHOME` anchor crashes on the first `rxqueue('create')`.

This happens both in:

```text
- warning-clean-baseline
- semaphore-maxsem-plus-one-test
````

Therefore the fresh-anchor crash is not caused by the `MAXSEM+1` patch.

## Minimal Reproducer

```sh
mkdir -p /tmp/leoo-rxhome-control-warning-clean
: > /tmp/leoo-rxhome-control-warning-clean/rexxapi.anchor
export RXHOME="/tmp/leoo-rxhome-control-warning-clean/rexxapi.anchor"

./rexx -e "say 'warning-clean fresh start'; q=rxqueue('create','LEOO_WARNING_CLEAN_FRESH_QUEUE'); say 'q='q; if q <> '' then call rxqueue 'delete', q; exit 0" </dev/null
echo "warning-clean fresh RXHOME rc=$?"
```

## Observed Result

```text
warning-clean fresh start
q=
Bus error
warning-clean fresh RXHOME rc=138
```

## IPC Residue

The test left an additional SysV semaphore entry:

```diff
 Semaphores:
 s  65536 0x72053308 --ra-------    admin    staff
+s 262145 0x7205e13e --ra-ra----    admin    staff
```

The residue was removed manually with:

```sh
ipcrm -s 262145
```

## Interpretation

The crash is not a capacity-limit result.

It happens before any meaningful queue-capacity boundary is reached:

```text
CREATE_FAIL_AT=1
q=
Bus error
```

This indicates a fresh RexxAPI anchor initialization problem.

## Relationship to MAXSEM+1

The same behavior was observed before and after the `MAXSEM+1` semaphore-set creation change.

Therefore:

```text
Fresh RXHOME crash != MAXSEM+1 regression
```

The `MAXSEM+1` fix remains a separate candidate fix for the previously observed 24th queue invalid semaphore-member failure on the already-existing default RexxAPI anchor.

## Open Questions

```text
- Is the fresh anchor's shared memory fully initialized before queue creation?
- Does search_session() fail during first session queue creation?
- Does rxqueue('create') return an empty queue name because queue_allocate() fails?
- Does cleanup/detach access partially initialized queue memory and trigger the bus error?
- Does RXHOME-as-file behave differently from default HOME-derived anchor creation?
```

## Conclusion

Fresh `RXHOME` anchor initialization is currently unsafe and must be fixed or isolated before using `RXHOME` as a clean-room mechanism for capacity tests.  

