# Platform PPVOID POSIX Guard Result

## Change

The `PPVOID` guard in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed from:

```c
#ifdef LINUX
#define PPVOID          void **
#endif
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
#define PPVOID          void **
#endif
```

## Rationale

`PPVOID` is a pointer compatibility typedef used by the Unix/Leopard build path. It is not Linux-specific.

In the LeooRexx Leopard/PPC source cut, this must be expressed through explicit POSIX platform semantics instead of the historical `LINUX` macro.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-ppvoid-posix-test
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

The `PPVOID` platform guard can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

