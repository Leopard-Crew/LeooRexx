# Platform SysName MacOSX Result

## Change

The platform identity block in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed so LeooRexx/Darwin reports:

```c
SysName()    -> "MACOSX"
SysINTName() -> "MACOSX"
```

instead of falling through to the historical Linux identity.

## Rationale

LeooRexx must not internally identify Mac OS X Leopard / Darwin as Linux.

This change makes platform identity explicit while preserving legacy AIX, Sun and fallback branches.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-sysname-macosx-test
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Remaining Debt

The generated build flags still contain:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt and is not resolved by this source-level identity cleanup.

## Conclusion

LeooRexx now reports MacOSX identity from `PlatformDefinitions.h` while still building successfully on Leopard/PPC.  

