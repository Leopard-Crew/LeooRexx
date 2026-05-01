# Warning Cleanup: RexxUtil Numeric NULL Usage

## Change

Numeric uses of `NULL` in:

```text
src/oorexx-3.2.0-leopard/rexutils/unix/rexxutil.cpp
````

were replaced with numeric `0`.

Examples:

```c
uname(&info) < NULL
```

became:

```c
uname(&info) < 0
```

and:

```c
handle < NULL
```

became:

```c
handle < 0
```

`strtoul()` calls were also corrected from:

```c
strtoul(args[0].strptr, NULL, NULL)
```

to:

```c
strtoul(args[0].strptr, NULL, 0)
```

## Rationale

`NULL` is a pointer sentinel, not a numeric value.

The old RexxUtil code used `NULL` as numeric zero in return-code, handle, use-count, and `strtoul()` base contexts. GCC warned about this as:

```text
NULL used in arithmetic
```

## Quarantine Note

RexxUtil remains quarantine material.

This cleanup removes compiler warnings only. It does not promote RexxUtil to LeooRexx core.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh warning-rexxutil-null-arithmetic-test
```

Check result:

```text
No warnings.
```

## Conclusion

The RexxUtil numeric NULL warning group is fixed.  

