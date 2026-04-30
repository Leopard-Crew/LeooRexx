# RxSock Quarantine Map

## Status

RxSock is part of the imported ooRexx 3.2.0 source tree and currently participates in the Leopard/PPC build.

It remains quarantine material and is not LeooRexx core.

## Reason

RxSock contains active `OPSYS_LINUX` and `OPSYS_AIX` platform branches. Unlike earlier POSIX proxy guards, these branches are not always simple Unix/POSIX aliases.

Some of them affect socket ABI behavior.

## Important Finding

In:

```text
src/oorexx-3.2.0-leopard/rexutils/rxsockfn.c
````

`SockSelect()` uses:

```c
#if defined(OPSYS_LINUX)
   struct timespec  timeOutS;
#else
   struct timeval   timeOutS;
#endif
```

For Darwin / Mac OS X Leopard, `select()` expects a `struct timeval *` timeout.

This likely explains the known build warning:

```text
warning: passing argument 5 of 'select' from incompatible pointer type
```

## Classification

### rxsock.h

Status: quarantine.

Contains mixed platform guards for function declarations and helper prototypes.

### rxsock.c

Status: quarantine.

Contains mixed platform guards for program naming, socket constants and function registration.

### rxsockfn.c

Status: high-priority quarantine audit.

Contains socket implementation details and known `select()` type warning.

## Rule

Do not replace `OPSYS_LINUX` in RxSock globally.

Each branch must be classified individually as one of:

```text
- POSIX-generic
- Darwin/BSD-socket behavior
- Linux-specific
- AIX-specific
- Windows-specific
- obsolete/quarantine-only
```

## LeooRexx Decision

RxSock cleanup does not promote RxSock to LeooRexx core.

Future options:

```text
1. exclude RxSock from V1
2. keep RxSock as optional quarantine utility
3. replace networking with native Darwin/Leopard capability design
4. create a Darwin-specific RxSock compatibility patch if needed
```

