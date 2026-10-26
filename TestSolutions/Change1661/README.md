# Change 1661: #option IncludePath

`#option IncludePath "folder;folder"` - the folders searched for `#include <...>` (and `#insert <...>`) before
GCBASIC's include folder, in the order given. Relative to the program's folder, or a full path. It applies to every
`#include <...>` after it, in the program and in every file it includes. `#include "..."` is not changed.

## Test programs

Compile each with build 1661 (`lib1\` and `lib2\` are the test libraries).

| Program | Expected |
|---|---|
| `IncludePath_Angle.gcb` | compiles; `<a_lib1.h>` from `lib1` (PORTB = 0x11) |
| `IncludePath_Order.gcb` | compiles; `lib1;lib2`: the first folder wins (PORTB = 1) |
| `IncludePath_Nested.gcb` | compiles; `lib1\outer_lib1.h` includes `<inner_lib2.h>`, found in `lib2` (PORTB = 0x22) |
| `IncludePath_Library.gcb` | compiles; GCBASIC's own `<maths.h>` still from the include folder |
| `IncludePath_None.gcb` | compiles; no option: the same code as build 1660 |
| `IncludePath_BadFolder.gcb` | warning `#option IncludePath: folder not found: ...\nosuchfolder`, and it compiles |
| `IncludePath_Missing.gcb` (`#SKIPTEST`) | error `Cannot find ...\not_there.h (searched: ...\lib1; ...\lib2; ...\include)` |
| `IncludePath_Absolute.gcb` | compiles; a full path, unquoted, with a comment after it |
| `IncludePath_Backslash.gcb` | compiles; `lib1\..\lib1`: backslashes are path separators, not string escapes |
| `IncludePath_CR.gcb` | compiles; the option line ends CR CR LF. Passes on Windows with or without the fix: the check for a Linux build |

Build 1660 stops on every one that uses the option: `Unrecognised compiler option: INCLUDEPATH`.

## GCcode_Support

`install_GCcode_Support.cmd [GC Studio folder] [-WhatIf]` (double-click; the folder defaults to
`GCBASIC_INSTALL_PATH`, else `C:\GCstudio`) adds `IncludePath` to GCcode's highlighting (`GCB.tmLanguage.json`),
its autocomplete (`IntelliSenseGCB.json`, and the older `IntelliSense\GCBasic.json`) and SynWrite's list with the F1
Help link (`gcbasic.acp`). It edits the installation's own files (each backed up first); running it again changes
nothing. The four files in this folder are the edited copies, for reference. Tested on a copy of GC Studio's files from
before the change: the result is byte-identical to these.
