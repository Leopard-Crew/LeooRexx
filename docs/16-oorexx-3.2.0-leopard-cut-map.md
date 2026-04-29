Was ist Kern?
Was ist optional?
Was ist Quarantäne?
Was ist Krebs?
Was ist Pseudo-Krebs?
Was muss durch Darwin/Leopard ersetzt werden?


Keep / Core:
- interpreter core
- parser/runtime basics
- classic Rexx execution
- ADDRESS mechanism
- trace/error basics
- minimal API needed for embedding

Quarantine:
- rexxutil
- rxsock
- samples
- rexxc
- rexxj
- external function packages

Remove / Exclude:
- BSF4Rexx
- Java bridge
- UNO bridge
- Windows/OLE/ActiveX/OODialog material
- non-Leopard packaging logic

Replace with Leopard/Darwin:
- platform identity macros
- dylib path/install_name handling
- app/bundle layout
- shell/process wrapping where LeooRexx layer touches it
- dialogs/clipboard/search/preview/network-facing glue
