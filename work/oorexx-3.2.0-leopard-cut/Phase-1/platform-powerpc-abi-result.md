# Platform PowerPC ABI Guard Result

## Change

The PowerPC ABI guard in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/PlatformDefinitions.h
````

was changed from:

```c
#if defined(LINUX) && defined(PPC)
```

to:

```c
#if LEOOREXX_ABI_POWERPC_DARWIN
```

## Rationale

The guarded block defines varargs / ABI-related value types for the active PowerPC build path.

This is not Linux identity. In the LeooRexx Leopard/PPC source cut, the meaning is explicit:

```text
PowerPC Darwin ABI behavior
```

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh platform-powerpc-abi-test
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

The build also continues to generate legacy/non-core tools such as:

```text
rxmigrate
rxqueue
rxsubcom
rxdelipc
```

These remain part of the active built-tools audit.

## Conclusion

The PowerPC ABI guard can use explicit LeooRexx Darwin/PowerPC ABI semantics without breaking the Leopard/PPC build.  

