# Phase 3.4 Build Participation / Source Ownership Map

## Purpose

This document maps build participation and ownership for the active RexxAPI Unix source area.

Phase 3.4 does not change source code.

## Input Scans

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.4/scans/rexxapi-unix-file-list.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.4/scans/rexxapi-unix-buildsystem-participation.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.4/scans/rexxapi-unix-header-includes.txt
work/oorexx-3.2.0-leopard-cut/Phase-3.4/scans/rexxapi-unix-symbol-ownership.txt
````

## File Inventory

The active `rexxapi/unix` source directory currently contains:

```text
APIManagerShutdown.cpp
APIUtilities.h
MacroSpace.cpp
QueueCommand.cpp
QueuesAPI.cpp
RexxAPIManager.cpp
RexxAPIManager.h
rexx.h
SUBCOMCommand.cpp
SubcommandAPI.cpp
SubcommandAPI.h
```

## Buildsystem Summary

The buildsystem defines:

```text
rexxapi_unix_dir = $(rexxapi_dir)/unix
```

The main RexxAPI runtime library is:

```text
librexxapi.la
```

It includes:

```text
SubcommandAPI.cpp
RexxAPIManager.cpp
MacroSpace.cpp
QueuesAPI.cpp
```

and also pulls in Unix platform IPC support from:

```text
kernel/platform/unix/SystemSemaphores.cpp
kernel/platform/unix/SharedMemorySupport.cpp
```

The command-line tools are:

```text
rxqueue
rxsubcom
rxdelipc
```

with source ownership:

```text
rxqueue  -> QueueCommand.cpp
rxsubcom -> SUBCOMCommand.cpp
rxdelipc -> APIManagerShutdown.cpp
```

All three link against:

```text
librexx.la
librexxapi.la
```

## Ownership Classes

```text
O1 = Runtime core
O2 = CLI frontend
O3 = Header / API boundary
O4 = Internal helper / support
O5 = Cross-layer dependency
```

## Source Ownership Map

### APIManagerShutdown.cpp

Ownership class:

```text
O2: CLI frontend
```

Build target:

```text
rxdelipc
```

Role:

```text
Command-line frontend for RexxAPI shutdown / IPC cleanup behavior.
```

Risk:

```text
Medium
```

Reason:

```text
Not part of librexxapi.la itself, but directly invokes RexxShutDownAPI and user-visible IPC cleanup behavior.
```

Recommendation:

```text
Comment cleanup is safe.
Behavior changes require rxdelipc-specific tests plus IPC smoke tests.
```

### APIUtilities.h

Ownership class:

```text
O4: Internal helper / support header
```

Build role:

```text
RexxAPI Unix internal header.
```

Risk:

```text
Medium
```

Reason:

```text
Header-level support code can affect multiple RexxAPI components.
```

Recommendation:

```text
Do not rename or reorganize without include-dependency review.
```

### MacroSpace.cpp

Ownership class:

```text
O1: Runtime core
```

Build target:

```text
librexxapi.la
```

Role:

```text
Implements MacroSpace API functions such as RexxClearMacroSpace, RexxSaveMacroSpace and RexxLoadMacroSpace.
```

Risk:

```text
High
```

Reason:

```text
Compiled into librexxapi.la and part of public RexxAPI behavior.
```

Recommendation:

```text
Comment-only cleanup is acceptable.
Behavior or platform-guard cleanup requires dedicated MacroSpace tests.
```

### QueueCommand.cpp

Ownership class:

```text
O2: CLI frontend
```

Build target:

```text
rxqueue
```

Role:

```text
Command-line interface for queue operations.
```

Risk:

```text
Medium
```

Reason:

```text
CLI frontend, but directly exercises Rexx queue API functions.
```

Recommendation:

```text
Can be cleaned separately, but smoke must include FIFO/LIFO queue behavior.
```

### QueuesAPI.cpp

Ownership class:

```text
O1: Runtime core
```

Build target:

```text
librexxapi.la
```

Role:

```text
Implements external Rexx queue APIs:
RexxCreateQueue, RexxDeleteQueue, RexxQueryQueue, RexxAddQueue, RexxPullQueue.
```

Risk:

```text
Very high
```

Reason:

```text
This file controls queue semantics, queue cleanup, semaphore use and process/session queue behavior.
```

Recommendation:

```text
No semantic cleanup without full runtime IPC matrix.
Platform guard changes are deferred.
```

### RexxAPIManager.cpp

Ownership class:

```text
O1: Runtime core
```

Build target:

```text
librexxapi.la
```

Role:

```text
Core RexxAPI manager: shared memory, API attachment, shutdown and runtime state coordination.
```

Risk:

```text
Very high
```

Reason:

```text
Controls shared memory pools, attach/detach behavior, API shutdown and runtime-global IPC state.
```

Recommendation:

```text
Comment-only cleanup only.
Any logic change requires full runtime, install, RXHOME and IPC cleanup tests.
```

### RexxAPIManager.h

Ownership class:

```text
O3 / O5: Internal API boundary and cross-layer dependency
```

Build role:

```text
Internal RexxAPI header used by rexxapi/unix and kernel/platform/unix code.
```

Known include users include:

```text
kernel/platform/unix/ExternalFunctions.cpp
kernel/platform/unix/RexxMain.cpp
rexxapi/unix/MacroSpace.cpp
rexxapi/unix/QueueCommand.cpp
rexxapi/unix/QueuesAPI.cpp
rexxapi/unix/RexxAPIManager.cpp
rexxapi/unix/SUBCOMCommand.cpp
rexxapi/unix/SubcommandAPI.cpp
rexutils/unix/rexxutil.cpp
```

Risk:

```text
Very high
```

Reason:

```text
Header contains semaphore capacity and API manager structures used across layers.
```

Recommendation:

```text
Do not rename guards, constants or structure fields casually.
LIMITED_SOLARIS_SEMS and AIX fallback areas require dedicated semantic review.
```

### rexx.h

Ownership class:

```text
O3: Public API boundary
```

Build/install role:

```text
Installed public header:
include_HEADERS = $(rexxapi_unix_dir)/rexx.h
```

Role:

```text
Defines public Rexx API types, constants and entry points.
```

Risk:

```text
Very high
```

Reason:

```text
External extensions, samples and internal components include this header.
```

Recommendation:

```text
Do not rename legacy compatibility macros or public API declarations in cleanup phases.
The AIX fallback define is ugly but must remain until a broader platform-identity refactor exists.
```

### SUBCOMCommand.cpp

Ownership class:

```text
O2: CLI frontend
```

Build target:

```text
rxsubcom
```

Role:

```text
Command-line frontend for subcommand environment registration/query/drop behavior.
```

Risk:

```text
Medium
```

Reason:

```text
CLI-only source, but directly exercises SubcommandAPI and registration behavior.
```

Recommendation:

```text
Comment cleanup is safe.
Behavior changes require rxsubcom register/query/drop tests.
```

### SubcommandAPI.cpp

Ownership class:

```text
O1: Runtime core
```

Build target:

```text
librexxapi.la
```

Role:

```text
Implements subcommand registration APIs:
RexxRegisterSubcomDll, RexxRegisterSubcomExe, RexxQuerySubcom, RexxDeregisterSubcom.
```

Risk:

```text
High
```

Reason:

```text
Compiled into librexxapi.la and called by kernel/platform/unix and rxsubcom.
```

Recommendation:

```text
Do not alter AIX/platform guards without dedicated subcommand API tests.
```

### SubcommandAPI.h

Ownership class:

```text
O3 / O5: Internal API boundary and cross-layer dependency
```

Build role:

```text
Internal RexxAPI header.
```

Known include users include:

```text
kernel/platform/unix/ExternalFunctions.cpp
kernel/platform/unix/RexxMain.cpp
kernel/platform/unix/RexxQueues.cpp
kernel/platform/unix/SystemCommands.cpp
rexxapi/unix/SUBCOMCommand.cpp
rexxapi/unix/SubcommandAPI.cpp
```

Risk:

```text
High
```

Reason:

```text
Header guard names are ugly but structurally load-bearing enough to avoid casual churn.
```

Recommendation:

```text
Leave AIXSEAPI_HC_INCLUDED unchanged until a deliberate public/internal header naming review.
```

## Cross-Layer Findings

### librexxapi.la is the RexxAPI runtime core

Files in `librexxapi.la` should be treated as runtime-core files:

```text
SubcommandAPI.cpp
RexxAPIManager.cpp
MacroSpace.cpp
QueuesAPI.cpp
SystemSemaphores.cpp
SharedMemorySupport.cpp
```

### CLI tools are thin frontends

```text
rxqueue  -> QueueCommand.cpp
rxsubcom -> SUBCOMCommand.cpp
rxdelipc -> APIManagerShutdown.cpp
```

They are easier to reason about than runtime-core files, but still require smoke tests because they exercise live RexxAPI behavior.

### Headers are higher-risk than they look

```text
rexx.h
RexxAPIManager.h
SubcommandAPI.h
```

These should not be treated as cosmetic cleanup targets.

## Cleanup Risk Ranking

### Lowest Risk

```text
APIManagerShutdown.cpp comments
SUBCOMCommand.cpp comments
QueueCommand.cpp comments
```

### Medium Risk

```text
CLI tool behavior
APIUtilities.h organization
MacroSpace comments
```

### High Risk

```text
MacroSpace behavior
SubcommandAPI behavior
SubcommandAPI.h naming
RexxAPIManager.h naming
```

### Very High Risk

```text
QueuesAPI.cpp behavior
RexxAPIManager.cpp behavior
rexx.h public declarations
semaphore/shared-memory constants
RXHOME anchor behavior
```

## Recommended Next Phase

Recommended next phase:

```text
Phase 3.5: Runtime API ownership summary / safety boundary
```

Purpose:

```text
Turn this source ownership map into a short rule document defining which files require which test matrix before change.
```

Alternative:

```text
Pause cleanup and move to Leopard-native packaging/application integration.
```

## Conclusion

Phase 3.4 confirms that the remaining active RexxAPI Unix residue is not simple dead code.

The core runtime ownership is concentrated in:

```text
RexxAPIManager.cpp
QueuesAPI.cpp
MacroSpace.cpp
SubcommandAPI.cpp
```

The highest-risk headers are:

```text
rexx.h
RexxAPIManager.h
SubcommandAPI.h
```

Further cleanup must be source-owner aware and test-matrix driven.  

