# Phase 4.1 ooRexx 4/5 Language Delta Map

## Purpose

This document maps relevant ooRexx 4.x and 5.x language/runtime changes for LeooRexx.

The goal is not to port ooRexx 5 wholesale.

The goal is to decide which modern ooRexx language concepts should be understood, emulated, backported, or intentionally ignored by LeooRexx.

## Guiding Principle

```text
LeooRexx remains ooRexx-compatible in the core.
LeooRexx becomes Leopard-native in its capability layer.
````

Compatibility rule:

```text
A valid ooRexx 3.2 program should remain a valid LeooRexx program.
A LeooRexx program may use Leopard-native capabilities explicitly.
LeooRexx must not silently change core ooRexx semantics.
```

## Quality Goal

LeooRexx should aim for Apple NS-style component quality:

```text
clear contracts
stable names
small coherent classes
documented behavior
predictable failure modes
explicit capability boundaries
```

This does not mean copying Cocoa.

It means adopting the same discipline:

```text
Do one thing well.
Name it clearly.
Expose it consistently.
Document the contract.
Avoid hidden magic.
```

## Strategic Baseline

```text
ooRexx 3.2.0 = current LeooRexx runtime foundation
ooRexx 4.x   = native API / bridge architecture reference
ooRexx 5.x   = feature and language concept quarry
LeooRexx     = curated Leopard-native Rexx product
```

## Language Level Proposal

### LeooRexx Language Level 1

```text
ooRexx 3.2-compatible core
stable Leopard/PPC runtime
rxqueue / rxsubcom / rxdelipc
installed activation contract
```

Status:

```text
current foundation
```

### LeooRexx Language Level 2

```text
selected ooRexx 4.x-compatible directives and native binding concepts
```

Primary focus:

```text
::CONSTANT
::OPTIONS
EXTERNAL on directives
::REQUIRES LIBRARY
native routine/method bridge concepts
```

Status:

```text
future selective backport / compatibility target
```

### LeooRexx Language Level 3

```text
selected ooRexx 5.x-inspired metadata, info, resource and message concepts
```

Primary focus:

```text
.LeooRexxInfo
.LeopardInfo
::ANNOTATE
::RESOURCE
reviewable Message Plans
Trace/Audit concepts
```

Status:

```text
Leopard-native extension layer
```

## Delta Table

|Feature|Source Line|Type|LeooRexx Value|Risk|Recommendation|
|---|--:|---|---|---|---|
|`::CONSTANT`|ooRexx 4.x|syntax/directive|cleaner package/class constants|medium|desirable|
|`::OPTIONS`|ooRexx 4.x|syntax/directive|explicit runtime/script options|medium|investigate|
|`EXTERNAL` on `::ROUTINE`|ooRexx 4.x|syntax/API|native Leopard bridges|high|later|
|`EXTERNAL` on `::METHOD`|ooRexx 4.x|syntax/API|native proxy classes|high|later|
|`EXTERNAL` on `::ATTRIBUTE`|ooRexx 4.x|syntax/API|native object properties|high|later|
|`::REQUIRES ... LIBRARY`|ooRexx 4.x|syntax/API|explicit native capability loading|high|important later|
|Native C++ API contexts|ooRexx 4.x|runtime/API|clean Leopard bridge architecture|very high|study first|
|`.RexxInfo`|ooRexx 5.x|runtime class|model for `.LeooRexxInfo` / `.LeopardInfo`|low/medium|strong candidate|
|`::ANNOTATE`|ooRexx 5.x|syntax/metadata|script metadata, Services metadata, audit info|medium|strong candidate|
|`::RESOURCE`|ooRexx 5.x|syntax/resource|embedded templates, AppleScript snippets, plist fragments|medium|strong candidate|
|multiline strings/resources|ooRexx 5.x|syntax/resource|useful for Apple Events, plists, templates|medium|through `::RESOURCE` first|
|namespaces|ooRexx 5.x|language model|clean separation like `rexx:` / `leopard:`|high|defer|
|JSON class/library|ooRexx 5.x|library|useful for APIs and AI plans|low/medium|optional library|
|YAML support|ooRexx 5.x|library|useful for readable plans/configs|medium|optional later|
|TraceObject|ooRexx 5.1+|runtime/diagnostics|auditability and AI-reviewed execution|high|concept quarry|
|`.Message` / message concepts|ooRexx 5.x line|runtime/object model|core LeooRexx conductor idea|high|architecture driver, not immediate port|

## Compatibility Classes

### C0: Must Preserve

```text
existing ooRexx 3.2 syntax
existing object model
existing message send syntax
existing RexxAPI behavior
classic ADDRESS behavior
existing queue/subcommand behavior
```

### C1: Safe Additions

```text
new classes under explicit LeooRexx names
.LeooRexxInfo
.LeopardInfo
.Leopard
explicit ADDRESS environments
```

Rule:

```text
Must not alter existing ooRexx behavior.
```

### C2: Parser-Level Additions

```text
::CONSTANT
::OPTIONS
::ANNOTATE
::RESOURCE
multiline resources
```

Rule:

```text
Only after parser/source model analysis.
Must be guarded by LeooRexx language level.
```

### C3: Native Bridge Additions

```text
::REQUIRES ... LIBRARY
EXTERNAL native methods
native proxy classes
Cocoa/Apple Events bridges
```

Rule:

```text
High-value but high-risk.
Requires dedicated native bridge phase.
```

### C4: Deferred / Quarry Only

```text
namespaces
TraceObject clone
full ooRexx 5 runtime model
complete ooRexx 5 compatibility
```

Rule:

```text
Study, do not promise.
```

## Leopard-Native Interpretation

### `.RexxInfo` Inspiration

ooRexx 5 has `.RexxInfo`.

LeooRexx should eventually define:

```rexx
say .LeooRexxInfo~version
say .LeooRexxInfo~languageLevel
say .LeooRexxInfo~runtimePrefix
say .LeopardInfo~systemVersion
say .LeopardInfo~powerPC
say .LeopardInfo~quickLookAvailable
say .LeopardInfo~appleEventsAvailable
```

This is not merely convenience.

It supports:

```text
diagnostics
scripts that adapt to capability availability
Services integration
AI-generated review plans
support reports
```

### `::ANNOTATE` Inspiration

LeooRexx could use annotations for:

```rexx
::annotate package purpose "Finder service script"
::annotate package accepts "public.utf8-plain-text"
::annotate package leoorx.serviceName "Format Text with LeooRexx"
```

Use cases:

```text
Services metadata
Automator action metadata
Finder action metadata
script cataloging
audit reports
```

### `::RESOURCE` Inspiration

LeooRexx could use resources for embedded payloads:

```rexx
::resource plist
...
::end
```

Use cases:

```text
Info.plist fragments
AppleScript templates
shell snippets
HTML report templates
AI plan templates
```

### Message Plan Concept

LeooRexx should treat Messages as executable contracts:

```text
AI is advisory.
Messages are executable.
LeooRexx reviews and executes.
```

Possible conceptual shape:

```rexx
plan = .LeoMessagePlan~new
plan~add(.message~new(.Leopard~Spotlight, "search", "I", "kind:pdf"))
plan~add(.message~new(.Leopard~Finder, "revealSelection"))
plan~review
plan~execute
```

This should be a product architecture direction, not an immediate runtime patch.

## NS-Style Quality Rules for LeooRexx Components

Future LeooRexx-native components should follow these rules:

### Naming

```text
LeooRexx-owned classes use clear names:
.LeooRexxInfo
.LeopardInfo
.Leopard
.LeoMessagePlan
.LeoCapability
```

Avoid ambiguous global pollution.

### Contracts

Each component must document:

```text
what it does
what it does not do
inputs
outputs
failure modes
Leopard dependencies
threading/asynchronicity assumptions
```

### Capability Boundaries

A component must not silently reach everywhere.

Example:

```text
FinderProxy handles Finder.
QuickLookProxy handles Quick Look.
SpotlightProxy handles Spotlight.
ServicesProxy handles Services.
```

### Explicit Opt-In

Leopard-native power must be explicit:

```rexx
::requires "leopard.capabilities"
```

or:

```rexx
finder = .Leopard~capability("Finder")
```

### No Hidden Shell Magic

Avoid:

```rexx
ADDRESS SYSTEM "opaque generated command"
```

Prefer:

```rexx
.Leopard~Finder~reveal(file)
```

or an auditable Message Plan.

## First Implementation Candidates

### Candidate 1: `.LeooRexxInfo`

Risk:

```text
low
```

Reason:

```text
Can be introduced as a new LeooRexx-specific class without disturbing ooRexx core syntax.
```

Possible methods:

```text
version
languageLevel
runtimePrefix
buildDate
platform
architecture
```

### Candidate 2: `.LeopardInfo`

Risk:

```text
low/medium
```

Reason:

```text
System information only.
Can use documented Leopard/Darwin APIs or shell-safe fallbacks.
```

Possible methods:

```text
systemVersion
darwinVersion
powerPC
altivecAvailable
quickLookAvailable
spotlightAvailable
servicesAvailable
```

### Candidate 3: Explicit `ADDRESS LEOPARD`

Risk:

```text
medium
```

Reason:

```text
Fits Rexx tradition.
Could become compatibility bridge before full object/message proxy layer.
```

### Candidate 4: Message Plan Prototype

Risk:

```text
medium/high
```

Reason:

```text
Architecturally central but should begin as pure Rexx-level planning object before native execution.
```

## Non-Goals

This phase does not commit to:

```text
full ooRexx 4 compatibility
full ooRexx 5 compatibility
immediate parser changes
immediate namespace support
immediate native C++ API backport
```

## Recommended Next Steps

```text
Phase 4.2: LeooRexx Product Shape Manifest
Phase 4.3: .LeooRexxInfo / .LeopardInfo concept
Phase 4.4: First Leopard Capability Proxy concept
Phase 4.5: Reviewable Message Plan concept
```

## Conclusion

LeooRexx should remain compatible with ooRexx at its core.

It should not chase ooRexx 5 wholesale.

Instead, it should define a curated LeooRexx language level:

```text
ooRexx-compatible core
selected ooRexx 4/5 language concepts
explicit Leopard-native capabilities
NS-quality component discipline
```

The long-term goal is:

```text
LeooRexx feels like a natural Leopard system component,
not merely a ported interpreter.
```

