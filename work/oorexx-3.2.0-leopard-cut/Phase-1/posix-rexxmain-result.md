# POSIX RexxMain Guard Replacement Result

## Change

One occurrence in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/RexxMain.cpp
````

was changed from:

```c
#if defined(AIX) || defined(LINUX)
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
```

## Rationale

The guarded block implements Unix/POSIX-style runtime termination and synchronization behavior.

In the LeooRexx Leopard/PPC source cut, this must be expressed as explicit POSIX platform behavior rather than through the historical AIX/Linux proxy.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh posix-rexxmain-test
```

Result:

```text
Build test completed successfully.
Smoke test completed.
```

## Conclusion

The RexxMain runtime termination guard can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

