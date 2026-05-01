# POSIX RexxUtil Guard Replacement Result

## Change

Two occurrences in:

```text
src/oorexx-3.2.0-leopard/rexutils/unix/rexxutil.cpp
````

were changed from:

```c
#if defined(AIX) || defined(LINUX)
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
```

## Rationale

The guarded blocks use POSIX/Unix-style utility behavior. In the LeooRexx source cut, this must not be expressed through the historical AIX/Linux proxy.

## Quarantine Note

RexxUtil remains in quarantine.

This cleanup clarifies platform semantics only. It does not promote RexxUtil to LeooRexx core.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh posix-rexxutil-test
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Remaining Warnings

The known RexxUtil warnings remain and are still part of the RexxUtil quarantine audit:

```text
NULL used in arithmetic
```

The known RxSock `select()` warning also remains outside the RexxUtil change scope.

## Conclusion

RexxUtil POSIX guard semantics were clarified without breaking the Leopard/PPC build. RexxUtil remains quarantined until a later core/profile decision.  

