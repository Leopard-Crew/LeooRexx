# OS/2 Guard Proxy Replacement Result

## Change

The first semantic platform cleanup was applied to:

```text
src/oorexx-3.2.0-leopard/kernel/platform/unix/MiscSystem.cpp
````

Four occurrences of:

```c
#if !defined(AIX) && !defined(LINUX)
```

were replaced with:

```c
#if LEOOREXX_LEGACY_OS2
```

## Rationale

The old guard did not mean "not AIX and not Linux" in a meaningful Leopard context.

The guarded code is OS/2 / Presentation Manager / Dos* legacy code. Using `LINUX` as a proxy for "not OS/2" created platform identity debt.

The new guard makes the real meaning explicit.

## Validation

The source cut was rebuilt on:

```text
Mac OS X 10.5.8 Leopard
PowerPC / iMac G5
powerpc-apple-darwin9.8.0
```

The self-built interpreter passed the smoke test:

```text
REXX_BIN=./rexx ../../../tools/smoke_test_oorexx.sh
```

Result:

```text
Smoke test completed.
```

## Conclusion

This confirms that OS/2 guard proxy usage can be replaced with explicit LeooRexx legacy markers without breaking the Leopard/PPC build.

This is the first successful semantic platform cleanup in the LeooRexx source cut.  
EOF

git add work/oorexx-3.2.0-leopard-cut/os2-guard-proxy-result.md  
git commit -m "Document OS/2 guard proxy replacement"  
git push

