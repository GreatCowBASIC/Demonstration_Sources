# PIC Microcontroller ClearRAM for GCBASIC 

## The problem

On a PIC, RAM is not zeroed by reset. After power-on, brown-out, or a watchdog reset, every byte of general-purpose RAM holds whatever was left over from before — effectively random. Any variable a GCBASIC program hasn't explicitly assigned yet is undefined, not zero, until the program happens to write to it. That's a common source of subtle bugs: code that assumes an uninitialized counter or flag starts at 0, works by luck on the bench, then fails intermittently in the field depending on what state the RAM happened to power up in.

GCBASIC doesn't currently offer a way to clear all of a chip's RAM at startup, and doing it by hand is harder than it looks:

**RAM isn't one contiguous block on most PICs.** Which addresses are real GPR, versus reserved, versus a hardware SFR, varies chip to chip — a naive loop from 0 to ChipRam-1 would end up writing into live hardware registers, not just data memory.
**How you even reach a given address differs by chip family** — some PICs address RAM through switchable banks, others through a flat linear space — so a single, portable clearing routine has to generate different code depending on which kind of chip it's compiling for.

This project adds that missing piece: ClearRAM, a routine that zeros every byte of real, usable RAM for whichever chip the program is compiled for, entirely automatically and per-chip-correct, without the user having to know anything about that chip's specific memory layout.

## PIC memory models

The `clearram.h` library has two codegen paths because PIC data memory isn't addressed the same way across the range of chips GCBASIC targets. This is the whole reason `ClearRAM` can't just be one loop from `0` to `ChipRam-1` — which
addresses are real, and how you reach them, genuinely differs by family.

| `ChipFamily` | Core | Typical parts | RAM layout | How `ClearRAM` addresses it | `CHIPFREERAMLINEAR` |
|---|---|---|---|---|---|
| 12 | 12-bit baseline | 10F/12F5xx | Single small bank, tens of bytes | Direct `FSR`/`INDF`, banked path | `0` |
| 14 | 14-bit classic mid-range | 16F87x, 16F88x | Multiple 128-byte banks, genuinely non-contiguous, `STATUS.IRP` selects which bank pair `FSR`/`INDF` reaches | `FSR`/`INDF` + `STATUS.IRP`, banked path (one loop per bank) | `0` |
| 15 | 14-bit enhanced mid-range | 16F1xxx | Same banked physical layout as family 14, **plus** a flat linear window (`0x2000`+) that reaches every bank's GPR without switching | `FSR0`/`POSTINC0` against the linear window, linear path (usually one loop total) | `-1` |
| 16 | PIC18 | 18Fxxxx, 18F-Q series | Data memory is inherently flat/linear (12-bit `FSR`), banking (`BSR`) only matters for *direct*-addressed instructions, not indirect `FSR` access | `FSR0`/`POSTINC0`, linear path (identity mapping — no `0x2000` offset needed) | `-1` |

The practical effect: families 12 and 14 need `clearram.h`'s banked path
(`STATUS.IRP` + `FSR`/`INDF`, one loop per bank, since there's no way to
reach two banks without switching between them). Families 15 and 16 both
qualify for the linear path even though their underlying hardware reasons
are different — 15 has a genuine dual-addressing scheme (banked *and*
linear, GCBASIC chooses linear here), while 16's data memory was simply
never banked for indirect access in the first place. `CHIPFREERAMLINEAR`
is the one constant that collapses that distinction down to the choice
that actually matters for codegen: does a single flat `FSR0` sweep reach
this chip's whole free-RAM block, or does the sweep need to switch banks
partway through.

- **`clearram.h`** — standalone GCBASIC library file containing
  `Sub ClearRAM`, built from those constants. Not called directly anywhere
  — see "InitSys changes" below for how it actually gets invoked.

## Constants created

All created by the compiler inside `BuildMemoryMap` method, so they
exist for every chip by the time any library code (including <clearram.h>) is
compiled. Nothing here needs the user to do anything — these are populated
automatically from the chip's own `.dat` file.

### Summary constants (one pair per chip)

| Constant | Type | Meaning |
|---|---|---|
| `CHIPFREERAMBLOCKS` | Integer | Number of contiguous free-RAM blocks found for this chip (1–50). Everything below is repeated once per block, `1..CHIPFREERAMBLOCKS`. |
| `CHIPFREERAMLINEAR` | `-1` / `0` | `-1` if this chip can clear RAM through one flat `FSR0` address space (`ChipFamily` 15 or 16 — enhanced mid-range / PIC18). `0` for classic banked families. Selects which half of `clearram.h`'s `#IF` runs. |

### Per-block constants (`n` = block number, `1..CHIPFREERAMBLOCKS`)

| Constant | Type | Meaning | Used by |
|---|---|---|---|
| `CHIPFREERAMBLOCKnSTART` | Integer | Physical start address of the block (decimal). | Diagnostics only — not referenced by `clearram.h` directly. |
| `CHIPFREERAMBLOCKnLEN` | Integer | Block length in bytes. | Diagnostics only. |
| `CHIPFREERAMBLOCKnIRP` | `0` / `1` | `STATUS.IRP` setting needed to reach this block via `FSR`/`INDF`. Meaningful only on classic banked families; still created (harmlessly) on 15/16. | `clearram.h`'s banked-family path. |
| `CHIPFREERAMBLOCKnFSR8` | Integer, 0–255 | 8-bit `FSR`-loadable start offset within the `IRP`-selected bank pair. | `clearram.h`'s banked-family path. |
| `CHIPFREERAMBLOCKnFSR8END` | Integer, 0–255 | `FSR8 + LEN`, precomputed, so `clearram.h` never adds these at assemble time. | `clearram.h`'s banked-family loop-exit compare. |
| `CHIPFREERAMBLOCKnLFSR` | Integer | 16-bit `FSR0`-loadable linear start address. On families 15/16 this is the `0x2000+`-mapped address; on all other families it equals `START` (unused there, since `GetLinearLoc` is a no-op off family 15). | `clearram.h`'s linear-family path. |
| `CHIPFREERAMBLOCKnLFSREND` | Integer | `LFSR + LEN`, precomputed. | `clearram.h`'s linear-family loop-exit compare. |

### Worked example — classic banked chip (illustrative, e.g. a 16F887-style part)

`.dat` file has:
```
[FreeRAM]
20:7F
A0:EF
110:14F
190:1EF
```
Four contiguous blocks, none crossing a bank boundary, so:

```
CHIPFREERAMBLOCKS   = 4
CHIPFREERAMLINEAR   = 0

CHIPFREERAMBLOCK1START = 32     CHIPFREERAMBLOCK1LEN = 96
CHIPFREERAMBLOCK1IRP   = 0      CHIPFREERAMBLOCK1FSR8 = 32   CHIPFREERAMBLOCK1FSR8END = 128

CHIPFREERAMBLOCK2START = 160    CHIPFREERAMBLOCK2LEN = 80
CHIPFREERAMBLOCK2IRP   = 0      CHIPFREERAMBLOCK2FSR8 = 160  CHIPFREERAMBLOCK2FSR8END = 240

CHIPFREERAMBLOCK3START = 272    CHIPFREERAMBLOCK3LEN = 96
CHIPFREERAMBLOCK3IRP   = 1      CHIPFREERAMBLOCK3FSR8 = 16   CHIPFREERAMBLOCK3FSR8END = 112

CHIPFREERAMBLOCK4START = 400    CHIPFREERAMBLOCK4LEN = 96
CHIPFREERAMBLOCK4IRP   = 1      CHIPFREERAMBLOCK4FSR8 = 144  CHIPFREERAMBLOCK4FSR8END = 240
```
(`LFSR`/`LFSREND` are also created for this chip, equal to `START`/`START+LEN`, but `clearram.h` never reads them since `CHIPFREERAMLINEAR = 0`.)

### Worked example — enhanced mid-range chip (illustrative, e.g. a 16F1829-style part)

**Note:** this uses a *different* physical layout than the classic-chip
example above, not the same one. `GetLinearLoc` (`gcbasic.bas:15516`) only
maps a bank offset into linear space when it falls in `32..111` — the last
16 bytes of each 128-byte bank (`112..127`, i.e. `0x70..0x7F`) fall outside
that range and are left unchanged (not linear-addressable). On real family-15
chips those 16 bytes per bank are exactly the ones reserved as common RAM in
`[NoBankRAM]`, so they never appear in `[FreeRAM]` to begin with — a
family-15 chip's `[FreeRAM]` blocks are typically 80 bytes each (`32..111`
of each bank), not the 96-byte blocks used in the classic-chip example
(which had no such reservation). Reusing the classic example's addresses
here would have produced blocks that partially fall outside the linear
window — worth calling out since it's an easy mistake to make when
hand-writing `.dat` files or test fixtures for family 15/16 chips.

With a consistent 80-byte-per-bank layout (`.dat`: `20:6F`, `A0:EF`,
`120:16F`, `1A0:1EF`) and `ChipFamily = 15` (so `CHIPFREERAMLINEAR = -1`):

```
CHIPFREERAMBLOCK1LFSR = 8192 (0x2000)   CHIPFREERAMBLOCK1LFSREND = 8272 (0x2050)
CHIPFREERAMBLOCK2LFSR = 8272 (0x2050)   CHIPFREERAMBLOCK2LFSREND = 8352 (0x20A0)
CHIPFREERAMBLOCK3LFSR = 8352 (0x20A0)   CHIPFREERAMBLOCK3LFSREND = 8432 (0x20F0)
CHIPFREERAMBLOCK4LFSR = 8432 (0x20F0)   CHIPFREERAMBLOCK4LFSREND = 8512 (0x2140)
```
Each block maps to exactly 80 linear bytes, and — because the per-bank
offset range is identical for every bank — the four blocks land back-to-back
in linear space too, even though they weren't contiguous physically. (This
won't always happen; it's just a property of this particular evenly-shaped
example, not something `clearram.h` relies on.)

(`START`/`IRP`/`FSR8`/`FSR8END` are also created for this chip, but `clearram.h`
never reads them since `CHIPFREERAMLINEAR = -1`.)

### Worked example — 18F46Q35 (real chip, not illustrative)

```
[FreeRAM]
500:14FF
```

Just one range — 4096 bytes, exactly matching `RAM=4096` in `[ChipData]`.

`ChipFamily = 16` (PIC18), so `CHIPFREERAMLINEAR = -1` and `GetLinearLoc` is
a no-op (`LFSR` = `START`):

```
CHIPFREERAMBLOCKS       = 1
CHIPFREERAMBLOCK1START  = 1280  (0x500)     CHIPFREERAMBLOCK1LEN    = 4096 (0x1000)
CHIPFREERAMBLOCK1LFSR   = 1280  (0x500)     CHIPFREERAMBLOCK1LFSREND = 5376 (0x1500)
```

The compiled `ClearRAM` for this chip is exactly one loop — the same one
verified against real compiled output earlier in this project — clearing
`0x500`–`0x14FF` and nothing else.

## Block count limit

**Max 50 blocks.** Very generous for real `.dat` files (most classic
mid-range chips have 2–4 banks; enhanced/PIC18 chips are usually 1–2
linear regions) — 50 gives large margin for oddly-fragmented layouts. If
a future chip still needs more, `CRMaxSupportedBlocks` in the patch and
the unrolled block count in `clearram.h` need to grow together (regenerate
`clearram.h` from the template rather than hand-editing). The patch
already `LogError`s loudly if a chip exceeds the current limit, rather
than silently truncating.

## InitSys changes

`ClearRAM` is never called directly by the user. Instead, the base library
always defines an empty placeholder, and always calls it unconditionally
from `InitSys`:

```
Sub InitSys
  ... lots of init code
  #IFDEF PIC
    ClearRAM
  #ENDIF
End Sub

Macro ClearRAM
End Macro
```

A user opts in with a single line anywhere in their own program:
`#include <clearram.h>`. That defines a real `Sub ClearRAM`, which GCBASIC
resolves over the same-named empty macro — so `InitSys`'s existing,
unconditional call now runs the real block-clearing implementation, with
nothing to change at the call site and nothing for the user to call
themselves. Without that `#include`, the call resolves to the empty macro
and compiles to nothing — zero cost for every program that doesn't ask for
RAM clearing.


**Why the call must be last, not first:** if any of "... lots of init
code" above the `ClearRAM` call writes to ordinary GPR RAM — most plausibly
pin/port shadow variables, if `InitSys` (or code it triggers) uses any —
placing `ClearRAM` before that code would be fine (clears first, real
setup writes after, nothing lost), but placing it after is only safe if
nothing earlier in `InitSys` depends on GPR state surviving past this
point. Worth confirming what "lots of init code" actually touches before
finalizing the exact position — if `InitSys` only ever writes real SFRs
directly (`TRISx`, `ANSELx`, etc.) and never uses a GPR-backed shadow
variable itself, last-line placement is correct and matches the ordering
this whole feature was designed around: clear everything before `Main`,
before any other library's own init code, but after `InitSys`'s own
SFR-level setup.
