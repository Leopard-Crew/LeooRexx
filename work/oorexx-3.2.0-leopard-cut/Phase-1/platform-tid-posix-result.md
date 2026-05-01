# Platform TID POSIX Guard Result

## Change

The `TID` definition block in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed from a `LINUX`-guarded branch to explicit LeooRexx POSIX semantics.

The Leopard/PPC path now uses:

```c
#define TID             pthread_t
```

under:

```c
#if LEOOREXX_PLATFORM_POSIX
```

## Rationale

Darwin / Mac OS X Leopard uses POSIX threads. The thread identifier type used by the active LeooRexx platform path should therefore be expressed through explicit POSIX semantics, not through the historical `LINUX` macro.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-tid-posix-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Remaining Warnings

The build still shows the known RexxUtil quarantine warnings:

```text
NULL used in arithmetic
```

These are unrelated to the `TID` platform guard change.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

The `TID` platform guard can use explicit LeooRexx POSIX thread semantics without breaking the Leopard/PPC build.  

