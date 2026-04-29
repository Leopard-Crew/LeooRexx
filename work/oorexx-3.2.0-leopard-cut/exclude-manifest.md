
This document lists source paths from the imported ooRexx 3.2.0 tree that must not become part of the active LeooRexx runtime cut.

The files remain preserved under `/vendor` and may also exist in the imported source tree for audit purposes. They are excluded from the curated Leopard/Darwin build target.

## Immediate Exclude

### Windows platform trees

```text
kernel/platform/windows/
platform/windows/
rexutils/windows/
rexxapi/windows/
samples/windows/
````

Reason:

LeooRexx targets Mac OS X 10.5.8 Leopard PowerPC only. Windows platform code has no role in the active runtime cut.

### Windows build files

```text
lib/orxwin32.mak
makeorx.bat
orxdb.bat
windows-build.txt
```

Reason:

Windows build logic is foreign platform material and must not participate in LeooRexx build or distribution.

### OODialog / orxscrpt material

```text
platform/windows/oodialog/
platform/windows/orxscrpt/
```

Reason:

OODialog and Windows scripting support are explicitly out of scope for LeooRexx and count as foreign platform ballast.

## Quarantine

These components are not excluded yet, but must not be considered core until reviewed:

```text
rexutils/
rxregexp/
samples/
rexxapi/
```

## Platform Identity Debt

The platform residue scan found strong evidence of historical platform mixing:

```text
WINDOWS/WIN32:       147
OS/2/OS2/PM/Dos*:     91
AIX:                 377
SUN/SOLARIS:          62
LINUX/OPSYS_LINUX:   124
DARWIN/MACOSX:       120
```

This confirms that the current source tree is an upstream body under audit, not yet a deterministic Leopard/Darwin source cut.

## Rule

No excluded path may be compiled, shipped, or used as a conceptual fallback in LeooRexx.
