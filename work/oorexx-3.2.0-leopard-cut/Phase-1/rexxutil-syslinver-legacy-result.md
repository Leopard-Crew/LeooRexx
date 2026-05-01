# RexxUtil SysLinVer Legacy Linux Result

## Change

Two active `LINUX` guards in:

```text
src/oorexx-3.2.0-leopard/rexutils/unix/rexxutil.cpp
````

were changed from:

```c
#ifdef LINUX
```

to:

```c
#if LEOOREXX_LEGACY_LINUX
```

## Affected Function

```text
SysLinVer
```

## Rationale

`SysLinVer` is a Linux-specific RexxUtil function.

It must not be exported or compiled into the active LeooRexx/Darwin path merely because the legacy buildsystem still defines `LINUX`.

This is not a POSIX function and must not be reinterpreted as Darwin behavior.

## Quarantine Note

RexxUtil remains quarantine material.

This cleanup restricts a Linux-specific function to legacy Linux only. It does not promote RexxUtil to LeooRexx core.

## Commented Residue

A commented-out legacy block remains in `rexxutil.cpp`:

```text
//#ifdef LINUX
```

This is inactive code/comment residue and is intentionally left for the later dead-code and portability-residue scan.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxutil-syslinver-legacy-test
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

The last active Linux-specific RexxUtil function is no longer selected through plain `LINUX` for the LeooRexx/Darwin build.

