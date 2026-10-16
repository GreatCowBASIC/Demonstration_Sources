# Change1657 — test programs and GCcode support files

Covers 5 pending (uncommitted as of this writing) changes to `gcbasic.bas`/`preprocessor.bi`/
`variables.bi`/`assembly.bi`/`include\lowlevel\system.h`/`messages.dat` on the GCBASIC compiler
trunk, build 1657.

## Test programs

| File(s) | Change | Rule/behaviour demonstrated |
|---|---|---|
| `BootloaderHost_Basic_18F4550.gcb` | New `#option bootloaderhost <addr>` | The acceptance case: vector table forwards both interrupt vectors, byte-identical to Microchip bootloader v1.4 |
| `BootloaderHost_Reject_InterruptHandler_18F4550.gcb` (`#SKIPTEST`) | same | Rule 1: host cannot have its own interrupt handler |
| `BootloaderHost_Reject_BootloaderConflict_18F4550.gcb` (`#SKIPTEST`) | same | Rule 3: `#option bootloader` and `#option bootloaderhost` are mutually exclusive |
| `BootloaderHost_Reject_InvalidAddress_18F4550.gcb` (`#SKIPTEST`) | same | Rule 4: address must be even and above `0x001C` |
| `BootloaderHost_Reject_Overflow_18F4550.gcb` (`#SKIPTEST`) | same | Rule 2: host's own code must end below the application address |
| `StringLimitCheck_Clamp_16F877A.gcb`, `_18F4550.gcb`, `_tiny202.gcb` | New `#option StringLimitCheck` | Clamps an over-long literal assignment, one per chip family's own assembly idiom (14-bit PIC, PIC18, AVR) |
| `StringLimitCheck_CopyVarToVar_mega328p.gcb` | same | Clamps a variable-to-variable copy (`SysCopyString`, not `SysReadString`) |
| `StringLimitCheck_UnsupportedChip_Warning.gcb` (`#SKIPTEST`) | same | Illustrates the ignored-with-warning behaviour on a non-PIC/AVR target (no real chip to compile against in this project) |
| `Information_BadIntFreq_12F683.gcb` | New "Information" message severity | `BadIntFreq` is now Information, not Warning - 0 warnings in the summary, "Compiler information:" header instead |
| `ConfigOsc_StrictMatch_18F24J50.gcb` | Fix: `ConfigNameMatch` strict OSC matching | A chip with `OSC`, `RTCOSC` and `DSWDTOSC` settings now reports the correct `OSC:` line instead of a blank one |

All compile and assemble cleanly except the five marked `#SKIPTEST` (each is a deliberate
rule-violation, verified to produce exactly the one expected error and nothing else).

## GCcode_Support/

Copies of the editor/IDE helper files updated alongside this change, for reference - these are
already applied to the live install at `C:\GCstudio\`, not meant to be extracted from here.

| File | Change |
|---|---|
| `syntaxes/GCB.tmLanguage.json` → `GCB.tmLanguage.json` | Added `bootloaderhost` and `StringLimitCheck` to the recognised `#option` keyword list |
| `dist/IntelliSenseGCB.json` → `IntelliSenseGCB.json` | Added `option BootloaderHost` and `option StringLimitCheck` autocomplete entries |
| `IntelliSense/GCBasic.json` → `GCBasic.json` | Older separate copy of the same IntelliSense data (not read by the extension), kept in sync |
| `SynWrite/data/autocomplete/gcbasic.acp` → `gcbasic.acp` | Added F1-help lookup entries for `#OPTION BootloaderHost` / `#OPTION StringLimitCheck`, and their bare-keyword forms |
