# AIX Fallback Debt

## Finding

The following guard remains in the imported ooRexx 3.2.0 source cut:

```c
#if !defined(AIX) && !defined(LINUX)
#define AIX
#endif
````

Location:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/rexx.h
```

## Meaning

This is not an OS/2 guard.

It is a historical fallback that treats unknown Unix-like builds as AIX when neither `AIX` nor `LINUX` is defined.

## LeooRexx Assessment

For LeooRexx this is platform identity debt.

Darwin must not become AIX by fallback.

POSIX must not be hidden behind AIX.

Linux must not be used as the alternative to AIX.

## Status

Do not change blindly.

This guard must be reviewed together with the Rexx API header model before modification.

## Target

Replace fallback identity with explicit LeooRexx platform semantics:

```text
Darwin means Darwin.
POSIX means POSIX.
AIX means AIX.
Linux means Linux.
```

Possible future direction:

```c
#if defined(LEOOREXX_PLATFORM_DARWIN)
  /* Darwin / Leopard path */
#elif defined(LEOOREXX_LEGACY_AIX)
  /* AIX legacy path */
#elif defined(LEOOREXX_LEGACY_LINUX)
  /* Linux legacy path */
#else
  #error "Unsupported LeooRexx Rexx API platform."
#endif
```

