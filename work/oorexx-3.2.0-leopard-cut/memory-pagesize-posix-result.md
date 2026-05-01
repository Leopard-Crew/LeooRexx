# Memory Page Size POSIX Guard Result

## Change

The page size guard in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/MemorySupport.cpp
````

was changed from:

```c
#ifdef LINUX
#define PAGESIZE    4096
#endif
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
#define PAGESIZE    4096
#endif
```

## Rationale

The old guard used `LINUX` to select a page size of 4096 bytes.

On the reference Leopard/PPC system, `getconf PAGESIZE` reports:

```text
4096
```

Therefore the value is valid for the LeooRexx Leopard/PPC path, but the guard must express POSIX/platform semantics rather than Linux identity.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh memory-pagesize-posix-test
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

The memory page size guard can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

