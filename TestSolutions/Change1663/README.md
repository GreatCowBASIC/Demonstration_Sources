# Change 1663: a name that is a chip bit is an error; three code-generation fixes

A variable or a sub parameter can have the name of a bit in one of the chip's registers - `CON` is bit 7 of `CM1CON` on
the PIC18F46J50, `TMR1ON` bit 0 of `T1CON` on the 16F1829, `TOV0` bit 0 of `TIFR0` on the mega328p. The compiler then
uses the bit, not a variable:

- **A `Dim`'d variable**: build 1662 gave only the warning "Variable name CON is used for a system bit on the current
  chip", and compiled `COn = PORTA` as `bcf` / `bsf CM1CON,CON` - the program changed a comparator bit instead of
  storing a byte.
- **A sub parameter**: build 1662 gave no warning (parameters are declared while the program is read, before the chip's
  bits are known); a call such as `Show(1)` compiled to `bsf CM1CON,CON`, and the assembler stopped with
  `Conflicting definition for CON sub parameter variable. %var% is a %type%. Invalid source variable type` - a message
  meant for another error, with its placeholders left in.

Build 1663:

- Both are an error, which names the bit:
  `Variable name CON is the name of bit CM1CON.7 on the current chip: the compiler would use that bit, not a variable.
  Rename it (#define DISABLE1663 makes this a warning)` (or `Parameter name ...`, at the sub's line).
  Parameters are checked once the subs are compiled, for the subs the program uses.
- `#define DISABLE1663` makes it the build 1662 warning again (the compiler still uses the bit).
- The assembler's own message for a name defined twice is now
  `GCASM: CON is defined twice, as 7 and as 1: a variable, parameter, label or constant has the same name as a register
  or bit on the current chip. Rename it`.
- Using a bit by its name (`CON = 1`, `ADIF = 0`, `CM1CON.CON = 0`) is unchanged.

## Test programs

| Program | Expected (build 1663) |
|---|---|
| `NameIsBit_Dim.gcb` (`#SKIPTEST`) | Error: Variable name CON is the name of bit CM1CON.7 ... |
| `NameIsBit_Dim_Disable1663.gcb` | compiles, with the warning (as build 1662) |
| `NameIsBit_Parameter.gcb` (`#SKIPTEST`) | Error: Parameter name CON is the name of bit CM1CON.7 ..., at the line of `Sub Show` |
| `NameIsBit_Parameter_Disable1663.gcb` (`#SKIPTEST`) | the warning, then Error: GCASM: CON is defined twice, as 7 and as 1 ... |
| `NameIsBit_PIC16.gcb` (`#SKIPTEST`) | Error: Variable name TMR1ON is the name of bit T1CON.0 ... |
| `NameIsBit_AVR.gcb` (`#SKIPTEST`) | Error: Variable name TOV0 is the name of bit TIFR0.0 ... |
| `BitNames_StillWork.gcb` | compiles, no warning: the same asm as build 1662 |

## Code-generation fixes (found with the Starter Kit's Asteroids and Flappy Bird demos)

Three faults, each in code the compiler generates for itself; the programs compiled without any message and ran wrongly.

1. **Two calls of a function in one line inside a sub** (`Result = Half(-300) + Half(-100)`). The first result is kept
   in a temporary (`SysFnINTEGER1`, `SysFnWORD1`, ...) while the second call is made. The line that copies it was
   added without the line's origin, so it was compiled as part of the main program, where the temporary is not known -
   a Byte - and only the low byte of an Integer, Word or Long result was copied. Now the line carries the origin.
   (In Asteroids the rocks got speeds of about 30 pixels a frame.)
2. **A Byte array element in a sub that also uses an Integer array.** The array temporaries (`SysArrayTemp1`, ...)
   are Integers in such a sub. The lines that read an element into them also had no origin, so a Byte element was read
   without clearing the temporary's high byte, and a comparison that followed (`If Size(Idx) > 0 ...`) used whatever an
   Integer element had left there. Now these lines carry the origin, and the high byte is cleared. (In Asteroids, rocks
   were not rubbed out and left trails.)
3. **An interrupt that reads a table (PIC18).** The interrupt now saves and restores `TBLPTRL`, `TBLPTRH`, `TBLPTRU`
   and `TABLAT` when the code it runs reads a table (a call to a table's routine, or the registers themselves) - for
   example the USB interrupt, which reads its descriptor tables. Before, an interrupt in the middle of a `ReadTable` in
   the main program could change what it read.

| Program | Expected (build 1663) | Build 1662 |
|---|---|---|
| `FunctionTwiceInSub.gcb` | `movff HALF,SysFnINTEGER1` and `movff HALF_H,SysFnINTEGER1_H`; Result = -200 | the high byte not copied |
| `ByteArrayInSub.gcb` | `clrf SysArrayTemp1_H` / `clrf SysArrayTemp2_H` after each Byte element read; Hits = 1 | not cleared; Hits = 0 |
| `InterruptTableRead.gcb` | the interrupt saves and restores TBLPTRL, TBLPTRH, TBLPTRU, TABLAT | not saved |
