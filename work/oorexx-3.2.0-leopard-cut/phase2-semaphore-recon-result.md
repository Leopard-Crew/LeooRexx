# Phase 2 Semaphore Recon Result

## Purpose

This document records the first semaphore reconnaissance pass for the LeooRexx Runtime / IPC layer.

The goal was not to stress limits yet, but to understand:

```text
- where MAXSEM / MAXUTILSEM are defined
- whether the compact LeooRexx semaphore profile is active
- what Darwin / Leopard reports as SysV semaphore limits
- whether the existing repeatability tests leave visible IPC residue
````

## Build Used

```text
build-work/warning-clean-baseline
```

## Source Limits

The active RexxAPI compact semaphore limits are defined through:

```text
src/oorexx-3.2.0-leopard/kernel/platform/leopard/LeooRexxPlatform.h
src/oorexx-3.2.0-leopard/rexxapi/unix/RexxAPIManager.h
```

The active marker is:

```c
#define LEOOREXX_REXXAPI_COMPACT_SEMAPHORE_LIMITS 1
```

The compact branch defines:

```text
MAXSEM     = 48
MAXUTILSEM = 32
```

## Darwin / Leopard System Limits

Command:

```sh
sysctl -a 2>/dev/null | grep -i 'sem' | head -100
```

Result:

```text
kern.sysv.semume: 10
kern.sysv.semmsl: 87381
kern.sysv.semmnu: 87381
kern.sysv.semmns: 87381
kern.sysv.semmni: 87381
kern.posix.sem.max: 10000
security.mac.sysvsem_enforce: 1
security.mac.posixsem_enforce: 1
```

Interpretation:

```text
The 48 / 32 limits are not imposed by Darwin / Leopard.
They are LeooRexx / ooRexx internal compact runtime limits.
```

## IPC State Before Repeat Test

Command:

```sh
ipcs -s
```

Result:

```text
IPC status from <running system> as of Sat May  2 10:58:07 CEST 2026
T     ID     KEY        MODE       OWNER    GROUP
Semaphores:
s  65536 0x72053308 --ra-------    admin    staff
```

## Repeat Test

Command:

```sh
./rexx leoo-queue-repeat.rexx </dev/null
```

Result:

```text
QUEUE_REPEAT_ITERATIONS=20
QUEUE_REPEAT_FAILURES=0
```

## IPC State After Repeat Test

Diff:

```diff
-IPC status from <running system> as of Sat May  2 10:58:07 CEST 2026
+IPC status from <running system> as of Sat May  2 10:59:21 CEST 2026
 T     ID     KEY        MODE       OWNER    GROUP
 Semaphores:
 s  65536 0x72053308 --ra-------    admin    staff
```

Interpretation:

```text
Only the timestamp changed.
The semaphore list remained stable.
```

## Conclusion

The controlled queue repeatability test does not leave additional visible SysV semaphore residue.

Darwin / Leopard provides far higher SysV semaphore capacity than the compact LeooRexx runtime profile currently uses.

The next step is to test the LeooRexx internal MAXSEM / MAXUTILSEM boundaries in controlled stages.  

