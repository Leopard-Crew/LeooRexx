# Phase 2.7 Activation Generator Result

## Purpose

This document records the Phase 2.7 activation generator test for LeooRexx on Mac OS X 10.5.8 PowerPC.

Phase 2.7 introduced:

```text
tools/templates/leoorxenv.sh.in
tools/generate_leoorxenv.sh
````

The goal is to generate a prefix-specific `leoorxenv.sh` without modifying the build system yet.

## Test Prefix

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
```

## Generator Command

```sh
./tools/generate_leoorxenv.sh /Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
```

Result:

```text
Generated: /Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

## Generated File

Generated file:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

Content:

```sh
# LeooRexx environment for Mac OS X 10.5.8 PowerPC
#
# This file is generated from tools/templates/leoorxenv.sh.in.
# It activates an installed LeooRexx prefix for command-line use.

LEOOREXX_HOME="/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke"
export LEOOREXX_HOME

PATH="$LEOOREXX_HOME/bin:$PATH"
export PATH

NLSPATH="$LEOOREXX_HOME/bin/%N:$LEOOREXX_HOME/bin/%N.cat:$LEOOREXX_HOME/bin/rexx.cat"
export NLSPATH
```

## Environment Reset Before Test

The shell was reset with:

```sh
unset LEOOREXX_HOME
unset NLSPATH
unset DYLD_LIBRARY_PATH

PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH
```

## Activation

The generated file was sourced:

```sh
. /Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/leoorxenv.sh
```

Observed:

```text
LEOOREXX_HOME=/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke
DYLD_LIBRARY_PATH=unset
```

Tool discovery:

```text
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rexx
/Users/admin/opt/leoo-oorexx-3.2.0-phase2_5-install-prefix-smoke/bin/rxqueue
```

## Runtime Smoke

### rxqueue

```text
rxqueue --help

REX131: The syntax of the command is incorrect
generated env rxqueue rc=0
```

Interpretation:

```text
rxqueue finds the installed message catalog through the generated NLSPATH.
```

### rxsubcom

```text
rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
generated env rxsubcom missing rc=30
```

Interpretation:

```text
rxsubcom runs through the generated environment and returns the expected non-zero result for a missing registration.
```

## Result

The activation generator works.

It successfully generates a prefix-specific `leoorxenv.sh` from:

```text
tools/templates/leoorxenv.sh.in
```

and activates the installed LeooRexx CLI runtime without requiring:

```text
DYLD_LIBRARY_PATH
```

## Conclusion

Phase 2.7 activation generator test passed.

The activation model now has:

```text
- documented environment contract
- documented CLI usage
- template file
- standalone generator script
- verified generated activation file
```

Build-system integration remains a later, separate task.  

