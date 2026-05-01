# Platform FNONBLOCK POSIX Guard Result

## Change

The `FNONBLOCK` guard in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed from:

```c
#ifdef LINUX
#define FNONBLOCK       O_NONBLOCK
#endif
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
#define FNONBLOCK       O_NONBLOCK
#endif
```

## Rationale

`FNONBLOCK` maps to `O_NONBLOCK`, which is POSIX/fcntl behavior. It is not Linux-specific.

In the LeooRexx Leopard/PPC source cut, this must be expressed as explicit POSIX behavior instead of relying on the historical `LINUX` macro.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-fnonblock-posix-test
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

The `FNONBLOCK` platform guard can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

