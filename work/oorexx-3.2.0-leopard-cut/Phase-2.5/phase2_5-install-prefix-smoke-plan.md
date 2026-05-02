# Phase 2.5 Install / Prefix Smoke Plan

## Purpose

Phase 2.5 verifies that the LeooRexx runtime does not only work from a build directory, but also from a clean installed Leopard prefix.

Phase 2 proved the runtime / IPC baseline from build output.

Phase 2.5 moves the same confidence one step closer to real use.

## Goal

Verify an installed LeooRexx prefix on Mac OS X 10.5.8 PowerPC.

The installed prefix must provide:

```text
rexx
rexxc
rxqueue
rxsubcom
rxdelipc
rxmigrate
rexx.cat
````

## Proposed Test Prefix

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
```

This prefix is intentionally separate from previous test prefixes.

## Required Checks

### 1. Fresh Build Availability

Use a fresh or known-good build directory.

Recommended build name:

```text
build-work/phase2_5-install-prefix-smoke
```

### 2. Install Step

Run `make install` into the dedicated prefix.

Expected result:

```text
install succeeds without errors
```

### 3. Installed File Layout

Verify installed runtime files.

Required binaries:

```text
bin/rexx
bin/rexxc
bin/rxqueue
bin/rxsubcom
bin/rxdelipc
bin/rxmigrate
```

Required catalog:

```text
bin/rexx.cat
```

or another catalog location explicitly used by the build.

### 4. Basic Runtime Invocation

Verify:

```text
rexx -v
```

from the installed prefix.

### 5. Message Catalog Behavior

Verify that installed tools can find `rexx.cat` without manually copying it into the build directory.

If needed, test with:

```text
NLSPATH=<prefix>/bin/%N:<prefix>/bin/%N.cat:<prefix>/bin/rexx.cat
```

### 6. Queue Tool Smoke

Verify installed `rxqueue` works:

```text
rxqueue /CLEAR
printf 'alpha\nbeta\n' | rxqueue /FIFO <created queue>
```

Actual created queue testing should be done through a Rexx script.

### 7. Subcommand Tool Smoke

Verify installed `rxsubcom` works:

```text
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
```

Expected result:

```text
non-zero return for missing registration
```

### 8. Queue Capacity Smoke

Run a reduced installed-prefix queue verification.

The full 63-queue boundary test may be repeated if needed, but Phase 2.5 primarily needs to prove that the installed prefix behaves like the build-work runtime.

### 9. IPC State Check

Before and after tests, inspect:

```text
ipcs -s
ipcs -m
```

Expected result after normal tests:

```text
only the normal RexxAPI anchor remains
no unexpected extra queue-memory residue
```

## Known Separate Issue

Fresh `RXHOME` anchor initialization remains a separate known bug from Phase 2.

Phase 2.5 should use the default HOME-based RexxAPI anchor unless the test specifically targets RXHOME behavior.

## Success Criteria

Phase 2.5 is successful when:

```text
- make install succeeds
- installed rexx -v works
- installed message catalog lookup works
- installed rxqueue smoke works
- installed rxsubcom smoke works
- installed queue runtime behavior matches the build-work baseline
- IPC state remains clean after tests
```

## Interpretation

Phase 2.5 answers the question:

```text
Does LeooRexx work from an installed Leopard prefix, not only from the build directory?
```

