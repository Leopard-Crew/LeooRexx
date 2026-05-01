# RexxCore CXX Method Pointer Guard Result

## Change

The C++ method pointer compatibility guard in:

```text
src/oorexx-3.2.0-leopard/kernel/runtime/RexxCore.h
````

was changed from:

```c
#ifdef LINUX
```

to:

```c
#if LEOOREXX_CXX_UNIFORM_METHOD_POINTER_CASTS
```

A dedicated LeooRexx platform feature macro was added in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/leopard/LeooRexxPlatform.h
```

```c
#define LEOOREXX_CXX_UNIFORM_METHOD_POINTER_CASTS 1
```

## Rationale

The guarded block does not represent Linux platform identity.

It selects a C++ method pointer compatibility model where many `CPPM*` method pointer macros map to the same uniform `CPPM(n)` cast.

The old `LINUX` guard selected the correct active path for the Leopard/GCC build only because the legacy buildsystem still defined `LINUX`.

LeooRexx now expresses the actual meaning directly.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxcore-cxx-method-pointer-test
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

The Runtime Core no longer uses plain `LINUX` to select the active C++ method pointer compatibility path. The behavior is preserved through an explicit LeooRexx feature macro.  

