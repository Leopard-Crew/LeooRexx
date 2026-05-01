# RexxAPI Header Platform Include Result

## Finding

After the RexxAPI header platform guard cleanup, the first RxMath quarantine test exposed a follow-up issue in sample/tool builds.

The build failed with errors like:

```text
rexxapi/unix/rexx.h: error: 'tid_t' has not been declared
````

## Cause

`rexxapi/unix/rexx.h` had been updated to use LeooRexx platform macros such as:

```c
LEOOREXX_PLATFORM_POSIX
```

But in some build contexts, especially samples/tools, the LeooRexx platform macro header was not visible before those guards were evaluated.

As a result, the preprocessor treated the undefined macro as `0` and selected the legacy `tid_t` path instead of the intended `pthread_t` path.

## Fix

`rexxapi/unix/rexx.h` now includes:

```c
#include "../../kernel/platform/leopard/LeooRexxPlatform.h"
```

before using LeooRexx platform macros.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh rexxapi-header-platform-include-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

The previously observed `tid_t` failure is no longer present.

## Note

This was not caused by the RxMath guard change itself.

The RxMath test exposed a visibility bug in the earlier RexxAPI header platform-guard cleanup.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

LeooRexx platform macros are now visible in RexxAPI header consumers, including samples/tools.  

