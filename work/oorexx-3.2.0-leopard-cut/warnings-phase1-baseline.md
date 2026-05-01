# Phase 1 Warning Baseline

## Source

```text
build-work/phase1-platform-identity-baseline/build-phase1-platform-identity-baseline.log
````

## Warning Groups

```text
12x rexutils/unix/rexxutil.cpp
    NULL used in arithmetic

3x kernel/platform/unix/RexxMain.cpp
    extern variable initialized

1x kernel/runtime/GlobalData.cpp
    extern variable initialized

1x kernel/platform/unix/MemorySupport.cpp
    operator new must not return NULL unless throw() / -fcheck-new

1x kernel/classes/NumberStringClass.cpp
    decimal constant is unsigned only in ISO C90
```

## Cleanup Order

```text
1. NumberStringClass.cpp literal warning
2. RexxMain.cpp / GlobalData.cpp extern-initialization warnings
3. MemorySupport.cpp operator new warning
4. RexxUtil NULL arithmetic warnings, quarantine-only
```

## Rule

Warning cleanup must happen in small isolated commits with a build test after each group.

RexxUtil warning cleanup does not promote RexxUtil to LeooRexx core.  

