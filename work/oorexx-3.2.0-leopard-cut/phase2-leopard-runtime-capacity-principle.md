# Phase 2 Leopard Runtime Capacity Principle

## Principle

LeooRexx is not a generic multi-platform ooRexx build.

LeooRexx is a Leopard/PPC-specific runtime conductor. Its runtime and IPC capacity decisions must be measured against Mac OS X 10.5.8 Leopard, not against historical Linux/AIX/Solaris portability defaults.

## Current Finding

Darwin / Leopard reports high SysV semaphore capacity:

```text
kern.sysv.semmsl: 87381
kern.sysv.semmns: 87381
kern.sysv.semmni: 87381
````

The currently active LeooRexx compact profile uses:

```text
MAXSEM     = 48
MAXUTILSEM = 32
```

These values are not imposed by Leopard. They are inherited ooRexx runtime profile limits.

## Architectural Interpretation

The 48 / 32 limits are valid as a conservative baseline, but they must not be treated as final LeooRexx design limits.

LeooRexx should adopt a Leopard-specific runtime capacity profile if testing shows that higher limits are stable, clean, and system-conformant.

## Rule

Do not increase limits blindly.

Capacity must be raised only after controlled tests prove:

```text
- queue creation remains stable
- subcommand registry operations remain stable
- no SysV IPC residue is left behind
- rxdelipc remains able to clean up intentionally
- no runtime regressions appear in smoke tests
```

## Design Direction

Possible future profile:

```c
#define LEOOREXX_REXXAPI_LEOPARD_SEMAPHORE_LIMITS 1
```

This would replace the current compact inherited profile with a Leopard-measured profile.

## Conclusion

LeooRexx runtime capacity belongs to Leopard.

The conductor must know the real strength of its orchestra, not inherit the limits of a touring ensemble built for every stage.  

