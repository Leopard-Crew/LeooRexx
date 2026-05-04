# Phase 3.4 Build Participation / Source Ownership Map Plan

## Purpose

Phase 3.4 maps ownership and build participation for the active RexxAPI Unix source area.

Phase 3.3 showed that the remaining IPC-related portability residue is mostly semantic or public-identity related.

Phase 3.4 answers:

```text
Which file participates in which build target?
Which file is runtime core?
Which file is CLI-only?
Which file is public/header-facing?
Which file is legacy support?
````

## Current Baseline

Phase 3.4 starts after:

```text
phase3_3-semantic-residue-risk-map
```

The verified baseline includes:

```text
- runtime IPC baseline
- install prefix smoke
- environment activation contract
- leoorxenv install hook
- DESTDIR behavior
- fresh RXHOME recheck
- portability residue scan
- active IPC comment cleanup
- semantic residue risk map
```

## Scope

Primary source area:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/
```

Important files:

```text
APIManagerShutdown.cpp
MacroSpace.cpp
QueueCommand.cpp
QueuesAPI.cpp
RexxAPIManager.cpp
RexxAPIManager.h
SUBCOMCommand.cpp
SubcommandAPI.cpp
SubcommandAPI.h
rexx.h
```

## Classification Dimensions

Each file should be classified by:

```text
- build target participation
- runtime role
- public/private status
- cleanup risk
- future action
```

## Ownership Classes

### O1: Runtime Core

Examples may include:

```text
RexxAPIManager.cpp
QueuesAPI.cpp
MacroSpace.cpp
SubcommandAPI.cpp
```

Risk:

```text
High. Changes require full build and runtime IPC smoke tests.
```

### O2: CLI Tool Frontend

Examples may include:

```text
QueueCommand.cpp
SUBCOMCommand.cpp
APIManagerShutdown.cpp
```

Risk:

```text
Medium. Changes affect command behavior and user-facing tools.
```

### O3: Header / API Boundary

Examples may include:

```text
rexx.h
RexxAPIManager.h
SubcommandAPI.h
```

Risk:

```text
High. Names may be ugly but externally visible or structurally load-bearing.
```

### O4: Legacy / Historical Support Layer

Examples may include:

```text
compatibility defines
legacy platform macro bridges
commented historical conditionals
```

Risk:

```text
Variable. Must be reviewed case by case.
```

## Non-Goals

Phase 3.4 does not:

```text
- edit source code
- rename macros
- remove files
- remove comments
- modify Makefile.am
- modify Makefile.in
- change build behavior
```

## Deliverables

Raw scans:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.4/scans/
```

Final map:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.4/phase3_4-build-participation-source-ownership-map.md
```

## Success Criteria

Phase 3.4 succeeds if each important rexxapi/unix file has:

```text
- build participation evidence
- ownership class
- cleanup risk
- recommendation
```

## Status

```text
planned
```

