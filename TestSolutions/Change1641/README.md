# Change1641 — HWI2C across every 18FxxQxx family

27 minimal hardware-I2C bus-scan programs (one representative chip per `18FxxQxx` family, at three
`HI2C_BAUD_RATE` points each: 100/125/400 kHz) written to compile-test `hwi2c.h`'s automatic
`I2C1CLOCKSOURCE`/`I2C1BAUD` selection across the whole family lineup, following a series of fixes made
to `C:\GCstudio\gcbasic\include\lowlevel\hwi2c.h` on 2026-09-16:

1. `HI2CQ24Q35INIT` (Q24/Q35 chip families) previously hardcoded `I2C1CLK` to a fixed 500kHz MFINTOSC
   regardless of `I2C1CLOCKSOURCE`, with its own companion baud calculation that unconditionally errored
   out above ~100kHz — even though the general clock-source logic (used by every other family) had
   already correctly picked FOSC. It now uses the resolved `I2C1CLOCKSOURCE`/`I2C1BAUD` like every other
   family.
2. The auto-selection threshold that decides "use MFINTOSC or FOSC" was a flat `HI2C_BAUD_RATE <= 125`,
   which assumes a divisor of 4. Chips with `I2C1CON3` (Q20/Q24/Q35/Q71 — divisor 5) can only reach
   100kHz via MFINTOSC, so a 101–125kHz request on those chips was routed to a clock source that
   mathematically couldn't reach it. The threshold is now divisor-aware (100kHz for `I2C1CON3`-equipped
   chips, 125kHz otherwise).
3. Chips with no `I2C1BAUD` register at all (the `18FxxQ43`, `K42` and `K83` families - there is no
   programmable reload counter on these, `FSCL` is purely `I2C1CLK` source ÷ a fixed 4 or 5 depending on
   `FME`) previously had `HI2C_BAUD_RATE` silently ignored entirely. `hwi2c.h` now searches every
   compile-time-known `I2C1CLK` source × `FME` combination and picks whichever gets closest to the
   requested rate, reporting the achieved speed with an `Info` message.
4. `I2C1CLOCK_TIMER0OVERFLOW`/`TIMER2PSO`/`TIMER4PSO`/`TIMER6PSO`/`SMT1` were only ever correct for
   K42/K83 - every other family here has an extra `EXTOSC` option at `CLK=5` that K42/K83 don't have,
   shifting the timer sources down by one. Confirmed directly against each family's own Microchip
   datasheet (not just chipdata/tooling, which turned out to be an unreliable source for this specific
   register - see the note below) and resolved per-family via `#script`, using `ChipSubFamily` the same
   way the rest of this file already does.

## Chips covered

One representative chip per `18FxxQxx` family (the "new I2C" module families — `I2C1CON0`/`I2C1CLK`/
`I2C1BAUD`, not the older MSSP module):

| Family | Chip | Divisor (register layout) | Init/scan pattern |
|---|---|---|---|
| Q20 | 18F16Q20 | 5 (`I2C1CON3` present) | `HI2CMode`+`HI2CStart`/`HI2CSend`/`HI2CStop` |
| Q24 | 18F26Q24 | 5 | `HI2CMode`+`HI2CStart`/`HI2CSend`/`HI2CStop` (via `HI2CQ24Q35INIT`) |
| Q35 | 18F46Q35 | 5 | `HI2CMode`+`HI2CStart`/`HI2CSend`/`HI2CStop` (via `HI2CQ24Q35INIT`) |
| Q40 | 18F16Q40 | 4 | `SI2CDiscovery` |
| Q41 | 18F16Q41 | 4 | `SI2CDiscovery` |
| Q43 | 18F26Q43 | 4 (no `I2C1BAUD` at all — see below) | `SI2CDiscovery` |
| Q71 | 18F26Q71 | 5 | `SI2CDiscovery` |
| Q83 | 18F27Q83 | 4 | `SI2CDiscovery` |
| Q84 | 18F27Q84 | 4 | `SI2CDiscovery` |

Every file's PPS/pin setup was copied **verbatim** (register values, not just the pattern) from an
already-existing, already-verified-compiling demo for that exact chip elsewhere in this repo — see the
header comment of each `.gcb` file for its source. Only the body (a bus-scan loop) and the
`HI2C_BAUD_RATE` value are new.

## Compile + ASM verification

All 27 files were compiled with GCBASIC (`/NP /S:use.ini /F:N /P: /DO`) and every one assembled cleanly
(exit code 0). Per the project's "don't trust a clean compile alone" rule, the generated `.asm` for each
was also inspected for the literal `I2C1CLK`/`I2C1BAUD` values actually emitted, and independently
hand-verified against the formula in `hwi2c.h`:

```
FSCL = FI2CxCLK / (divisor * (I2C1BAUD + 1))     divisor = 5 if I2C1CON3 present, else 4
```

| Family | 100kHz | 125kHz | 400kHz |
|---|---|---|---|
| Q20/Q24/Q35/Q71 (divisor 5) | MFINTOSC, BAUD=0 (exact 100kHz) | **FOSC**, BAUD=101 (≈125.5kHz @64MHz) | FOSC, BAUD=31 (exact 400kHz @64MHz) |
| Q40/Q41/Q83/Q84 (divisor 4) | MFINTOSC, BAUD=0 (exact 100kHz) | MFINTOSC, BAUD=0 (exact 125kHz — boundary stays MFINTOSC) | FOSC, BAUD=39 @64MHz (Q41) or BAUD=9 @16MHz (Q40/Q83/Q84) |
| Q43 (no `I2C1BAUD` register) | MFINTOSC, FME=0 (exact 100kHz) | MFINTOSC, FME=1 (exact 125kHz) | MFINTOSC, FME=1 nearest fit (125kHz - closer than any FOSC-derived option at this chip's clock speed) |

The bolded 125kHz/divisor-5 row is the exact case fix #2 above addresses — before the fix, this failed
to compile at all (`Error: Clock frequency too slow for desired I2C1 HI2C_BAUD_RATE`) on every
divisor-5 family. The Q43 row is fix #3 - verified by hand-computing `FSCL = FI2CxCLK/(4 or 5)` for
every combination of `I2C1CLK` source and `FME` known at compile time and confirming the compiler picked
the one with the smallest difference from the request, matching the generated `bsf`/`bcf I2C1CON2,FME`
instruction and the `Info` message's reported achieved speed.

### `I2C1CLOCK_*` constants (fix #4) - verified via each build's `.cdf`

Rather than trust a single web-fetched datasheet page (one such fetch during this investigation turned
out to have pulled the wrong device's table entirely - resolved by downloading the actual PDF for each
family and reading the real register table directly), every family's resolved constants were checked in
its own build's `<name>.cdf` report (`FINAL/CONSTANT` lines):

| Group | Families | `EXTOSC` | `TIMER0OVERFLOW` | `TIMER2PSO` | `TIMER4PSO` | `TIMER6PSO` | `SMT1` |
|---|---|---|---|---|---|---|---|
| Default | Q20,Q24,Q35,Q40,Q41,Q43,Q71,Q83,Q84 | 5 | 6 | 7 | 8 | *(undefined)* | *(undefined)* |
| K42/K83 | K42, K83 | *(undefined)* | 5 | 6 | 7 | 8 | 9 |

`TIMER6PSO`/`SMT1` are deliberately left undefined for the default group rather than given a value that
would only be correct for some of those chips (their real position varies per family beyond `CLK=8` -
see `hwi2c.h`'s own comment for the full per-family breakdown found while researching this). Referencing
either outside K42/K83 is a compile error (`NODEF`), not a silently wrong clock source.

## Files

27 `.gcb` files named `HWI2C_<chip>_<freq>kHz.gcb`, e.g. `HWI2C_18F26Q71_125kHz.gcb`.
