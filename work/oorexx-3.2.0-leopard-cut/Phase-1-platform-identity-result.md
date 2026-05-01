# Platform Identity Phase 1 Result

## Result

LeooRexx Platform Identity Phase 1 is complete.

The active Leopard/PPC source and build paths no longer rely on Linux identity macros to select Darwin behavior.

## Completed

```text
AIX/Linux POSIX proxy guards removed
OPSYS_LINUX active source paths removed
plain LINUX active source guards removed
PlatformDefinitions.h cleaned
RexxAPI cleaned
RxSock/RxMath/RexxUtil quarantine guards sanitized
configure.ac/configure no longer emit -DLINUX / -DOPSYS_LINUX for Darwin
````

## Active Darwin Build Identity

The Darwin/Leopard build now emits:

```text
-DLEOOREXX_BUILD_LEOPARD=1
-DLEOOREXX_BUILD_DARWIN=1
```

and retains:

```text
ORX_SYS_STR="MACOSX"
ORX_SHARED_LIBRARY_EXT=".dylib"
```

## Remaining LINUX Mentions

Remaining `LINUX` mentions are classified as:

```text
- real Linux target branches in configure.ac / configure
- comments and historical labels
- disabled #if 0 or commented-out code
- runtime multi-OS compatibility strings
- deferred dead-code / portability-residue material
```

## Explicitly Deferred

Do not remove these residues yet.

Per the future TODO order, dead-code and portability-residue cleanup happens only after:

```text
1. platform identity cleanup
2. buildsystem stabilization
3. full rebuild validation
4. runtime / IPC validation
```

## Remaining Major Follow-up Work

```text
Runtime/IPC tests for RexxAPI semaphore limits
Active built-tools audit: rxmigrate, rxqueue, rxsubcom, rxdelipc
Dead-code and portability-residue scan
Possible later removal of commented legacy Linux/AIX/Sun/OS2 paths
```

## Conclusion

LeooRexx no longer builds Leopard/Darwin by pretending to be Linux.

The source cut now has explicit LeooRexx / Darwin / Leopard / PowerPC identity at both source and buildsystem level.  

