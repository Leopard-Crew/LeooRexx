# Phase 2.6 Installed Environment Contract Plan

## Purpose

Phase 2.6 defines the installed runtime environment contract for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2.5 proved that LeooRexx works from an installed prefix when the environment is set manually.

Phase 2.6 answers the next question:

```text
How should an installed LeooRexx prefix be activated cleanly on Leopard?
````

## Background

The Phase 2.5 install prefix smoke used:

```text
PATH=<prefix>/bin:$PATH
NLSPATH=<prefix>/bin/%N:<prefix>/bin/%N.cat:<prefix>/bin/rexx.cat
```

The installed runtime worked successfully with this environment.

However, a user or system component should not need to guess these variables.

LeooRexx needs an explicit environment contract.

## Test Prefix

Reference prefix from Phase 2.5:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
```

Future stable prefix may differ.

## Required Runtime Environment

### PATH

LeooRexx command-line tools are installed in:

```text
<prefix>/bin
```

Therefore:

```text
PATH=<prefix>/bin:$PATH
```

is required for shell-level command discovery.

### NLSPATH

The message catalog is installed in:

```text
<prefix>/bin/rexx.cat
```

The verified Phase 2.5 catalog path was:

```text
NLSPATH=<prefix>/bin/%N:<prefix>/bin/%N.cat:<prefix>/bin/rexx.cat
```

This allowed installed tools such as `rxqueue` to find the message catalog.

### DYLD_LIBRARY_PATH

The install log reported libtool guidance about installed libraries in:

```text
<prefix>/lib/ooRexx
```

Phase 2.5 did not yet prove whether normal installed runtime execution requires:

```text
DYLD_LIBRARY_PATH=<prefix>/lib/ooRexx:$DYLD_LIBRARY_PATH
```

This must be tested explicitly.

## Environment Contract Candidates

### Candidate A: Minimal CLI Contract

```sh
export LEOOREXX_HOME="<prefix>"
export PATH="$LEOOREXX_HOME/bin:$PATH"
export NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
```

This is the verified Phase 2.5 behavior.

### Candidate B: CLI Contract With Library Path

```sh
export LEOOREXX_HOME="<prefix>"
export PATH="$LEOOREXX_HOME/bin:$PATH"
export NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export DYLD_LIBRARY_PATH="$LEOOREXX_HOME/lib/ooRexx:$DYLD_LIBRARY_PATH"
```

This may be required for extension libraries or later embedded use.

It should not be added unless testing proves it is needed.

## Proposed Helper Script

A Leopard-native but shell-friendly activation file may be installed as:

```text
<prefix>/share/LeooRexx/leoorxenv.sh
```

or:

```text
<prefix>/bin/leoorxenv.sh
```

Preferred initial test location:

```text
<prefix>/bin/leoorxenv.sh
```

because the existing install layout already places runtime-facing files in `bin`.

## Proposed Initial Script

```sh
# LeooRexx environment for Mac OS X 10.5.8 PowerPC

LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

`DYLD_LIBRARY_PATH` is intentionally omitted until proven necessary.

## Tests

### 1. Clean Shell Without Manual Runtime Variables

Start from a clean shell state:

```sh
unset LEOOREXX_HOME
unset NLSPATH
```

Avoid manually adding the prefix to `PATH`.

### 2. Source Environment Script

```sh
. <prefix>/bin/leoorxenv.sh
```

### 3. Verify Tool Discovery

```sh
which rexx
which rxqueue
which rxsubcom
which rxdelipc
```

### 4. Verify Runtime

```sh
rexx -v
rxqueue --help
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
rxdelipc -h
```

### 5. Verify Queue Smoke

Run the installed queue smoke through the environment script only.

### 6. Verify Subcommand Smoke

Run the installed subcommand smoke through the environment script only.

### 7. Verify IPC State

Before and after tests:

```sh
ipcs -s
ipcs -m
```

Expected after normal tests:

```text
Only the normal RexxAPI anchor remains.
```

## Success Criteria

Phase 2.6 succeeds if:

```text
- one documented activation script is sufficient
- PATH resolves installed tools
- NLSPATH resolves installed message catalog
- rexx / rxqueue / rxsubcom / rxdelipc behave as expected
- queue smoke passes
- subcommand smoke passes
- no DYLD_LIBRARY_PATH is needed for the basic installed CLI runtime
- IPC state remains clean
```

## Open Question

The basic CLI runtime may not need `DYLD_LIBRARY_PATH`.

However, extension loading may require it later.

Therefore Phase 2.6 should distinguish:

```text
Basic CLI runtime contract
```

from:

```text
Extension / embedding runtime contract
```

## Interpretation

This phase turns the installed prefix from a manually tested artifact into a defined runtime environment.

This is the beginning of proper Leopard system integration.

