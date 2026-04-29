# POSIX StreamNative Guard Replacement Result

## Change

Occurrences in:

```text
src/oorexx-3.2.0-leopard/kernel/streamLibrary/StreamNative.h
src/oorexx-3.2.0-leopard/kernel/streamLibrary/StreamNative.cpp
````

were changed from:

```c
#if defined(AIX) || defined(LINUX)
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
```

`StreamNative.h` now explicitly includes the LeooRexx platform identity header before using LeooRexx platform macros.

## Rationale

The guarded blocks implement Unix/POSIX-style stream, file, standard-input and standard-output behavior.

In the LeooRexx Leopard/PPC source cut, this behavior must be expressed as explicit POSIX platform behavior instead of the historical AIX/Linux proxy.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh posix-streamnative-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Observation

The global build flags still contain:

```text
-DLINUX
-DOPSYS_LINUX
```

This is expected at this stage. The current change only replaces semantic guard usage in `StreamNative`. Buildsystem-level platform macro cleanup remains a later step.

## Conclusion

The StreamNative I/O guards can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

