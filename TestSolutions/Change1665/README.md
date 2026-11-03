# Change 1665: DIM ... AT location SHARED

`Override` (build 1660) is renamed `Shared`. `Shared`, written after `At location` in a `Dim`, marks an intended
overlap of a fixed location: RAM purposely allocated to parts of a program that are never in use at the same time. The
compiler gives no `Memory location specified for ... may be invalid` warning for that one variable. Nothing else
changes: same position (the last word after `At location`, before `= value`), same rule that every overlapping `Dim`
says `Shared` itself (the first one too), same error when there is no `At`.

**`Override` is removed**, with no alias and no warning. The word is no longer a keyword: it becomes part of the
location expression, so the variable is placed automatically and the overlap warning is not given. Change every
`At <location> Override` to `At <location> Shared`. The error is now `SharedWithoutAt`:
`SHARED can only follow AT <location> in a DIM: it marks an intended overlap of a fixed location`.

The tests of build 1660 are these same programs under their old names, in `..\Change1660\` (`Override_*.gcb`); they need
build 1660 to 1664.

## Test programs

Compile each with build 1665.

| Program | Expected |
|---|---|
| `Shared_Demo_18F46J50.gcb` | The demo: a 512-byte transfer buffer and a 64-entry name list purposely allocated to the same RAM, every location relative to one constant. No warnings; TRANSFERBUFFER / NAMELIST at 0x400, NAMEKIND at 0x701 |
| `Shared_Basic_16F877A.gcb` | Mid-range PIC (banked RAM): two buffers at 0xA0, no warnings |
| `Shared_Basic_mega328p.gcb` | AVR: two buffers at 0x200, no warnings |
| `Shared_NoShared_Warning_18F46J50.gcb` | Without `Shared` the overlap still gives the one warning (for BUFFERB) |
| `Shared_InitialValue_18F46J50.gcb` | `Shared` before `= value`: no warnings, COUNTER at 0x400 |
| `Shared_VariableNamedShared_18F46J50.gcb` | A variable called `Shared` is unaffected |
| `Shared_WithoutAt_Error_18F46J50.gcb` (`#SKIPTEST`) | `Shared` without `At`: the one expected `SharedWithoutAt` error |

All compile and assemble (GCASM) except the one marked `#SKIPTEST`; `Shared_NoShared_Warning_18F46J50.gcb` compiles with its one
expected warning. The 258 programs of `..\Change1654\` (Repeat For) were compiled and assembled again with build 1665: no failures.

## GCcode_Support

`install_GCcode_Support.cmd [GC Studio folder] [-WhatIf]` (double-click; the folder defaults to `C:\GCstudio`) puts `Shared`
into GCcode's highlighting (`GCB.tmLanguage.json`), its autocomplete (`IntelliSenseGCB.json`, and the older
`IntelliSense\GCBasic.json`) and SynWrite's list with the F1 Help link (`gcbasic.acp`). An installation that has the
build 1660 word is **upgraded**: `Override` becomes `Shared` in those four files. Each file changed is backed up first
(`.bak_<date>`); running it again changes nothing. The four files in this folder are the edited copies, for reference.
Tested on copies of the files from before the rename: the result is byte-identical to these, and a second run changes nothing.
