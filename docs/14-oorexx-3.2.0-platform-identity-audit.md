The ooRexx 3.2.0 build correctly targets powerpc-apple-darwin9.8.0,
but internally maps the generic Unix build path to LINUX / OPSYS_LINUX.

This is accepted only as historical baseline behavior.

For LeooRexx, platform identity must be deterministic:
POSIX is POSIX, Linux is Linux, Darwin is Darwin, Leopard is Leopard.
