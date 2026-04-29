Source:
vendor/oorexx-3.2.0/ooRexx-3.2.0.tar.gz

Purpose:
Curated Darwin/Leopard source cut for LeooRexx.

Rules:
- no vendor edits
- no portability priority
- Darwin/Leopard identity must be explicit
- foreign platform code is excluded from the active build
- POSIX only where Darwin uses POSIX natively
- no Java/BSF/UNO/OODialog/OLE/ActiveX

# LeooRexx Leopard Source Cut

This directory contains the working source cut derived from the unmodified ooRexx 3.2.0 source archive.

Source archive:

vendor/oorexx-3.2.0/ooRexx-3.2.0.tar.gz


Core candidate:
- kernel/

Darwin/POSIX surgery candidate:
- kernel/platform/unix
- platform/unix
- rexxapi/unix

Immediate exclude from active LeooRexx build:
- kernel/platform/windows
- platform/windows
- rexutils/windows
- rexxapi/windows
- samples/windows
- makeorx.bat
- orxdb.bat
- windows-build.txt

Quarantine:
- rexutils/
- rxregexp/
- samples/

Audit:
- lib/
- build system files
