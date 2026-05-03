# Phase 3.2 Active IPC Source Residue Cleanup Plan

## Purpose

Phase 3.2 starts careful cleanup of active RexxAPI IPC source residue.

This phase is intentionally narrow.

## Current Baseline

Phase 3.2 starts after:

```text
phase3_1-portability-residue-scan
````

and after the runtime/install baseline has been verified through:

```text
phase2-runtime-ipc-baseline
phase2_5-install-prefix-smoke
phase2_6-installed-environment-contract
phase2_7-activation-packaging
phase2_8-leoorxenv-install-hook
phase2_9-destdir-install-behavior
phase3_0-fresh-rxhome-recheck
```

## Scope

Allowed source area:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/
```

Primary files:

```text
RexxAPIManager.cpp
RexxAPIManager.h
QueuesAPI.cpp
rexx.h
```

## Allowed Changes

Only non-semantic cleanup is allowed:

```text
- misleading historical comments
- typo fixes in comments
- stale platform labels in comments
- documentation-only cleanup
- inactive commented-out historical notes
```

## Forbidden Changes

Do not change:

```text
- semaphore logic
- shared-memory layout
- queue allocation behavior
- queue cleanup behavior
- RXHOME anchor behavior
- MAXSEM / semaphore capacity constants
- public API structures
- binary/runtime behavior
```

## Test Requirement

After any code cleanup:

```text
- build must remain warning-clean
- installed prefix smoke must still pass
- rxqueue smoke must pass
- rxsubcom smoke must pass
- fresh RXHOME smoke must pass
```

## Strategy

Phase 3.2 proceeds in two steps:

```text
1. create targeted active IPC residue scan
2. apply one tiny comment-only cleanup patch
```

No broad cleanup is allowed.

## Status

```text
planned
```

