# Phase 1 Baseline Build Result

## Purpose

This baseline build validates the completed Phase 1 platform identity cleanup.

It is not a single-patch test. It validates the consolidated Phase 1 state after:

```text
- active AIX/Linux POSIX proxy cleanup
- active OPSYS_LINUX cleanup
- active plain LINUX cleanup
- RexxAPI/RexxUtils quarantine sanitation
- configure.ac/configure cleanup
- removal of -DLINUX / -DOPSYS_LINUX from the Darwin build path
````

## Build

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh phase1-platform-identity-baseline
```

## Build Identity

The build no longer emits:

```text
-DLINUX
-DOPSYS_LINUX
```

The build now emits:

```text
-DLEOOREXX_BUILD_LEOPARD=1
-DLEOOREXX_BUILD_DARWIN=1
```

Observed counts in the baseline build log:

```text
-DLEOOREXX_BUILD_LEOPARD=1  522
-DLEOOREXX_BUILD_DARWIN=1   522
```

The build retains the correct system identity:

```text
ORX_SYS_STR="MACOSX"
ORX_SHARED_LIBRARY_EXT=".dylib"
```

## Generated Tools

The baseline build reaches the expected generated tools:

```text
rxmigrate
rxqueue
rxsubcom
rxdelipc
```

## Result

No Linux build defines are emitted for the Leopard/Darwin path.

The Phase 1 platform identity cleanup is validated at build level.

## Remaining Work

Per the future TODO order, do not remove dead code or portability residue yet.

Next phases:

```text
1. Build/runtime stabilization
2. Runtime/IPC validation
3. RexxAPI semaphore limits test
4. Active built-tools audit
5. Dead-code and portability-residue scan
```

## Conclusion

Phase 1 establishes a clean LeooRexx / Darwin / Leopard / PowerPC build identity.

Leopard no longer builds by pretending to be Linux.  

