# LeooRexx Future TODO Order

This document records deferred work that must happen later, in the correct order.

## 1. Finish source-level platform identity cleanup

Complete the remaining active plain `LINUX` / legacy platform guards in source files before touching the buildsystem identity.

Do not remove buildsystem-level `-DLINUX` while source code still relies on it.

## 2. Clean or classify active RexxAPI and RexUtils residues

Remaining areas:

```text
rexxapi/unix/*
rexutils/rxmath.cpp
rexutils/unix/rexxutil.cpp
````

Rules:

```text
- RexxAPI is closer to the LeooRexx system layer.
- RexUtils remains quarantine unless explicitly promoted.
- Cleanup does not imply core status.
```

## 3. Buildsystem platform identity cleanup

Only after source-level cleanup:

```text
configure.ac
configure
Makefile.am
Makefile.in
```

Goal:

```text
Stop emitting -DLINUX / -DOPSYS_LINUX for the Leopard/PPC source cut.
Replace them with explicit LeooRexx / Darwin / Leopard / PowerPC macros.
```

## 4. Baseline rebuild and smoke validation

After buildsystem cleanup, perform a clean Leopard/PPC rebuild and smoke test.

Expected checks:

```text
./rexx -v
./rexx -e "say ..."
tools/smoke_test_oorexx.sh
```

## 5. Runtime / IPC validation

After the buildsystem identity is clean and the runtime still builds:

### RexxAPI semaphore limits test

Validate whether the current compact semaphore limits are appropriate on Mac OS X Leopard / PowerPC:

```text
MAXSEM     = 48
MAXUTILSEM = 32
```

Questions:

```text
- Are 48/32 enough for normal LeooRexx usage?
- Do queue/subcommand/API operations fail under load?
- Does Leopard/Darwin impose different practical limits?
- Should LeooRexx keep compact limits or define Leopard-specific values?
```

This must be tested at runtime, not decided from compile success alone.

## 6. Runtime / IPC stress tests

Create focused tests for:

```text
rxqueue
rxsubcom
subcommand registration
queue creation/deletion
parallel Rexx processes
RexxWaitForTermination behavior
semaphore cleanup
```

## 7. Active built-tools audit

Decide which generated tools belong to the LeooRexx cut:

```text
rxmigrate
rxqueue
rxsubcom
rxdelipc
```

Possible decisions:

```text
- keep as core tool
- keep as optional tool
- quarantine
- exclude from V1
```

## 8. Dead-code and portability-residue scan

Only after platform identity and runtime/IPC behavior are stable:

Scan for code that is now dead, unreachable, or unnecessary because LeooRexx is no longer a portable multi-platform ooRexx tree.

Targets include:

```text
#if 0 blocks
commented legacy platform branches
OS/2-only residues
AIX/Sun/Linux fallback code
Windows-only leftovers outside vendor/quarantine
generic portability abstractions replaced by explicit Leopard behavior
```

## 9. Remove obsolete portability code carefully

Removal must happen after classification.

Rules:

```text
- do not remove code merely because it looks old
- do not remove quarantine code without an explicit quarantine decision
- every removal must have a build test
- risky removals need runtime tests
```

## 10. Final Leopard-only source cut review

After cleanup:

```text
- no active Linux platform identity
- no silent AIX fallback
- no generic portability lie in active code
- Darwin/Leopard/PowerPC intent is explicit
- quarantine boundaries are documented
```

## Principle

Do not confuse cleanup with promotion.

A quarantined component may be sanitized while still remaining outside the LeooRexx core.  

