# RexxAPI Header Platform Guards Result

## Change

Two platform guard blocks in:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/rexx.h
````

were updated.

## AIX fallback guard

Before:

```c
#if !defined(AIX) && !defined(LINUX)
#define AIX
#endif
```

After:

```c
#if !defined(AIX) && !LEOOREXX_PLATFORM_DARWIN
#define AIX
#endif
```

## TID guard

Before:

```c
#ifndef TID
#ifndef LINUX
#define TID             tid_t
#else
#define TID             pthread_t
#endif
#endif
```

After:

```c
#ifndef TID
#if LEOOREXX_PLATFORM_POSIX
#define TID             pthread_t
#else
#define TID             tid_t
#endif
#endif
```

## Rationale

The old Unix API header used `LINUX` to avoid falling back to AIX and to select POSIX thread IDs.

LeooRexx/Darwin must be explicit:

```text
- Darwin is not AIX.
- Darwin uses POSIX pthreads.
```

The legacy AIX fallback remains only for non-LeooRexx Unix paths.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxapi-header-platform-guards-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

The RexxAPI Unix header no longer relies on plain `LINUX` to avoid the AIX fallback or to select `pthread_t` for the active LeooRexx/Darwin path.  

