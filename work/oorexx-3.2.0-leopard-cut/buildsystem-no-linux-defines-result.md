# Buildsystem No Linux Defines Result

## Change

The buildsystem platform identity was changed in:

```text
src/oorexx-3.2.0-leopard/configure.ac
src/oorexx-3.2.0-leopard/configure
````

The generic default no longer emits:

```text
-DLINUX
-DOPSYS_LINUX
```

The Darwin / Leopard build path now emits:

```text
-DLEOOREXX_BUILD_LEOPARD=1
-DLEOOREXX_BUILD_DARWIN=1
```

while retaining:

```text
ORX_SYS_STR="MACOSX"
ORX_SHARED_LIBRARY_EXT=".dylib"
```

## Rationale

After active source-level cleanup, the LeooRexx Leopard/PPC source cut no longer needs Linux identity macros to select the correct active code paths.

The old buildsystem behavior made Darwin appear as Linux internally. This contradicted the LeooRexx platform identity model.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh buildsystem-no-linux-defines-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

The build log no longer shows:

```text
-DLINUX
-DOPSYS_LINUX
```

and does show:

```text
-DLEOOREXX_BUILD_LEOPARD=1
-DLEOOREXX_BUILD_DARWIN=1
```

The normal binaries and tools were generated, including:

```text
rexxc
rxmigrate
rxqueue
rxsubcom
rxdelipc
```

## Remaining Debt

The generated tools still require later classification:

```text
rxmigrate
rxqueue
rxsubcom
rxdelipc
```

Runtime/IPC tests remain deferred until after platform identity cleanup is fully stabilized.

Dead-code and portability-residue removal remains deferred until after build/runtime stability checks.

## Conclusion

LeooRexx no longer requires Linux build defines for the active Leopard/PPC build path.  
