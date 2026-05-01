# Active Linux Proxy Map

This document classifies active `LINUX` / `OPSYS_LINUX` usage in the ooRexx 3.2.0 Leopard/PPC source cut.

The goal is not to remove these defines blindly. The goal is to understand their meaning before creating a deterministic Darwin/Leopard platform layer.

## Classification

### A — POSIX / Unix-generic behavior

`LINUX` is used as a generic Unix/POSIX path and should later become an explicit `POSIX`, `UNIX`, or `DARWIN` guard.

### B — Darwin-compatible but mislabeled

The code appears to work on Darwin/Leopard, but the platform label is wrong.

### C — Linux-specific behavior

The code appears to rely on Linux-specific assumptions and must not remain in the LeooRexx core without replacement.

### D — OS/2 guard disguised as Linux

`LINUX` is used to prevent old OS/2 / Presentation Manager / Dos* code from being compiled.

### E — Optional utility layer / quarantine

The code belongs to `rexutils`, `rxsock`, or another optional layer and should not be treated as core before review.

### F — Samples / non-core

The occurrence is outside the runtime core.

## Initial Mapping

### configure / configure.ac

```text
configure.ac
configure
````

Current behavior:

```text
GENERIC_OS="-DLINUX"
GENERIC_OPSYS="-DOPSYS_LINUX"
*apple-darwin*) ORX_SYS_STR="MACOSX"
```

Classification:

```text
B — Darwin-compatible but mislabeled
```

LeooRexx target:

```text
Replace generic Linux identity with explicit Darwin / POSIX / Leopard identity.
```

---

### kernel/platform/unix/PlatformDefinitions.h

Classification:

```text
A / B / D mixed
```

Reason:

This file contains core platform typedefs and ABI-related definitions. Some `LINUX` usage means Unix/POSIX behavior, some prevents non-Unix legacy paths, and some affects PowerPC varargs behavior.

High priority audit.

LeooRexx target:

```text
Split semantic meanings:
- POSIX / Darwin platform basics
- PowerPC ABI behavior
- OS/2 legacy guards
```

---

### kernel/platform/unix/MiscSystem.cpp

Classification:

```text
D — OS/2 guard disguised as Linux
```

Reason:

`LINUX` prevents OS/2 Presentation Manager / Dos* / Win* code from compiling.

LeooRexx target:

```text
Replace negative guard logic with explicit OS/2-only guards or remove OS/2 path from active cut.
```

---

### kernel/platform/unix/MemorySupport.cpp

Classification:

```text
B — Darwin-compatible but mislabeled
```

Reason:

`PAGESIZE` is set to 4096 under `LINUX`. On the tested iMac G5 Leopard system, `getconf PAGESIZE` returns 4096.

LeooRexx target:

```text
Use Darwin/POSIX page size mechanism explicitly.
Avoid Linux-labeled page assumptions.
```

---

### kernel/platform/unix/FileSystem.cpp

Classification:

```text
A / B mixed
```

Reason:

Uses Unix/POSIX-style file and stream handling. Some logic may be portable, but Linux labels are semantically wrong for Darwin.

LeooRexx target:

```text
Audit whether Foundation / Darwin APIs should replace helper behavior in the LeooRexx layer.
```

---

### kernel/runtime/RexxStartup.cpp

Classification:

```text
A — POSIX / Unix-generic behavior
```

Reason:

Runtime startup uses `AIX || LINUX` as broad Unix-like path.

LeooRexx target:

```text
Replace with explicit POSIX / Darwin startup path after review.
```

---

### kernel/streamLibrary/StreamNative.cpp / StreamNative.h

Classification:

```text
A / B mixed
```

Reason:

Native stream handling uses AIX/Linux guards for Unix-like behavior.

LeooRexx target:

```text
Audit stream behavior against Darwin/POSIX and Foundation expectations.
```

---

### platform/unix/rexx.cpp

Classification:

```text
A / D mixed
```

Reason:

Uses `!AIX && !LINUX` style guards, likely to avoid non-Unix legacy paths.

LeooRexx target:

```text
Make Darwin entry point explicit.
```

---

### platform/unix/RexxCompiler.cpp

Classification:

```text
A / B mixed
```

Reason:

Compiler utility path uses `OPSYS_LINUX` as Unix-like branch.

LeooRexx target:

```text
Decide whether rexxc belongs to LeooRexx core or quarantine.
```

---

### rexxapi/unix/*

Classification:

```text
A / B mixed
```

Reason:

The Unix Rexx API uses Linux/AIX/Sun-style guards. It may be needed for embedding and external function support, but it must be reviewed before becoming LeooRexx core.

LeooRexx target:

```text
Keep only the minimal API required for embedding and ADDRESS/capability support.
```

---

### rexutils/rxmath.cpp

Classification:

```text
E — optional utility layer / quarantine
```

Reason:

Math utility package is useful but not necessarily part of the minimal LeooRexx core.

LeooRexx target:

```text
Quarantine until the curated runtime profile is defined.
```

---

### rexutils/rxsock.c / rxsockfn.c / rxsock.h

Classification:

```text
E — optional utility layer / quarantine
```

Reason:

Socket helper package is optional and has at least one build warning around `select()` argument typing.

LeooRexx target:

```text
Do not treat RxSock as core. Future networking should prefer native Leopard/Darwin capability design.
```

---

### rexutils/unix/rexxutil.cpp

Classification:

```text
E — optional utility layer / quarantine
```

Reason:

RexxUtil contains repeated warnings and system helper behavior that may duplicate native Leopard facilities.

LeooRexx target:

```text
Quarantine. Replace Leopard-facing helper behavior with native AppKit/Foundation/Darwin mechanisms where needed.
```

---

### samples/rexxtry.rex

Classification:

```text
F — samples / non-core
```

Reason:

Sample material is not runtime core.

LeooRexx target:

```text
Exclude from active runtime cut.
```

## Summary

The current Leopard/PPC build uses `LINUX` / `OPSYS_LINUX` as an active proxy for several different meanings:

```text
1. Unix/POSIX behavior
2. Darwin-compatible behavior with wrong naming
3. OS/2 guard logic
4. optional utility package behavior
5. sample/non-core material
```

LeooRexx must not preserve this ambiguity.

## Rule

No LeooRexx platform path may use `LINUX` as an alias for Darwin, POSIX, Unix, or "not OS/2".

Linux must mean Linux.

Darwin must mean Darwin.

POSIX must mean POSIX.

Leopard must mean the LeooRexx reference platform.  
