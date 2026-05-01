# Plain LINUX Macro Map

## Finding

After cleaning direct `AIX || LINUX` POSIX proxy guards and active `OPSYS_LINUX` source paths, the build system still defines:

```text
-DLINUX
-DOPSYS_LINUX
````

`OPSYS_LINUX` is no longer used in active source paths except commented legacy code, but plain `LINUX` remains in multiple active files.

## Rule

Do not remove `-DLINUX` from the build system until all active plain `LINUX` usages have been classified.

## Classification Categories

```text
A — comment / documentation residue
B — POSIX / Unix proxy
C — OS/2 or AIX fallback logic
D — Darwin-compatible but mislabeled
E — PowerPC / ABI-sensitive
F — quarantine utility/API code
```

## High-Priority Findings

### PlatformDefinitions.h — ABI-sensitive

```text
#if defined(LINUX) && defined(PPC)
```

Classification:

```text
E — PowerPC / ABI-sensitive
```

Reason:

This affects PowerPC varargs / ABI-related typedefs. It must not be changed blindly.

### PlatformDefinitions.h — System identity

```text
#define SysName() new_string("LINUX", 5)
#define SysINTName() new_string("LINUX",5)
```

Classification:

```text
D — Darwin-compatible but mislabeled
```

Reason:

LeooRexx must not report or internally model Leopard/Darwin as Linux.

This is a high-value identity cleanup target, but it must be tested carefully because Rexx class code may depend on the returned value.

### rexxapi/unix/rexx.h — AIX fallback debt

```text
#if !defined(AIX) && !defined(LINUX)
#define AIX
#endif
```

Classification:

```text
C — fallback-to-AIX platform debt
```

Reason:

Unknown Unix-like platforms must not silently become AIX.

Already documented separately in:

```text
work/oorexx-3.2.0-leopard-cut/aix-fallback-debt.md
```

## Quarantine Areas

The following files contain plain `LINUX` but are already quarantine or utility/API-adjacent:

```text
rexutils/rxmath.cpp
rexutils/unix/rexxutil.cpp
rexxapi/unix/*
```

Cleanup here does not promote these components to LeooRexx core.

## Buildsystem Note

`configure.ac` currently sets:

```text
GENERIC_OS="-DLINUX"
GENERIC_OPSYS="-DOPSYS_LINUX"
```

Darwin only changes:

```text
ORX_SYS_STR="MACOSX"
ORX_SHARED_LIBRARY_EXT=".dylib"
```

This is buildsystem-level platform identity debt.

## Conclusion

The next source-level cleanup phase must address plain `LINUX` usages before `configure.ac` can safely stop emitting `-DLINUX`.

LeooRexx must not remove the build-level Linux define while source files still rely on it for ABI, POSIX, or legacy-guard behavior.  

