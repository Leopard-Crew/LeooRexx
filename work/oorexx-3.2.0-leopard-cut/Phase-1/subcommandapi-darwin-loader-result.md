# SubcommandAPI Darwin Loader Guard Result

## Change

The loader-path guard in:

```text
src/oorexx-3.2.0-leopard/rexxapi/unix/SubcommandAPI.cpp
````

was changed from:

```c
#ifdef LINUX
```

to:

```c
#if LEOOREXX_PLATFORM_DARWIN
```

## Rationale

The guarded block participates in the Unix dynamic-loader path used by the active Leopard/Darwin build.

The old guard selected this path through the historical `LINUX` macro. LeooRexx now expresses the active target explicitly as Darwin.

## Note

The local `error` variable remains intentionally in place for now.

It appears to be legacy residue, but dead-code and portability-residue removal is deferred until after platform identity cleanup, buildsystem cleanup, and runtime/IPC validation.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh subcommandapi-darwin-loader-test
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

The RexxAPI Subcommand loader path no longer relies on plain `LINUX` for the active LeooRexx/Darwin build.  
