# RxSock Select Darwin Path Result

## Change

Three occurrences in:

```text
src/oorexx-3.2.0-leopard/rexutils/rxsockfn.c
````

inside `SockSelect()` were changed from:

```c
#if defined(OPSYS_LINUX)
```

to:

```c
#if LEOOREXX_LEGACY_LINUX
```

## Rationale

The old `OPSYS_LINUX` branch selected Linux-specific socket behavior for the Leopard/PPC build.

In `SockSelect()`, this caused the code to use `struct timespec` for the `select()` timeout path. Darwin / Mac OS X Leopard uses the BSD/POSIX `select()` interface with `struct timeval`.

The new guard keeps the Linux-specific branch available only for explicit legacy Linux builds. LeooRexx/Darwin now uses the `timeval` path.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rxsock-select-darwin-test
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Warning Status

The previous warning:

```text
warning: passing argument 5 of 'select' from incompatible pointer type
```

is no longer observed in the `rxsock-select-darwin-test` build.

## Quarantine Note

RxSock remains quarantine material.

This change fixes a concrete Darwin/POSIX socket ABI mismatch, but it does not promote RxSock to LeooRexx core.

## Conclusion

This is the first RxSock quarantine sanitation step with a direct technical benefit: the Leopard/PPC build now uses the Darwin-compatible `select()` timeout path.  

