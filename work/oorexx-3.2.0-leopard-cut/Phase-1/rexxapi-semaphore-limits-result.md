# RexxAPI Semaphore Limits Guard Result

## Change

The semaphore limit policy guard in:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/RexxAPIManager.h
````

was changed from:

```c
#ifdef LINUX
```

to:

```c
#if LEOOREXX_REXXAPI_COMPACT_SEMAPHORE_LIMITS
```

A dedicated LeooRexx platform feature macro was added in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/leopard/LeooRexxPlatform.h
```

```c
#define LEOOREXX_REXXAPI_COMPACT_SEMAPHORE_LIMITS 1
```

## Rationale

This block does not describe Linux identity.

It selects compact RexxAPI semaphore limits:

```text
MAXSEM     = 48
MAXUTILSEM = 32
```

The old Leopard/PPC build already used these values because the legacy buildsystem defines `LINUX`.

LeooRexx now preserves the existing behavior through an explicit RexxAPI semaphore policy macro.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxapi-semaphore-limits-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Remaining Runtime Question

Whether the current compact semaphore limits are optimal for Mac OS X Leopard / PowerPC is not answered by the build test.

This remains a later Runtime/IPC test item.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

RexxAPI semaphore limit behavior is no longer selected through plain `LINUX`. The existing Leopard/PPC behavior is preserved through an explicit LeooRexx policy macro.  

