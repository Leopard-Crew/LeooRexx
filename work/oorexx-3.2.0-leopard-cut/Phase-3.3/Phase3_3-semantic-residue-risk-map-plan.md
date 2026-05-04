# Phase 3.3 Semantic Residue Risk Map Plan

## Purpose

Phase 3.3 maps the remaining semantic portability residue in the active RexxAPI IPC area.

Phase 3.1 scanned and classified portability residue.
Phase 3.2 removed only safe comment-level residue.

Phase 3.3 does not change source code.

Its purpose is to decide what remaining residue is harmless, risky, or structurally important.

## Current Baseline

Phase 3.3 starts after:

```text
phase3_2-active-ipc-comment-cleanup
````

The verified baseline includes:

```text
- runtime IPC baseline
- install prefix smoke
- environment activation contract
- make install leoorxenv hook
- DESTDIR behavior
- fresh RXHOME recheck
- active IPC comment cleanup
```

## Scope

Primary scope:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/
```

Important remaining items include:

```text
MacroSpace.cpp AIX/LINUX markers
QueuesAPI.cpp OPSYS_SUN / LINUX markers
rexx.h legacy AIX fallback define
RexxAPIManager.cpp OPSYS_AIX41
RexxAPIManager.h LIMITED_SOLARIS_SEMS / AIX branch
SUBCOMCommand.cpp POSIX/AIX parameter note
SubcommandAPI.cpp AIX guard
SubcommandAPI.h AIXSEAPI header guard
```

## Risk Classes

### Class R0: Cosmetic Only

Safe to change after local inspection.

Examples:

```text
comments that do not describe active conditional behavior
typos
historical filenames in comments
```

### Class R1: Public Identity / Header Guard Risk

Should not be changed casually.

Examples:

```text
AIXSEAPI_HC_INCLUDED
legacy include guard names
public header naming conventions
```

Risk:

```text
May affect include behavior or external compatibility assumptions.
```

### Class R2: Compile-Time Platform Logic

High caution.

Examples:

```text
#ifdef AIX
#ifndef OPSYS_AIX41
#if defined(OPSYS_SUN)
#ifdef LIMITED_SOLARIS_SEMS
```

Risk:

```text
May alter compiled code path even if names look obsolete.
```

### Class R3: Runtime IPC / Memory Behavior

Do not touch without dedicated experiment.

Examples:

```text
semaphore capacity logic
shared memory attach/detach behavior
queue cleanup behavior
RXHOME anchor behavior
```

Risk:

```text
Can destabilize the verified runtime baseline.
```

### Class R4: Leave As Historical Compatibility Layer

Keep until a larger platform identity refactor exists.

Examples:

```text
#define AIX as legacy fallback for non-LeooRexx Unix
```

Risk:

```text
Ugly naming, but potentially load-bearing.
```

## Deliverables

Phase 3.3 should produce:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.3/phase3_3-semantic-residue-risk-map.md
```

Optionally:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.3/scans/
```

## Non-Goals

Phase 3.3 does not:

```text
- edit source code
- rename macros
- remove guards
- alter public headers
- change build behavior
- change runtime behavior
```

## Success Criteria

Phase 3.3 succeeds if each remaining active IPC residue item is assigned:

```text
- file
- line/context
- current meaning
- risk class
- recommendation
```

## Status

```text
planned
```

