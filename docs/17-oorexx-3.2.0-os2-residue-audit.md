Finding:
ooRexx 3.2.0 contains visible OS/2/IBM/Presentation Manager residues.

Impact:
Most OS/2-specific code is inactive in the current Leopard/PPC build because the build defines LINUX/OPSYS_LINUX.

Risk:
The LINUX define is currently used both as a Unix/POSIX selector and as a guard against OS/2 code paths. This is semantically wrong for LeooRexx.

Rule:
Do not remove LINUX/OPSYS_LINUX blindly. First classify every use by meaning:
- Linux-specific
- POSIX/Unix-generic
- Darwin-compatible
- OS/2 guard
- dead/comment/documentation residue
- optional utility layer

LeooRexx Target:
Darwin/Leopard must become explicit platform identity.
POSIX must be explicit where used.
Linux must only mean Linux.
OS/2 residue must be isolated or removed from the curated runtime.

