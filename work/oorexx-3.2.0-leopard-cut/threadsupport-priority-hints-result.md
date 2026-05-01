# ThreadSupport Priority Hints Guard Result

## Change

The thread scheduling / priority hint guard in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/ThreadSupport.cpp
````

was changed from:

```c
#if defined(OPSYS_AIX43) || defined(LINUX) ||  defined OPSYS_SUN
```

to:

```c
#if defined(OPSYS_AIX43) || LEOOREXX_PTHREAD_PRIORITY_HINTS || defined(OPSYS_SUN)
```

A dedicated LeooRexx platform feature macro was added in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/leopard/LeooRexxPlatform.h
```

```c
#define LEOOREXX_PTHREAD_PRIORITY_HINTS 1
```

## Rationale

This block controls pthread scheduling / priority hint behavior during thread creation.

The old `LINUX` guard was not a true Linux identity check in the LeooRexx Leopard/PPC source cut. It selected an existing pthread scheduling path for Darwin only because the old buildsystem still defines `LINUX`.

The new guard preserves the previously active behavior while expressing the real intent explicitly.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh threadsupport-priority-hints-test
```

Result:

```text
Build completed successfully.
Smoke test completed.
```

## Remaining Warnings

The build still shows known RexxUtil quarantine warnings:

```text
NULL used in arithmetic
```

These are unrelated to the ThreadSupport guard change.

## Remaining Debt

The buildsystem still emits:

```text
-DLINUX
-DOPSYS_LINUX
```

This remains buildsystem-level platform identity debt.

## Conclusion

ThreadSupport no longer relies on plain `LINUX` to activate pthread priority hints. The active Leopard/PPC behavior is preserved through an explicit LeooRexx feature macro.  

