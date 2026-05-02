# Phase 2 Runtime / IPC Tool Baseline

## Purpose

This document records the first non-destructive Runtime / IPC tool baseline after Phase 1 platform identity cleanup and the warning-clean baseline.

## Build Used

```text
build-work/warning-clean-baseline
````

## Runtime Catalog Setup

The command-line tools require the message catalog `rexx.cat`.

For build-directory testing, the following environment was used:

```sh
export NLSPATH="$PWD/%N:$PWD/%N.cat:$PWD/rexx.cat"
```

Without this, tools such as `rxqueue` and `rxsubcom` may fail with:

```text
Cannot open REXX message catalog rexx.cat.
```

## Tool Checks

### rexx

```sh
./rexx -v
```

Result:

```text
Open Object Rexx Interpreter Version 3.2.0 for MACOSX
```

Status:

```text
PASS
```

### rxqueue

```sh
printf 'hello from rxqueue\n' | ./rxqueue /FIFO
echo $?
```

Result:

```text
0
```

```sh
./rxqueue /CLEAR
echo $?
```

Result:

```text
0
```

Status:

```text
PASS
```

### rxsubcom

```sh
./rxsubcom QUERY __LEOO_REXX_TEST_ENV__ __missing_proc__
echo $?
```

Result:

```text
30
```

Interpretation:

```text
Expected negative query result. The tool starts, finds the message catalog, reaches the RexxAPI path, and returns a controlled non-zero result for a missing subcommand entry.
```

Status:

```text
PASS
```

### rxdelipc

```sh
./rxdelipc -h
echo $?
```

Result:

```text
0
```

Status:

```text
PASS
```

## Safety Notes

Do not run `rxqueue` without explicit input or mode during automated tests.

Observed behavior:

```text
./rxqueue
```

may block because the default mode is `/FIFO` and stdin is read.

Do not run destructive IPC cleanup commands as part of the baseline:

```text
./rxdelipc
./rxdelipc -f
```

`rxdelipc` without arguments prompts for shared-memory deletion.  
`rxdelipc -f` can force deletion if no other ooRexx procedure holds the shared memory.

## Result

The first non-destructive Runtime / IPC tool baseline passes.

## Remaining Phase 2 Work

```text
- Controlled RexxAPI queue behavior tests
- Controlled subcommand registration/query/drop tests
- Runtime/IPC stress tests
- RexxAPI semaphore limits investigation: MAXSEM=48, MAXUTILSEM=32
- Active built-tools classification
```

## Conclusion

The warning-clean LeooRexx build produces executable Runtime / IPC tools that operate correctly in non-destructive baseline checks when NLSPATH points to the build directory catalog.  

