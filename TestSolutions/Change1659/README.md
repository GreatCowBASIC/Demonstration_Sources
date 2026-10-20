# Change1659 - test programs

Build 1659, SVN r1980 (`gcbasic.bas`, `preprocessor.bi`). Both fixes found in the PIC18F Starter Kit 1
bootloader / GLCD work (2026-10-17).

## Test programs

| File | Change | Behaviour demonstrated |
|---|---|---|
| `ForSelfStart_18F46J50.gcb` | Fix: `For X = X To N` skipped the loop for a start of 0 (`CompileFor`) | Run in the MDB simulator to the final `Do / Loop`: CountA = 6, CountB = 6 (build 1658: CountA = 0) |
| `ForSelfStart_Variants_18F46J50.gcb` | same | Byte start 0 (6), `Step -1` (4), `Step 2` (5), start 1 (5), Word start 0 to 300 (301); build 1658: 0 for both start-0 loops |
| `CommentInclude_Block_18F46J50.gcb` | Fix: `#include` / `#ignore` acted on inside `/* */` comments (`FindIncludeFiles`) | Compiles (build 1658: "Cannot find ...\no_such_file.h") |
| `CommentIgnore_Block_18F46J50.gcb` | same | Compiles (build 1658: "Compilation ignored", no hex) |
| `CommentInclude_InlineOpen_18F46J50.gcb` | same | Code then a `/*` comment over several lines: compiles (build 1658: "Cannot find ...") |
| `CommentInclude_Controls_18F46J50.gcb` | same (controls) | `#include` mid-line or after `'`, `#define` / `#option` in a block comment: not acted on, before and after - compiles |
| `CommentInclude_RealAfter_18F46J50.gcb` + `Change1659_real.h` | same (control) | A real `#include "x.h" /* note */` after a block comment is still followed - compiles |
| `CommentInclude_AfterClose_18F46J50.gcb` (`#SKIPTEST`) | same (control) | An `#include` after the block has closed is still followed: the one expected "Cannot find" error |

All compile and assemble cleanly except the one marked `#SKIPTEST`. The two `For` tests need the
simulator (or a board) to show the counts; a compile alone does not.

**Simulator** (MPLAB X v6.35 `mdb.bat`, the program built with `/A:PIC-AS` for the `.elf`):

    Device PIC18F46J50
    Hwtool Sim
    Program "<path>/ForSelfStart_18F46J50.build/ForSelfStart_18F46J50.elf"
    Reset
    Break *<address of SYSDOLOOP_S1, from the .map>
    Run
    Wait 20000
    x /r64xb 0x0
    Quit

Read the counts from the data-memory dump at the addresses in the `.map` (MDB's `Print` showed wrong
values for these absolute symbols).
