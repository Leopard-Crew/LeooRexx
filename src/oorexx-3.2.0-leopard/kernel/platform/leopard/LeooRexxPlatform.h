/* Make a special profile for LeooRexx */

#ifndef LEOOREXX_PLATFORM_H
#define LEOOREXX_PLATFORM_H

/*
 * Build guard:
 * This source cut is intentionally limited to Mac OS X Leopard / Darwin
 * on PowerPC. It must fail early on foreign platforms.
 */

#ifndef __APPLE__
#error "LeooRexx Leopard cut requires Mac OS X / Darwin."
#endif

#ifndef __MACH__
#error "LeooRexx Leopard cut requires Darwin / Mach."
#endif

#if !defined(__ppc__) && !defined(__PPC__) && !defined(__POWERPC__) && !defined(__powerpc__)
#error "LeooRexx Leopard cut requires PowerPC."
#endif

#ifndef __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__
#error "LeooRexx Leopard cut requires an explicit Mac OS X deployment target."
#endif

#if __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ < 1050
#error "LeooRexx Leopard cut requires Mac OS X 10.5 or later as deployment target."
#endif

/*
 * LeooRexx platform identity for Mac OS X 10.5.x Leopard / PowerPC.
 *
 * This header defines the intended platform identity for the curated
 * LeooRexx source cut. It does not replace legacy ooRexx platform
 * macros yet. It is introduced first as a deterministic target anchor.
 */

#define LEOOREXX_PLATFORM_DARWIN   1
#define LEOOREXX_PLATFORM_MACOSX   1
#define LEOOREXX_PLATFORM_LEOPARD  1

#define LEOOREXX_PLATFORM_POSIX       1
#define LEOOREXX_PLATFORM_UNIX        1
#define LEOOREXX_PLATFORM_BSD_SOCKETS 1
#define LEOOREXX_PTHREAD_PRIORITY_HINTS 1
#define LEOOREXX_CXX_UNIFORM_METHOD_POINTER_CASTS 1
#define LEOOREXX_REXXAPI_COMPACT_SEMAPHORE_LIMITS 1

#define LEOOREXX_ARCH_POWERPC      1
#define LEOOREXX_ABI_POWERPC_DARWIN 1

#define LEOOREXX_LEGACY_LINUX      0
#define LEOOREXX_LEGACY_AIX        0
#define LEOOREXX_LEGACY_SUN        0
#define LEOOREXX_LEGACY_OS2        0
#define LEOOREXX_LEGACY_WIN32      0

#endif /* LEOOREXX_PLATFORM_H */

