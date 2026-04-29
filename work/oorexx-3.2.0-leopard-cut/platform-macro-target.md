# LeooRexx Platform Macro Target

This document defines the target platform macro model for the curated LeooRexx Leopard/Darwin source cut.

The purpose is to replace historical platform ambiguity such as using `LINUX` or `OPSYS_LINUX` as a proxy for Unix, POSIX, Darwin, or "not OS/2".

## Core Rule

LeooRexx platform identity must be explicit and deterministic.

```text
POSIX   means POSIX.
UNIX    means Unix-like behavior.
Linux   means Linux.
Darwin  means Darwin.
Mac OS X means Mac OS X.
Leopard means Mac OS X 10.5.x Leopard.
PowerPC means PowerPC.
````

No active LeooRexx platform path may use `LINUX` as an alias for Darwin, POSIX, Unix, or "not OS/2".

## Target Macros

### Platform identity

```c
#define LEOOREXX_PLATFORM_DARWIN  1
#define LEOOREXX_PLATFORM_MACOSX  1
#define LEOOREXX_PLATFORM_LEOPARD 1
```

Meaning:

- `LEOOREXX_PLATFORM_DARWIN`: Darwin kernel / Unix substrate
    
- `LEOOREXX_PLATFORM_MACOSX`: Mac OS X system environment
    
- `LEOOREXX_PLATFORM_LEOPARD`: reference target, Mac OS X 10.5.x
    

### POSIX / Unix layer

```c
#define LEOOREXX_PLATFORM_POSIX 1
#define LEOOREXX_PLATFORM_UNIX  1
```

Meaning:

These may only be used for behavior that is genuinely generic and valid on Darwin as Darwin's native POSIX/Unix layer.

They must not hide Linux-specific assumptions.

### Architecture

```c
#define LEOOREXX_ARCH_POWERPC 1
#define LEOOREXX_ABI_POWERPC_DARWIN 1
```

Meaning:

PowerPC architecture and Darwin/PowerPC ABI behavior.

This is especially important for legacy `LINUX && PPC` varargs and ABI-related code paths.

### Legacy markers

```c
#define LEOOREXX_LEGACY_LINUX 0
#define LEOOREXX_LEGACY_AIX   0
#define LEOOREXX_LEGACY_SUN   0
#define LEOOREXX_LEGACY_OS2   0
#define LEOOREXX_LEGACY_WIN32 0
```

Meaning:

Legacy platform code may remain archived or present during audit, but must not participate in the active LeooRexx runtime build.

## Mapping from ooRexx 3.2.0

### Historical ooRexx symbols

```text
LINUX
OPSYS_LINUX
AIX
OPSYS_AIX
OPSYS_SUN
WIN32
```

These symbols are not acceptable as LeooRexx conceptual platform identifiers.

They may be temporarily present during the transition phase, but every active usage must be classified and either:

- replaced by a LeooRexx macro,
    
- moved behind a legacy-only guard,
    
- quarantined,
    
- or removed from the active build.
    

## Transition Strategy

### Step 1: classify

Every active `LINUX` / `OPSYS_LINUX` use is classified in:

```text
work/oorexx-3.2.0-leopard-cut/active-linux-proxy-map.md
```

### Step 2: introduce LeooRexx platform header

Create a dedicated platform identity header, for example:

```text
kernel/platform/leopard/LeooRexxPlatform.h
```

or:

```text
kernel/platform/unix/LeooRexxPlatform.h
```

The final location is still open.

### Step 3: replace semantic misuse

Replace usages by meaning, not by text search.

Examples:

```c
#if defined(AIX) || defined(LINUX)
```

may become:

```c
#if defined(LEOOREXX_PLATFORM_POSIX)
```

only if the guarded code is truly POSIX-generic.

But:

```c
#if !defined(AIX) && !defined(LINUX)
```

may become:

```c
#if defined(LEOOREXX_LEGACY_OS2)
```

if the guarded code is OS/2-only residue.

And:

```c
#if defined(LINUX) && defined(PPC)
```

may become:

```c
#if defined(LEOOREXX_ABI_POWERPC_DARWIN)
```

only after ABI review.

## Forbidden Transformations

Do not blindly replace:

```text
LINUX -> DARWIN
OPSYS_LINUX -> OPSYS_DARWIN
```

This would preserve the old ambiguity under a new name.

## LeooRexx Principle

LeooRexx does not port ooRexx to a generic Unix platform.

LeooRexx creates a deterministic Darwin/Leopard source cut.

Darwin first.

POSIX where Darwin uses POSIX natively.

Linux never as a disguise.  
