# Phase 3.3 Semantic Residue Risk Map

## Purpose

This document maps the remaining semantic portability residue in the active RexxAPI IPC source area after Phase 3.2.

No source code is changed in this phase.

## Source Scan

Input scan:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.3/scans/remaining-active-ipc-semantic-residue.txt
````

## Summary

After Phase 3.2, the remaining IPC-area residue is no longer mostly typo/comment cleanup.

Most remaining hits are one of:

```text
- compile-time platform guards
- legacy fallback defines
- public/header guard names
- old commented-out conditional markers
- false-positive scan hits
```

Therefore, further cleanup must be semantic-risk-aware.

## Risk Class Legend

```text
R0 = cosmetic only
R1 = public identity / header guard risk
R2 = compile-time platform logic
R3 = runtime IPC / memory behavior risk
R4 = historical compatibility layer; leave until larger refactor
FP = false positive
```

## Item Map

### 1. MacroSpace.cpp historical module name / commented conditionals

Remaining examples:

```text
MacroSpace.cpp: //#ifdef AIX
MacroSpace.cpp: //#ifndef LINUX
```

Risk class:

```text
R1 / R2
```

Interpretation:

```text
These are commented-out historical conditionals. They may not compile, but they document old platform assumptions around macro-space behavior.
```

Recommendation:

```text
Do not remove casually.
Later classify MacroSpace.cpp separately.
```

Action:

```text
DEFER
```

### 2. QueuesAPI.cpp OPSYS_SUN branch

Remaining example:

```text
QueuesAPI.cpp: #if defined(OPSYS_SUN)
```

Risk class:

```text
R2
```

Interpretation:

```text
Compile-time platform branch. Even if irrelevant to Leopard, changing it modifies conditional source structure.
```

Recommendation:

```text
Leave until all active platform macros are normalized in one dedicated platform-identity phase.
```

Action:

```text
KEEP FOR NOW
```

### 3. QueuesAPI.cpp old LINUX markers

Remaining examples:

```text
QueuesAPI.cpp: this is for LINUX only...
QueuesAPI.cpp: //#ifdef LINUX
```

Risk class:

```text
R1 / R2
```

Interpretation:

```text
Some markers are comments, but they surround process/session cleanup logic. That area is runtime-sensitive.
```

Recommendation:

```text
Do not edit in a casual cleanup patch.
If cleaned later, treat as Queue_Detach documentation cleanup with runtime smoke tests.
```

Action:

```text
DEFER
```

### 4. rexx.h legacy AIX fallback define

Remaining example:

```text
#if !defined(AIX) && !LEOOREXX_PLATFORM_DARWIN
#define AIX /* Legacy fallback for non-LeooRexx Unix */
```

Risk class:

```text
R4
```

Interpretation:

```text
Ugly but explicit compatibility shim. It may protect non-LeooRexx Unix fallback behavior while excluding Darwin.
```

Recommendation:

```text
Leave until LeooRexx platform identity is fully separated from legacy Unix identity.
```

Action:

```text
KEEP
```

### 5. RexxAPIManager.cpp OPSYS_AIX41 branch

Remaining example:

```text
#ifndef OPSYS_AIX41
```

Risk class:

```text
R2 / R3
```

Interpretation:

```text
Compile-time branch inside RexxAPI manager code. This area controls shared runtime API behavior.
```

Recommendation:

```text
Do not touch without a dedicated experiment and full runtime smoke matrix.
```

Action:

```text
KEEP FOR NOW
```

### 6. RexxAPIManager.cpp “greater” scan hit

Remaining example:

```text
allocate a greater segment
```

Risk class:

```text
FP
```

Interpretation:

```text
False positive caused by grep pattern matching 'greate' inside 'greater'.
```

Recommendation:

```text
Ignore.
```

Action:

```text
IGNORE
```

### 7. RexxAPIManager.h LIMITED_SOLARIS_SEMS

Remaining example:

```text
#ifdef LIMITED_SOLARIS_SEMS
```

Risk class:

```text
R2 / R3
```

Interpretation:

```text
Semaphore capacity logic. Even if Solaris-specific by name, it is near MAXSEM and IPC capacity behavior.
```

Recommendation:

```text
Do not change in cleanup phase.
Any change requires capacity tests like the Phase 2 semaphore tests.
```

Action:

```text
KEEP
```

### 8. RexxAPIManager.h AIX branch comment

Remaining example:

```text
#else /* AIX */
```

Risk class:

```text
R2
```

Interpretation:

```text
Attached to semaphore capacity selection. Nearby logic is runtime-sensitive.
```

Recommendation:

```text
Leave until semaphore constants and platform capability detection are refactored deliberately.
```

Action:

```text
KEEP
```

### 9. SUBCOMCommand.cpp POSIX/AIX parameter note

Remaining example:

```text
#define SECOND_PARAMETER 1 /* different sign. POSIX/AIX */
```

Risk class:

```text
R0 / R1
```

Interpretation:

```text
Likely comment-only residue, but it documents command-line compatibility behavior.
```

Recommendation:

```text
Can be cleaned later, but not worth a dedicated patch unless grouped with SUBCOM documentation cleanup.
```

Action:

```text
LOW PRIORITY
```

### 10. SubcommandAPI.cpp AIX guard

Remaining example:

```text
#ifdef AIX
```

Risk class:

```text
R2
```

Interpretation:

```text
Compile-time branch inside subcommand API implementation.
```

Recommendation:

```text
Do not change until subcommand API platform behavior is separately mapped.
```

Action:

```text
KEEP FOR NOW
```

### 11. SubcommandAPI.h AIXSEAPI header guard

Remaining examples:

```text
#ifndef AIXSEAPI_HC_INCLUDED
#define AIXSEAPI_HC_INCLUDED
```

Risk class:

```text
R1
```

Interpretation:

```text
Header guard name is ugly but likely harmless. Changing it can create unnecessary churn in public-ish API headers.
```

Recommendation:

```text
Leave unless doing a deliberate public-header naming cleanup.
```

Action:

```text
KEEP
```

## Overall Recommendation

Do not continue blind cleanup in active IPC sources.

The safe comment-only residue has already been removed in Phase 3.2.

Remaining items should be split into separate future phases:

```text
Phase 3.x MacroSpace semantic map
Phase 3.x Queue_Detach documentation cleanup
Phase 3.x Platform macro identity refactor
Phase 3.x Public header guard naming review
Phase 3.x Semaphore capacity/platform capability review
```

## Safe Next Step

The next safe step is not code cleanup.

Recommended next phase:

```text
Phase 3.4: Build participation / source ownership map for rexxapi/unix
```

Purpose:

```text
Identify which rexxapi/unix files are active runtime core, CLI tools, public headers, or legacy support.
```

## Conclusion

Phase 3.3 confirms that the remaining active IPC residue is mostly semantic or identity-related.

Further cleanup requires targeted experiments and should not be done as broad text replacement.  
