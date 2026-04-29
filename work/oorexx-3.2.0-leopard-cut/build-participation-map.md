# Build Participation Map

This document records which foreign platform areas participate in the current ooRexx 3.2.0 Leopard/PPC build.

## Test

The Leopard/PPC build log was scanned for known foreign platform markers:

```sh
grep -E "(/windows/|kernel/platform/windows|platform/windows|rexutils/windows|rexxapi/windows|oodialog|orxscrpt|BSF|Java|UNO)" build-leopard-ppc.log \
  > build-foreign-participation.txt

wc -l build-foreign-participation.txt
````

## Result

```text
0 build-foreign-participation.txt
```

The output file was empty.

## Interpretation

The current Leopard/PPC build does not show evidence that the following foreign platform / non-Leopard components participate in the build:

```text
kernel/platform/windows/
platform/windows/
rexutils/windows/
rexxapi/windows/
platform/windows/oodialog/
platform/windows/orxscrpt/
BSF / Java / UNO bridge material
```

## LeooRexx Consequence

Foreign platform material exists in the imported source tree and in the historical installation footprint, but there is no evidence from the current build log that it enters the active Leopard/PPC build.

Status:

```text
Source tree contamination: yes
Active build contamination: no evidence
```

This supports a staged approach:

1. keep the current source tree intact for audit
    
2. exclude foreign platform paths from LeooRexx cut policy
    
3. avoid deleting them before the Darwin/Leopard core is fully mapped
    
4. focus next on Linux/POSIX/Darwin identity cleanup, because that code does participate in the active build
    
