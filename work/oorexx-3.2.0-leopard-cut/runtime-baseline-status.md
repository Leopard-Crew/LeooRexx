# LeooRexx Runtime Baseline Status

## Purpose

This document summarizes the current verified LeooRexx runtime baseline after Phase 2, Phase 2.5, and Phase 2.6.

It records the stable checkpoints that are currently safe to build upon.

## Verified Tags

### Phase 2 Runtime / IPC Baseline

```text
phase2-runtime-ipc-baseline
````

Meaning:

```text
The build-work runtime and RexxAPI IPC baseline are verified.
```

Confirmed:

```text
- warning-clean build baseline
- queue tool smoke
- subcommand tool smoke
- repeatability tests
- RexxAPI reserved semaphore member fix
- Queue_Detach cleanup fix
- Leopard compact semaphore profile raised to 128 / 64
- 63 named queues verified
```

### Phase 2.5 Install / Prefix Smoke

```text
phase2_5-install-prefix-smoke
```

Meaning:

```text
LeooRexx works from a clean installed Leopard prefix.
```

Confirmed:

```text
- make install succeeds
- required binaries are installed
- rexx.cat is installed
- installed rexx starts
- installed rxqueue works
- installed rxsubcom works
- installed rxdelipc works
- queue smoke passes from installed prefix
- subcommand smoke passes from installed prefix
- isolated IPC state remains clean
```

### Phase 2.6 Installed Environment Contract

```text
phase2_6-installed-environment-contract
```

Meaning:

```text
The basic installed command-line runtime has a verified environment contract.
```

Confirmed environment:

```sh
LEOOREXX_HOME="<prefix>"
PATH="$LEOOREXX_HOME/bin:$PATH"
NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
```

Confirmed not required for basic CLI runtime:

```sh
DYLD_LIBRARY_PATH
```

## Current Runtime Interpretation

LeooRexx is now verified as:

```text
- warning-clean
- build-work runnable
- RexxAPI IPC stable
- queue-capacity verified
- installed-prefix runnable
- environment-contract defined
```

The current baseline is suitable for continued Leopard-native integration work.

## Important Known Follow-Up

The fresh RXHOME anchor initialization bug remains known and separate.

It should be handled as its own follow-up issue and must not be mixed with the already verified default HOME-based runtime baseline.

## Next Candidate Work Blocks

Possible next blocks:

```text
1. Fresh RXHOME anchor bug investigation
2. Leopard-native activation packaging
3. Installed helper script generation
4. Services / Automator / App bundle environment strategy
5. Dead-code and portability-residue scan
```

Recommended next step:

```text
Leopard-native activation packaging
```

Reason:

```text
The runtime works and the environment contract is known.
The next Cupertino-2009 step is to decide how Leopard users and system components activate that contract cleanly.
```

## Status

```text
Runtime baseline: stable
Install prefix: stable
Basic CLI environment contract: stable
Fresh RXHOME: known separate issue
```

