# Platform No Linux SysName Fallback Result

## Change

The fallback platform identity in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed from a Linux identity fallback to an explicit unsupported-platform error.

Before:

```c
#else
#define SysName() new_string("LINUX", 5)
#define SysINTName() new_string("LINUX",5)
#endif
```

After:

```c
#else
#error "Unsupported LeooRexx platform identity."
#endif
```

## Rationale

LeooRexx must not silently identify unknown or unsupported platforms as Linux.

The active Leopard/PPC path already reports:

```text
MACOSX
```

Therefore, the old Linux fallback is no longer acceptable in the curated Leopard source cut.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-no-linux-sysname-fallback-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Remaining Warnings

The build still shows known baseline or quarantine warnings, including:

```text
RexxUtil NULL used in arithmetic
extern initialized warnings
MemorySupport operator new warning
```

These are unrelated to the Linux identity fallback removal.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

The central platform definition header no longer falls back to Linux identity while still building successfully on Leopard/PPC.  

