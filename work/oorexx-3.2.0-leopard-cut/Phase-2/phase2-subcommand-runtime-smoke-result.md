# Phase 2 Subcommand Runtime Smoke Result

## Purpose

This document records a controlled RexxAPI subcommand registry smoke test after Phase 1 platform identity cleanup and warning-clean baseline.

## Build Used

```text
build-work/warning-clean-baseline
````

## Environment

The build-directory runtime tools require the message catalog:

```sh
export NLSPATH="$PWD/%N:$PWD/%N.cat:$PWD/rexx.cat"
```

## Test Scope

This test validates the subcommand registry path only:

```text
REGISTER
QUERY
DROP
QUERY
```

It intentionally does not test:

```text
LOAD
actual dynamic library loading
actual subcommand execution
```

## Commands

```sh
./rxsubcom DROP LEOO_TEST_SUBCOM fake_subcom.dylib 2>/dev/null
echo "pre-clean DROP rc=$?"

./rxsubcom QUERY LEOO_TEST_SUBCOM fake_subcom.dylib
echo "QUERY before REGISTER rc=$?"

./rxsubcom REGISTER LEOO_TEST_SUBCOM fake_subcom.dylib FakeEntryPoint
echo "REGISTER rc=$?"

./rxsubcom QUERY LEOO_TEST_SUBCOM fake_subcom.dylib
echo "QUERY after REGISTER rc=$?"

./rxsubcom DROP LEOO_TEST_SUBCOM fake_subcom.dylib
echo "DROP after REGISTER rc=$?"

./rxsubcom QUERY LEOO_TEST_SUBCOM fake_subcom.dylib
echo "QUERY after DROP rc=$?"
```

## Result

```text
pre-clean DROP rc=30
QUERY before REGISTER rc=30
REGISTER rc=0
QUERY after REGISTER rc=0
DROP after REGISTER rc=0
QUERY after DROP rc=30
```

## Interpretation

```text
rc=0   means the requested registry operation succeeded.
rc=30  is the expected controlled negative result for a missing registration.
```

The registry lifecycle works:

```text
missing -> register -> visible -> drop -> missing
```

## Safety Note

`REGISTER` does not load the referenced library immediately.

The fake library name was intentionally used to verify registry behavior only.

`LOAD` was not executed because it would test dynamic loading behavior and belongs to a later, explicit subcommand module test.

## Conclusion

The LeooRexx warning-clean build has a working RexxAPI subcommand registry path for controlled REGISTER / QUERY / DROP operations.  

