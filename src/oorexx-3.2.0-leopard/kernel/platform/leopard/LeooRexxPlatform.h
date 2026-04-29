#ifndef LEOOREXX_PLATFORM_H
#define LEOOREXX_PLATFORM_H

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

#define LEOOREXX_PLATFORM_POSIX    1
#define LEOOREXX_PLATFORM_UNIX     1

#define LEOOREXX_ARCH_POWERPC      1
#define LEOOREXX_ABI_POWERPC_DARWIN 1

#define LEOOREXX_LEGACY_LINUX      0
#define LEOOREXX_LEGACY_AIX        0
#define LEOOREXX_LEGACY_SUN        0
#define LEOOREXX_LEGACY_OS2        0
#define LEOOREXX_LEGACY_WIN32      0

#endif /* LEOOREXX_PLATFORM_H */

