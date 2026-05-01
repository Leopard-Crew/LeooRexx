# Warning Cleanup: Extern Initializers

## Change

Removed invalid `extern` from initialized global definitions in:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/RexxMain.cpp
src/oorexx-3.2.0-leopard/kernel/runtime/GlobalData.cpp
````

## Fixed Warnings

```text
RexxMain.cpp: initialize_sem initialized and declared extern
RexxMain.cpp: SecureFlag initialized and declared extern
RexxMain.cpp: thread_counter initialized and declared extern
GlobalData.cpp: validMaxWhole initialized and declared extern
```

## Rationale

A declaration with an initializer is a definition. Keeping `extern` on initialized globals is misleading and triggers GCC warnings.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh warning-extern-initializers-test
```

Check result:

```text
No extern initializer warnings.
```

## Conclusion

The extern-initializer warning group is fixed without changing the ownership of the global definitions.

