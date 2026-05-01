# RxSock BSD Sockets Guard Result

## Change

RxSock quarantine code was updated to express Darwin/Leopard socket behavior through an explicit LeooRexx BSD sockets platform macro.

Updated files:

```text
src/oorexx-3.2.0-leopard/kernel/platform/leopard/LeooRexxPlatform.h
src/oorexx-3.2.0-leopard/rexutils/rxsock.c
src/oorexx-3.2.0-leopard/rexutils/rxsock.h
src/oorexx-3.2.0-leopard/rexutils/rxsockfn.c
````

## New Platform Macro

```c
#define LEOOREXX_PLATFORM_BSD_SOCKETS 1
```

## Rationale

Most remaining RxSock platform guards distinguish BSD/POSIX socket behavior from WinSock or other legacy branches.

Darwin / Mac OS X Leopard uses BSD sockets. Therefore, these branches should not be selected through `OPSYS_AIX` or `OPSYS_LINUX`.

## Validation

The first test failed because `rxsock.c` used `LEOOREXX_PLATFORM_BSD_SOCKETS` before the LeooRexx platform header was visible. This caused the wrong fallback include path and attempted to include `rexxsaa.h`.

The include order was corrected by including:

```c
#include "../kernel/platform/leopard/LeooRexxPlatform.h"
```

early in:

```text
rexutils/rxsock.c
rexutils/rxsock.h
rexutils/rxsockfn.c
```

The source cut was then rebuilt using:

```text
tools/leopard_build_test.sh rxsock-bsd-sockets-test-2
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Quarantine Note

RxSock remains quarantine material.

This cleanup clarifies BSD socket platform semantics while RxSock still participates in the active build. It does not promote RxSock to LeooRexx core.

## Remaining Debt

The generated build flags still contain:

```text
-DLINUX
-DOPSYS_LINUX
```

This is buildsystem-level platform identity debt and remains a later cleanup target.

## Conclusion

RxSock can use explicit LeooRexx BSD socket semantics on Leopard/PPC without breaking the build.  
