# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is the **GCBASIC Demonstration Sources** repo: a large, community-contributed collection of standalone `.gcb` example programs for **Great Cow BASIC (GCBASIC)**, a BASIC compiler targeting PIC and AVR/LGT8F microcontrollers. There is no application build here — each top-level folder is an independent demonstration (organized by peripheral/feature, e.g. `ADC_Read_Solutions`, `I2C_Solutions`, `LED_Solutions`, `Servo_Solutions`), typically containing one or more `.gcb` source files plus a `README.md` describing the demo and target hardware.

## Compiling a demonstration

The GCBASIC compiler is installed separately at `C:\gcstudio\gcbasic` (referenced as `%GCBASIC_INSTALL_PATH%\gcbasic` in the IDE's task definitions) and is **not part of this repository**. Settings (programmer, paths, etc.) live in `use.ini` in that same folder, and compiles must run with that folder as the working directory so `use.ini` resolves.

Run the compiler directly, e.g. from `C:\gcstudio\gcbasic`:

```
GCBASIC.exe "<full path to file>.gcb" /NP /S:use.ini /F:N /P: /DO
```

Common variants (mirrors the IDE's task/keybindings, see `This is useful list of tools for the IDE.txt`):

| Task | Flags | Purpose |
|---|---|---|
| Compile, create HEX and Program (`F5`) | `/NP /S:use.ini /F:N /DO` | Build hex and flash the target |
| Compile to create HEX only (`F6`) | `/NP /S:use.ini /F:N /P: /DO` | Build hex, no programming |
| Compile HEX (PIC-AS toolchain) | `/NP /S:use.ini /F:N /P: /DO /A:PIC-AS` | Build hex using the PIC-AS assembler |
| Compile ASM only (`F7`) | `/NP /S:use.ini /H:N /P: /DO` | Emit assembly only |
| Assemble ASM | `/AO /NP /S:use.ini /F:N /P: /DO` | Assemble a previously generated `.asm` |
| Check compiler version | `/version` | Print compiler version |

There is no lint step; "correctness" is verified by compiling a `.gcb` file cleanly (no `Error:` output — `Warning:` lines are not failures) for its target microcontroller. When asked to validate a demo, compile it rather than just reading it.

### Testing (compiling) demos

`C:\gcstudio\gcbasic\testcompilealldemos.bat` is the test routine: it recursively compiles every `.gcb` file under a target directory (default `demos\`; pass this repo's path as `%1` to test it instead) and reports results. **All demos should compile with no real errors.** Because compiling the whole tree takes hours, prefer one of these depending on scope:

- **Whole repo / large sweep**: run the batch file with this repo as the argument, from `C:\gcstudio\gcbasic`, and let it run in the background. It writes these logs back into `C:\gcstudio\gcbasic` (not this repo):
  - `test.log` — files that failed to compile (real errors, or missing expected `.asm`/`.hex` output)
  - `success.log` — files that compiled cleanly
  - `skipped.log` — files/folders skipped (see markers below)
  - `invalidsources.log` — files that don't look like valid GCBASIC sources (no `#chip`, or missing an expected `#include`)
  - Per-file, it compiles with `GCBASIC "<file>" /NP /O:compiled.asm /A:GCASM /K:A /S:USE.INI /P: > errors.txt 2>&1`, then inspects `errors.txt` for `Error:`/`(line):`-style lines (ignoring `Warning:` lines).
- **Single demo / quick check**: just compile that one file directly with `GCBASIC.exe` (see the compile commands above) from `C:\gcstudio\gcbasic`, then check `errors.txt` in `C:\gcstudio\gcbasic` (the compiler's own folder, not the demo's folder) plus the terminal output — `GCBASIC.exe` is itself a command-line tool, so its stdout/stderr already shows compile errors and warnings directly.

A folder can be excluded from testing by placing a `skiptest` or `skiptest.txt` marker file in it (applies to that folder and everything under it); an individual file can be excluded by putting `#SKIPTEST` in the source itself.

## Demonstration program structure

Every `.gcb` demo should follow the standard template (full text in the root `README.md`, also present as `Sample_Header.gcb`):

```
/*
A program for GCBASIC.
--------------------------------------------------------------------------------------------------------------------------------
This program [todo] a description of the demonstration

@author     [todo]
@licence    GPL
@version    [todo]
@date       [todo]
********************************************************************************/

// ----- Configuration
#chip <part>
// #config [todo]
// #include [todo]

#option explicit

// ----- Constants
// ----- Define Hardware settings
// ----- Variables
// ----- Quick Command Reference:
// ----- Main body of program commences here.

end
// ----- Support methods.  Subroutines and Functions
```

Key conventions (from the root `README.md`, which is the authoritative style guide for this repo):

- `#chip <part>` selects the target microcontroller and must be the first thing changed when porting a demo to different hardware; commented-
out alternative `#chip` lines are often left in place to show other supported targets.
- Any **Peripheral Programming Support (PPS)** setup method must be placed at the top of the program and must record the version of the PPS Tool used to generate it, so it's easy to locate/modify/remove when porting to another microcontroller.
- Always use `#option explicit` and give variables type-indicating names (e.g. `myADCValueByte`, `myOutputString`).
- Document every constant/variable and every method (parameters, return value, exceptions).
- End programs with a `Do Forever ... Loop` rather than `end`, when serial communication is involved — calling `end` before a serial transmission completes can corrupt it.
- All serial communication in demos runs at **9600 bps**, assuming a plain terminal with no ANSI support.
- Language/wording rules for READMEs and comments: always write "GCBASIC" (never a variant spelling); say "microcontroller", never "chip", "part", or "PIC"; do not use contractions or slang, since many users are non-native English speakers.

## Repository layout notes

- Top-level folders are largely flat, topic-based collections of independent demos (not a shared library/package tree) — most of a demo's relevant files live inside its own folder rather than being shared across folders.
- `Vendor_Boards/` holds board-specific demonstrations tied to particular commercial dev boards.
- `_Welcome_to_GCBASIC/` and `_Welcome_to_Great_Cow_BASIC/` are curated onboarding/getting-started folders.
- `Training_Support/` holds training materials rather than peripheral demos.
- `first-start-sample.gcb` and `Sample_Header.gcb` at the repo root are the canonical starter/template programs referenced by the IDE (F4 → "view Demos").
