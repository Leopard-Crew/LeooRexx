## System

- Machine: iMac G5
- Operating system: Mac OS X 10.5.8 Leopard PowerPC
- Package: ooRexx 3.2.0 PPC MacOSX DMG
- Installed executable: `/usr/bin/rexx`
- Real executable target: `/opt/ooRexx/bin/rexx`

## Runtime Command

```sh
which rexx
/usr/bin/rexx

ls -l /usr/bin/rexx
lrwxr-xr-x  1 root  wheel  20 Apr 28 21:14 /usr/bin/rexx -> /opt/ooRexx/bin/rexx
````

## Package Receipt

```text
/Library/Receipts/ooRexx-3.2.0-01-ppc.MacOSX.pkg
```

`pkgutil --pkgs | grep -i rexx` produced no output, which indicates that this package uses the older receipt mechanism rather than a modern pkgutil-visible receipt.

## Main Installation Locations

```text
/opt/ooRexx
/usr/bin/oorexx-config
/usr/bin/rexx
/usr/bin/rexx.cat
/usr/bin/rexx.img
/usr/bin/rexxc
/usr/bin/rexxj
/usr/lib/librexx*
/usr/lib/librexxapi*
/usr/lib/librexxutil*
```

## Core ooRexx Files

```text
/opt/ooRexx/bin/oorexx-config
/opt/ooRexx/bin/rexx
/opt/ooRexx/bin/rexx.cat
/opt/ooRexx/bin/rexx.img
/opt/ooRexx/bin/rexxc
/opt/ooRexx/bin/rexxj
/opt/ooRexx/include/rexx.h
/opt/ooRexx/lib/ooRexx/librexx.dylib
/opt/ooRexx/lib/ooRexx/librexxapi.dylib
/opt/ooRexx/lib/ooRexx/librexxutil.dylib
```

## Non-LeooRexx / Cancer Candidates

The historical ooRexx installation includes Java and BSF-related components:

```text
/opt/ooRexx/lib/ScriptProviderForooRexx.jar
/opt/ooRexx/lib/bsf-rexx-engine.jar
/opt/ooRexx/lib/libBSF4Rexx.jnilib
/opt/ooRexx/lib/oorexx-uno.jar
/opt/ooRexx/share/BSF4Rexx
```

For LeooRexx these components are considered non-native ballast and must not become part of the curated Leopard-native runtime.

## Initial Assessment

The historical PPC package confirms that ooRexx 3.2.0 runs on Leopard/PowerPC.

However, the installer is system-invasive:

- installs into `/opt/ooRexx`
    
- exposes commands in `/usr/bin`
    
- exposes libraries in `/usr/lib`
    
- includes Java/BSF/UNO-related components
    
- uses an old-style receipt under `/Library/Receipts`
    

This package is useful as a reference installation and proof of life, but not as a model for the final LeooRexx distribution.

## LeooRexx Consequence

LeooRexx should eventually use a curated ooRexx runtime and avoid uncontrolled system-wide installation.

Candidate future layouts:

```text
LeooRexx.app/Contents/...
```

or, if app-bundle embedding proves impractical:

```text
/Library/Application Support/LeooRexx/
```

No LeooRexx release should install Java bridges, BSF4Rexx, UNO bridges, Windows-specific components, or other non-Leopard-native ballast.  


The installer exposes ooRexx system-wide mostly through symbolic links:

/usr/bin/rexx         -> /opt/ooRexx/bin/rexx
/usr/bin/rexxc        -> /opt/ooRexx/bin/rexxc
/usr/bin/rexxj        -> /opt/ooRexx/bin/rexxj
/usr/bin/oorexx-config -> /opt/ooRexx/bin/oorexx-config

/usr/lib/librexx*      -> /opt/ooRexx/lib/ooRexx/librexx*
/usr/lib/librexxapi*   -> /opt/ooRexx/lib/ooRexx/librexxapi*
/usr/lib/librexxutil*  -> /opt/ooRexx/lib/ooRexx/librexxutil*


The installation is centralized under /opt/ooRexx, but exposed globally through /usr/bin and /usr/lib symbolic links.

For LeooRexx this confirms that a future curated runtime should avoid global symlinks and prefer an app-bundle-local or Application Support based layout.
