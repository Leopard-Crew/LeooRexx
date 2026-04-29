
# ooRexx 3.2.0 Leopard/PPC Build Warning Audit

## Summary

The self-built ooRexx 3.2.0 Leopard/PPC build completed successfully.

The extracted warning list contains 20 compiler warnings:

- 1 ISO C90 unsigned decimal constant warning
- 1 operator new NULL-return warning
- 4 extern-initialized definition warnings
- 13 NULL-used-in-arithmetic warnings in rexutils
- 1 select() argument type mismatch in rxsockfn.c

## Initial Assessment

The build is usable for Phase B. No warning blocks basic runtime execution.

However, the warning list identifies several review targets before this runtime can become the curated LeooRexx core.

## Review Targets

### A1 — Memory allocation audit

File:

```text
kernel/platform/unix/MemorySupport.cpp
````

Reason:

```text
warning: 'operator new' must not return NULL unless it is declared 'throw()'
```

Risk: medium.

### A2 — Runtime global definition audit

Files:

```text
kernel/platform/unix/RexxMain.cpp
kernel/runtime/GlobalData.cpp
```

Reason: initialized extern declarations.

Risk: low to medium.

### A3 — RexxUtil quarantine audit

File:

```text
rexutils/unix/rexxutil.cpp
```

Reason: repeated `NULL used in arithmetic` warnings in semaphore/mutex utility functions.

Risk: medium for utility layer, low for minimal interpreter core.

Decision: quarantine until LeooRexx decides whether `rexxutil` belongs to the curated runtime.

### A4 — RxSock quarantine audit

File:

```text
rexutils/rxsockfn.c
```

Reason:

```text
warning: passing argument 5 of 'select' from incompatible pointer type
```

Risk: medium for socket utility layer.

Decision: quarantine until LeooRexx decides whether RxSock belongs to the curated runtime.

### A5 — Platform identity audit

The build log repeatedly shows macOS/Leopard flags together with Linux platform defines:

```text
-DORX_SYS_STR="MACOSX"
-mmacosx-version-min=10.5
-DLINUX
-DOPSYS_LINUX
```

Risk: medium to high for LeooRexx purity.

Decision: investigate whether these defines are merely historical ooRexx Unix markers or whether they cause Linux-specific code paths on Darwin.

## LeooRexx Consequence

The self-built ooRexx runtime is valid as a reproducible baseline.

It is not yet a curated LeooRexx core.

Before LeooRexx V1, the following must happen:

1. classify core vs optional utility components
    
2. quarantine non-essential libraries
    
3. audit platform defines
    
4. decide whether RexxUtil and RxSock are LeooRexx core, optional, or excluded
    

