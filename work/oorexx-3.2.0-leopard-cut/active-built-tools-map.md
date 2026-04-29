# Active Built Tools Map

This document classifies the executables currently built by the ooRexx 3.2.0 Leopard/PPC build.

## Built programs

The current build creates the following command-line programs:

```text
rexx
rexxc
rxmigrate
rxqueue
rxsubcom
rxdelipc
````

## Classification

### rexx

Status: core candidate.

Reason: main interpreter executable.

LeooRexx decision: keep as baseline runtime, later wrap through LeooRexx.app.

### rexxc

Status: quarantine.

Reason: compiler/tokenizer utility. Potentially useful for image/build workflow, but not required for LeooRexx V1 user-facing runtime.

Decision: review before shipping.

### rxmigrate

Status: quarantine / likely exclude from V1.

Reason: historical migration tool for old tokenized Object Rexx files.

Decision: not LeooRexx core.

### rxqueue

Status: quarantine.

Reason: queue/API tool. May relate to Rexx external queue services.

Decision: review whether needed for ADDRESS/capability model.

### rxsubcom

Status: quarantine.

Reason: subcommand/API tool. Potentially related to command environments.

Decision: review carefully before excluding, because LeooRexx is ADDRESS-oriented.

### rxdelipc

Status: quarantine.

Reason: IPC cleanup utility.

Decision: review whether required by runtime or only by legacy Unix ooRexx service model.
