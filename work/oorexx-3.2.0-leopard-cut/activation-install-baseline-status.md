# LeooRexx Activation / Install Baseline Status

## Purpose

This document summarizes the verified LeooRexx activation and installation baseline after Phase 2.6 through Phase 2.9.

It records the current state of the installed runtime activation chain.

## Verified Tags

### Phase 2.6 Installed Environment Contract

```text
phase2_6-installed-environment-contract
````

Meaning:

```text
The basic installed command-line runtime has a verified environment contract.
```

Verified contract:

```sh
LEOOREXX_HOME="<prefix>"
PATH="$LEOOREXX_HOME/bin:$PATH"
NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
```

Verified not required for basic CLI runtime:

```sh
DYLD_LIBRARY_PATH
```

### Phase 2.7 Activation Packaging

```text
phase2_7-activation-packaging
```

Meaning:

```text
LeooRexx has a documented activation packaging model.
```

Confirmed:

```text
- CLI activation usage documented
- leoorxenv.sh.in template added
- standalone generator added
- generated activation file tested on Leopard/PPC
```

Relevant files:

```text
tools/templates/leoorxenv.sh.in
tools/generate_leoorxenv.sh
work/oorexx-3.2.0-leopard-cut/Phase-2.7/
```

### Phase 2.8 leoorxenv Install Hook

```text
phase2_8-leoorxenv-install-hook
```

Meaning:

```text
make install now generates and installs leoorxenv.sh automatically.
```

Confirmed:

```text
- <prefix>/bin/leoorxenv.sh is generated during make install
- placeholder substitution works
- generated file contains the actual install prefix
- activation uses installed prefix tools, not /usr/bin fallback tools
```

Buildsystem files touched:

```text
src/oorexx-3.2.0-leopard/Makefile.am
src/oorexx-3.2.0-leopard/Makefile.in
```

### Phase 2.9 DESTDIR Install Behavior

```text
phase2_9-destdir-install-behavior
```

Meaning:

```text
The leoorxenv.sh install hook is DESTDIR-safe for staged packaging.
```

Confirmed:

```text
- make install DESTDIR=<package-root> prefix=<runtime-prefix> succeeds
- leoorxenv.sh is installed under DESTDIR + prefix
- generated content uses prefix without DESTDIR
- no direct runtime-prefix write occurs during staged install
```

Correct behavior:

```text
Install path:
  <DESTDIR><prefix>/bin/leoorxenv.sh

Runtime content:
  LEOOREXX_HOME="<prefix>"
```

## Current Activation Chain

The current verified chain is:

```text
1. Build LeooRexx
2. make install prefix=<prefix>
3. install hook generates <prefix>/bin/leoorxenv.sh
4. user or integration layer sources leoorxenv.sh
5. LeooRexx CLI tools resolve from <prefix>/bin
6. message catalog resolves through NLSPATH
```

## Current CLI Activation

Example:

```sh
. /Users/admin/opt/leoo-oorexx-3.2.0-phase2_8-leoorxenv-install-hook-v2/bin/leoorxenv.sh
```

After activation:

```sh
which rexx
which rxqueue
which rxsubcom
which rxdelipc
```

should resolve to:

```text
<prefix>/bin/rexx
<prefix>/bin/rxqueue
<prefix>/bin/rxsubcom
<prefix>/bin/rxdelipc
```

## Design Interpretation

The activation model is:

```text
local
explicit
prefix-bound
shell-readable
Leopard-compatible
packaging-aware
```

It avoids:

```text
- global DYLD_LIBRARY_PATH
- global shell-profile dependency
- hidden system mutation
- /usr/bin fallback assumptions
```

## Remaining Follow-Ups

### Fresh RXHOME Anchor Bug

Known separate issue.

The default HOME-based runtime baseline is verified, but fresh custom RXHOME anchor behavior previously exposed a crash/initialization issue.

This must remain a separate investigation.

### libtool --finish Warnings

DESTDIR install logs still show libtool finish warnings.

These did not affect leoorxenv.sh behavior, but should be reviewed before real binary/package distribution.

### Native Leopard Entry Points

Future integration layers must inject the activation contract explicitly:

```text
- .app launcher
- Services provider
- Automator action
- LaunchAgent
- Finder workflow helper
```

They must not rely on a user Terminal profile.

## Status

```text
Environment contract: stable
Template: present
Generator: present
Direct install hook: verified
DESTDIR staged install: verified
Basic CLI DYLD_LIBRARY_PATH: not required
```

## Conclusion

The LeooRexx activation and installation baseline is stable.

LeooRexx can now be installed, activated, and staged for packaging using a small explicit environment contract.  

