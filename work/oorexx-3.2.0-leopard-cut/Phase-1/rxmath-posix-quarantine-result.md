# RxMath POSIX Quarantine Guard Result

## Change

Three platform guards in:

```text
src/oorexx-3.2.0-leopard/rexutils/rxmath.cpp
````

were changed from AIX/Linux proxy conditions to explicit LeooRexx POSIX guards.

The file now includes:

```c
#include "../kernel/platform/leopard/LeooRexxPlatform.h"
```

so LeooRexx platform macros are available before the first RxMath platform guard.

## Rationale

The affected RxMath guards distinguish Unix/POSIX-style package behavior from Windows or other legacy paths.

They do not represent Linux platform identity.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rxmath-posix-quarantine-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Quarantine Note

RxMath remains RexUtils quarantine material.

This cleanup clarifies platform semantics only. It does not promote RxMath to LeooRexx core.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

RxMath no longer uses plain `LINUX` or AIX/Linux proxy guards for its active LeooRexx/POSIX path, while remaining outside the LeooRexx core.  
