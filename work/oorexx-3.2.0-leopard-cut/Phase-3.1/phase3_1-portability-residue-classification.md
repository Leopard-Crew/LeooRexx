# Phase 3.1 Portability Residue Classification

## Purpose

This document classifies the raw portability-residue scans captured in Phase 3.1.

Phase 3.1 is read-only.

No code is removed in this phase.

## Raw Scan Inputs

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/platform-macro-residue.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/linux-name-residue.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/windows-os2-residue.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/legacy-unix-residue.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/buildsystem-residue.txt
````

## High-Level Result

The scan shows four different residue classes:

```text
1. Generated Autotools / Libtool noise
2. Distribution / source-package baggage
3. Inactive foreign platform source trees
4. Active Unix-source conditional residue
```

Only class 4 should be considered for careful source cleanup in the near term.

Classes 1 to 3 should be documented first and removed only after build participation and packaging needs are fully understood.

## Class 1: Generated Autotools / Libtool Noise

Examples:

```text
configure
aclocal.m4
config.guess
config.sub
ltmain.sh
```

These files contain large amounts of Linux, AIX, Solaris, HP-UX, OS/2, Cygwin, MinGW and Windows logic.

Classification:

```text
KEEP FOR NOW
```

Reason:

```text
These files are generated or imported Autotools infrastructure.
Removing platform branches here first would be noisy and high-risk.
```

Policy:

```text
Do not manually prune generated Autotools files as the first cleanup step.
If Autotools is later replaced or frozen, handle these files as a separate buildsystem phase.
```

## Class 2: Buildsystem Distribution Baggage

Examples:

```text
Makefile.am windowsFiles
Makefile.am windowsDefFiles
Makefile.am aixExportFiles
Makefile.in generated equivalents
```

Classification:

```text
CANDIDATE FOR LATER DIST-CLEANUP
```

Reason:

```text
These entries do not necessarily participate in the active Leopard build, but they may affect make dist or source-package layout.
```

Policy:

```text
Do not remove until LeooRexx's distribution model is decided.
```

Possible future action:

```text
Replace foreign dist lists with a Leopard-only source manifest.
```

## Class 3: Inactive Foreign Platform Source Trees

Examples:

```text
kernel/platform/windows
platform/windows
rexutils/windows
rexxapi/windows
samples/windows
*.bat
windows-build.txt
platform/windows/ole
platform/windows/oodialog
```

Classification:

```text
STRONG REMOVAL CANDIDATE, BUT NOT IN PHASE 3.1
```

Reason:

```text
These are architecturally foreign to LeooRexx.
Windows, OLE, ActiveX and ooDialog are not part of the Leopard-native runtime goal.
```

Policy:

```text
Do not carry Windows architecture forward.
Do not let Windows/OLE/ooDialog influence LeooRexx design.
```

Possible future action:

```text
Move to an excluded/deprecated source area or remove after confirming no active build references remain.
```

## Class 4: Active Unix-Source Conditional Residue

Important files:

```text
kernel/platform/unix/ExternalFunctions.cpp
kernel/platform/unix/FileSystem.cpp
kernel/platform/unix/PlatformDefinitions.h
kernel/platform/unix/SharedMemorySupport.cpp
kernel/platform/unix/SystemCommands.cpp
kernel/platform/unix/ThreadSupport.cpp
kernel/platform/unix/ThreadSupport.hpp
kernel/platform/unix/TimeSupport.cpp
kernel/runtime/RexxActivity.cpp
rexutils/rxmath.cpp
rexutils/rxsock.c
rexutils/rxsockfn.c
rexxapi/unix/QueuesAPI.cpp
rexxapi/unix/RexxAPIManager.cpp
rexxapi/unix/RexxAPIManager.h
rexxapi/unix/rexx.h
rxregexp/automaton.cpp
```

Classification:

```text
ACTIVE CLEANUP TARGETS
```

Reason:

```text
These files are part of the active Leopard/Unix build path or close to runtime behavior.
They contain remaining AIX/Solaris/Linux naming or conditional branches.
```

Policy:

```text
Clean only one narrow area at a time.
After each cleanup, rebuild and rerun runtime smoke tests.
```

Recommended first cleanup target:

```text
Documentation/comment/name cleanup only.
No semantic changes.
```

Recommended first files:

```text
rexxapi/unix/rexx.h
rexxapi/unix/QueuesAPI.cpp
rexxapi/unix/RexxAPIManager.cpp
rexxapi/unix/RexxAPIManager.h
```

Reason:

```text
These files still carry AIX naming and historical comments, but the runtime IPC baseline is now stable.
They should be cleaned carefully and only where behavior is unchanged.
```

## Class 5: POSIX / BSD Mechanisms To Keep

Examples:

```text
System V IPC
BSD sockets
POSIX shell/tooling
pthread behavior
Darwin-compatible Unix APIs
```

Classification:

```text
KEEP
```

Reason:

```text
Leopard is Darwin/POSIX-based.
Generic Unix code is not automatically foreign architecture.
```

Policy:

```text
Remove Linux identity, not useful POSIX capability.
Prefer Darwin/Leopard naming and explicit platform definitions.
```

## First Follow-Up Recommendation

Phase 3.2 should not delete whole directories yet.

Recommended next phase:

```text
Phase 3.2: Active IPC source residue cleanup
```

Scope:

```text
rexxapi/unix/rexx.h
rexxapi/unix/QueuesAPI.cpp
rexxapi/unix/RexxAPIManager.cpp
rexxapi/unix/RexxAPIManager.h
```

Allowed changes:

```text
- comments
- misleading historical labels
- dead commented-out #ifdef markers
- naming notes in documentation
```

Forbidden changes:

```text
- semaphore logic
- shared-memory layout
- queue cleanup behavior
- RXHOME anchor behavior
- MAXSEM / semaphore capacity constants
```

## Current Status

```text
Raw scans: captured
Classification: complete
Code removal: not started
Runtime behavior: unchanged
```

## Conclusion

Phase 3.1 confirms that LeooRexx still contains substantial portability residue, but most of it is either generated buildsystem noise or inactive foreign-platform baggage.

The active cleanup path should begin narrowly in the Unix/RexxAPI runtime sources, with no semantic changes.  

