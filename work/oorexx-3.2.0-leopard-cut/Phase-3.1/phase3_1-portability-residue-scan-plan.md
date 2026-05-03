# Phase 3.1 Portability Residue Scan Plan

## Purpose

Phase 3.1 scans the current LeooRexx source tree for portability residue and dead-code candidates after the runtime and install baseline has become stable.

This phase is intentionally read-only.

No code is removed in Phase 3.1.

## Current Verified Baseline

The scan starts after:

```text
phase2-runtime-ipc-baseline
phase2_5-install-prefix-smoke
phase2_6-installed-environment-contract
phase2_7-activation-packaging
phase2_8-leoorxenv-install-hook
phase2_9-destdir-install-behavior
phase3_0-fresh-rxhome-recheck
````

## Guiding Rule

Do not remove code only because it looks old.

Classify first.

Removal is allowed only in a later phase after:

```text
- active build participation is known
- runtime behavior is verified
- platform identity is stable
- Leopard-native replacement path is clear
```

## Scan Categories

### Category A: Foreign Platform Guards

Examples:

```text
OPSYS_LINUX
OPSYS_AIX
OPSYS_SUN
OPSYS_WINDOWS
OPSYS_OS2
OPSYS_FREEBSD
OPSYS_NETBSD
OPSYS_HPUX
OPSYS_SOLARIS
```

Purpose:

```text
Find remaining foreign platform conditionals.
```

### Category B: Linux Naming Residue

Examples:

```text
LINUX
Linux
linux
OPSYS_LINUX
```

Purpose:

```text
Find places where Leopard still pretends to be Linux or inherits Linux naming.
```

### Category C: Windows / OS2 Residue

Examples:

```text
WIN32
WINDOWS
OS2
OLE
ActiveX
OODialog
```

Purpose:

```text
Find non-Leopard platform baggage that should not influence LeooRexx.
```

### Category D: AIX / Solaris / HP-UX / Legacy UNIX Residue

Examples:

```text
AIX
SOLARIS
SUN
HPUX
HAVE_NSLEEP
LIMITED_SOLARIS_SEMS
```

Purpose:

```text
Find legacy UNIX compatibility branches that may be inactive on Leopard.
```

### Category E: Buildsystem Residue

Examples:

```text
cygwin
mingw
linux
aix
solaris
os2
windows
```

Purpose:

```text
Find buildsystem-level residue that may affect generated config or install behavior.
```

### Category F: Runtime-Relevant Residue

Some residue may still be dangerous to remove.

Examples:

```text
POSIX fallback code
BSD socket code
System V IPC code
Autotools compatibility logic
```

Purpose:

```text
Separate removable foreign-platform code from useful generic UNIX/POSIX mechanisms.
```

## Output Files

The scan should produce raw grep reports in:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.1/scans/
```

and a later classification document:

```text
work/oorexx-3.2.0-leopard-cut/Phase-3.1/phase3_1-portability-residue-classification.md
```

## Non-Goals

Phase 3.1 does not:

```text
- delete code
- rewrite platform guards
- change buildsystem behavior
- remove generated files
- modify runtime code
```

## Success Criteria

Phase 3.1 succeeds if:

```text
- raw scans are captured
- residue is grouped into meaningful categories
- obvious active vs inactive areas are separated
- follow-up removal/refactor candidates are listed
- no runtime behavior is changed
```

## Status

```text
planned
```

