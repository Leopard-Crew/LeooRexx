# RexxCompiler Catalog POSIX Guard Result

## Change

The message catalog parameter guard in:

```text
src/oorexx-3.2.0-leopard/platform/unix/RexxCompiler.cpp
````

was changed from:

```c
#ifdef LINUX
#define SECOND_PARAMETER 1              /* different sign. Lin-AIX            */
#define CATD_ERR -1
#else
#define SECOND_PARAMETER 0              /* 0 for no  NL_CAT_LOCALE            */
#endif
```

to:

```c
#if LEOOREXX_PLATFORM_POSIX
#define SECOND_PARAMETER 1              /* different sign. POSIX/AIX          */
#define CATD_ERR -1
#else
#define SECOND_PARAMETER 0              /* 0 for no  NL_CAT_LOCALE            */
#endif
```

## Rationale

This block controls POSIX/Unix message catalog behavior for `catopen()` / `catgets()` in the Rexx compiler tool.

The old guard used `LINUX` as a proxy for the active POSIX message catalog path. LeooRexx now expresses this through `LEOOREXX_PLATFORM_POSIX`.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxcompiler-catalog-posix-test
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

The RexxCompiler message catalog guard can use explicit LeooRexx POSIX semantics without breaking the Leopard/PPC build.  

