# POSIX Message Catalog Guard Replacement Result

## Change

One occurrence each in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/ErrorMessages.cpp
src/oorexx-3.2.0-leopard/platform/unix/RexxCompiler.cpp
src/oorexx-3.2.0-leopard/rexxapi/unix/SUBCOMCommand.cpp
````

was changed from:

```c
# if defined(OPSYS_LINUX) && !defined(OPSYS_SUN)
```

to:

```c
# if LEOOREXX_PLATFORM_POSIX
```

## Rationale

The guarded blocks implement message catalog fallback behavior using `catopen()`, `catgets()`, and `ORX_CATDIR`.

This is POSIX/Unix catalog behavior in the LeooRexx Leopard/PPC source cut and must not be expressed through the historical `OPSYS_LINUX` proxy or `OPSYS_SUN` exclusion.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh posix-message-catalog-test
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Conclusion

The message catalog fallback guards can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

