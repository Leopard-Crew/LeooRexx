# Phase 2.7 Leopard-native Activation Packaging Plan

## Purpose

Phase 2.7 defines how LeooRexx should expose its verified installed environment contract in a Leopard-native way.

Phase 2.6 proved that the basic installed CLI runtime needs only:

```sh
LEOOREXX_HOME="<prefix>"
PATH="$LEOOREXX_HOME/bin:$PATH"
NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
````

and does not require:

```sh
DYLD_LIBRARY_PATH
```

for normal command-line runtime use.

Phase 2.7 turns this contract into activation packaging.

## Guiding Principle

LeooRexx must not require global system hacks.

No global `DYLD_LIBRARY_PATH`.

No fragile shell-profile assumptions.

No hidden dependency on a user manually remembering environment variables.

The activation contract should be explicit, small, and usable by Leopard-native integration layers.

## Activation Targets

### 1. CLI / Terminal

The CLI needs a sourceable shell activation file.

Proposed file:

```text
<prefix>/bin/leoorxenv.sh
```

Initial role:

```text
source this file before using LeooRexx tools from a shell
```

Example:

```sh
. /Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

### 2. Script Wrapper

For later convenience, a wrapper may launch commands with the correct environment without requiring the caller to source anything.

Possible future name:

```text
leoorx
```

Example future usage:

```sh
leoorx rexx script.rexx
leoorx rxqueue /CLEAR
```

This is not required yet, but should remain a candidate.

### 3. App Bundle / Services / Automator

Native Leopard entry points will not necessarily inherit a user Terminal environment.

Therefore they must inject the LeooRexx environment explicitly.

Future integration points:

```text
- .app launcher
- Services provider
- Automator action
- LaunchAgent
- Finder workflow helper
```

These should not rely on `.profile`, `.bashrc`, or global shell state.

They should either:

```text
- source the same environment file where shell-compatible
- or embed the same contract in their launch code
```

### 4. Build / Install System

The current `make install` does not install a LeooRexx-specific activation file.

Phase 2.7 should first prove the file manually.

Later work may integrate generation/install into the build system.

## Candidate File: leoorxenv.sh

Current tested prototype:

```sh
# LeooRexx environment for Mac OS X 10.5.8 PowerPC

LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

## Packaging Questions

### Prefix Hardcoding

The prototype hardcodes the test prefix.

For production, the file should be generated at install time with the chosen prefix.

Question:

```text
Should leoorxenv.sh be generated from a template?
```

Likely answer:

```text
yes
```

### Location

Possible locations:

```text
<prefix>/bin/leoorxenv.sh
<prefix>/share/LeooRexx/leoorxenv.sh
```

Initial preference:

```text
<prefix>/bin/leoorxenv.sh
```

Reason:

```text
The current installed runtime already puts runtime-facing assets in bin, including rexx.cat and rexx.img.
```

A later more polished layout may move support files to `share/LeooRexx`.

### Naming

Candidate names:

```text
leoorxenv.sh
leooenv.sh
leorexxenv.sh
```

Preferred initial name:

```text
leoorxenv.sh
```

Reason:

```text
short, explicit, project-specific, shell-oriented
```

## Success Criteria

Phase 2.7 succeeds when:

```text
- the activation packaging model is documented
- leoorxenv.sh is accepted as the initial CLI activation file
- no DYLD_LIBRARY_PATH is introduced for basic CLI runtime
- future native entry points are required to inject the environment explicitly
- shell profile modification is treated as optional user convenience, not required architecture
```

## Non-Goals

Phase 2.7 does not yet implement:

```text
- .app launcher
- Automator action
- macOS Services provider
- LaunchAgent integration
- build-system generation of leoorxenv.sh
```

These are later integration tasks.

## Conclusion

LeooRexx activation should be explicit and local to the installed prefix.

The first packaging artifact should be:

```text
<prefix>/bin/leoorxenv.sh
```

This keeps the CLI path simple while preserving a clean route toward Leopard-native entry points.  

