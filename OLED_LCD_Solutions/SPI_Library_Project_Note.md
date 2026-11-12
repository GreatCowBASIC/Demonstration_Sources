# SEH1602-A OLED: how to go about making an SPI library

2026-11-12. Status: plan only. Nothing has been written or tested in serial mode yet, and the module has not been modified.

## Goal

Drive the SEH1602-A in its serial (SPI-style) mode from GCBASIC, so that the existing programs (`Print`, `Locate`, `Cls`, `LCDCreateChar`, and the raw-command demos) run unchanged after a change to the configuration block only.

The parallel setup works today (see `SEH1602-A_OLED_notes.md`). The point of the serial mode is fewer pins: 4 instead of 6.

## Why a new driver is needed

- `lcd.h` has no serial mode for this display. `LCD_IO 14` and `LCD_IO 16` talk to a port expander (MCP23S17 or the PIC16LF72 expander), which then drives a normal parallel LCD. Neither speaks to the controller's own serial port.
- The controller's serial protocol is a 10-bit frame (RS, R/W, then 8 data bits), not a byte-oriented SPI transfer.

## Hardware prerequisites

### 1. Rework the module

The vendor's instruction, and its picture (`SPI modify moethod.JPG`, from a REV.K board): remove the `J68` resistor, move the `PSH` resistor to `PSL`, and move the `CSL` resistor to `JCS`. Our board is a REV.L, so check the silkscreen first. See "Changing to SPI" in the notes.

- The change is hard to reverse. Resoldering the parts puts it back, and the parallel demos only run again after that.
- Photograph the board first. `images/seh1602a_back_view.jpg` is the "before" picture.

### 2. Wiring

The serial pins sit on header pins that the current parallel wiring already uses, so only /CS is new.

| Header pin | Serial function | Current parallel wiring | Serial wiring |
| --- | --- | --- | --- |
| 1 | Vss | GND | GND |
| 2 | Vdd (5 V) | 5 V | 5 V |
| 12 | SCL | DB5 = RC0 | RC0, output |
| 13 | SDO (display output) | DB6 = RC1 | RC1, **input** |
| 14 | SDI (display input) | DB7 = RC2 | RC2, output |
| 16 | /CS (active low) | not connected | new wire, for example RA2 (move it from pin 11, which is not connected in serial mode) |
| 4, 6, 11 | not connected | RS = RA0, E = RA1, DB4 = RA2 | leave unused |

- The display drives SDO. If the PIC still drives RC1 as an output (as the parallel code does), there is a contention. Do not run the parallel firmware on a modified module with RC1 connected.
- RA0 and RA1 are the ICSP data and clock pins on the 16F1829 (check the datasheet). They are free once RS and E are no longer used.
- The module datasheet says that with VDD = 5 V the logic I/O must not be 3 V or 3.3 V. The PIC runs at 5 V, so this is met.

## Protocol summary

From the IST0010 specification (`IST0010.pdf`, pages 43, 44 and 51) and the WS0010 specification (`datasheets/WS0010_specification_WS-RD-0001.pdf`, page 37). The IST0010 is from the same family as the WS0010 with the same instruction set text, but I have not confirmed they are identical.

- SCL idles high. SDI changes while SCL is low and is sampled on the **rising edge**.
- One frame, with /CS low: RS, R/W (0 for a write), then D7 down to D0. RS = 0 is a command and RS = 1 is a RAM (character or graphic) write.
- /CS goes high again after each command or single data write. A continuous RAM write (RS = 1) keeps /CS low and sends the RS and R/W bits once, then back-to-back data bytes.
- Minimum timing: clock cycle 300 ns, SCL high and low 100 ns each, /CS setup and hold 150 ns, data setup and hold 100 ns.

## Design decisions

### D1. Bit-bang first, hardware SPI later (if at all)

Recommendation: bit-bang all 10 bits.

- The 10-bit frame does not fit the 8-bit MSSP shift register directly. The MSSP in mode 3 (clock idles high, rising-edge sample) matches the 8 data bits, but the two header bits would still need special handling. Padding the frame with extra clocks is not allowed by anything I have read, so I would not try it without a test.
- Speed is not a problem. The existing waits after each byte (200 µs for graphic data, 2 ms for commands) dwarf the 10 clocks.
- Bit-banging works on any chip and any pins, as `LCD_IO 16` already does.

### D2. Where the code goes

| Option | How | For | Against |
| --- | --- | --- | --- |
| A: new `LCD_IO` mode inside `lcd.h` | Follow the `LCD_IO 16` pattern: the `#SCRIPT` block assigns `InitLCD`, `LCDNormalWriteByte`, `Locate` and `CLS`, and uses `Error` when a required constant is missing | All existing programs and library functions work unchanged | Edits the shared library, and the mode number must not clash with the maintainers' |
| B: separate include file, for example `oled_ws0010_spi.h` | Defines its own write, init, `Locate` and `Cls` subs | Does not touch `lcd.h` | Programs have to call the new subs, so existing ones need changes |

Recommendation: prototype as B (a standalone program) to prove the protocol, then move it into `lcd.h` as A. The mode number is a placeholder until it is checked against the library.

### D3. How RS is handled

The library's callers do `Set LCD_RS On` or `Set LCD_RS Off`, then `LCDWriteByte`. If `LCD_RS` is not defined, `lcd.h` makes it a software bit (`SysLCDTemp.1`). So in serial mode do not define `LCD_RS` in the configuration. The write routine just reads it as the first header bit, as `LCD_IO 16` does.

### D4. The write routine

Sketch of the logic (pseudocode, not tested):

```
Sub LCD_SPI_WriteByte(In LCDByte)
    CS low
    send bit: RS                 'the software flag
    send bit: 0                  'R/W = write
    repeat 8: send bit LCDByte.7, then rotate left
    CS high
End Sub

send bit:  SCL low, set SDI to the bit, SCL high   'SCL ends high, so it idles high
```

After a write the existing waits still apply, because no busy flag is read: 2 ms per command, 10 ms after clear, about 200 µs per data byte.

### D5. Initialisation

- Wait 500 ms after power on (the vendor's figure).
- There is no 4-bit or 8-bit data length to set up in serial mode, so the 0x3 wake-up pulses go away.
- Then send the same instructions as now: `0x28`, `0x08`, `0x01` (wait 10 ms), `0x06`, `0x17` (wait 10 ms), `0x0C`.
- In 4-bit parallel mode the controller can lose track of which nibble is which. In serial mode every frame starts when /CS falls, so that failure should not exist. That would make the `OLED_Resync` workaround unnecessary. This is an expectation, not something I have verified.

### D6. Reads

SDO returns a dummy byte first, then valid data. Reading the busy flag is not needed (the library already runs without it with `LCD_NO_RW`), so leave it out of version 1.

### D7. Configuration constants

Keep the names `LCD_IO 16` already uses, and add the ones it lacks:

| Constant | Meaning |
| --- | --- |
| `LCD_SPI_SCK` | SCL pin |
| `LCD_SPI_DO` | MCU data out, which is the display's SDI |
| `LCD_SPI_CS` | /CS pin (new) |
| `LCD_SPI_DI` | MCU data in, which is the display's SDO (optional, new, for later reads) |

## Plan

| Phase | Work | Done when |
| --- | --- | --- |
| 0. Prepare | Keep the compiled parallel hex files as a regression baseline. Photograph the board (done) | Baseline saved |
| 1. Rework and check | Make the vendor change. Check the serial pins with a meter against the table above | Pins confirmed, no shorts, supply current about 31 mA typical (46.5 mA maximum) |
| 2. Bring-up program | Standalone `oled_spi_bringup.gcb` with no `lcd.h`: bit-bang the frames, run the init, print a short text | Text appears on the display |
| 3. Timing check | If a scope is available, compare SCL, SDI and /CS with the minimums above | Within the table |
| 4. Library integration | Add the new mode to `lcd.h` (option A). Change only the configuration block in `oled_ws0010_test.gcb`, `oled_ddram_probe.gcb`, `oled_gfx_ruler.gcb` and `oled_scope.gcb` | All four demos behave as in parallel mode |
| 5. Resync check | Run the graphic demo without `OLED_Resync`, and reset the PIC without removing power | No corruption (this confirms D5) |
| 6. Document | Update `SEH1602-A_OLED_notes.md` and the share | Notes match what was tested |

## Risks and unknowns

- The rework is hard to reverse, and a second module would be useful in case something goes wrong.
- The serial timing comes from the IST0010 specification. The WS0010 page only shows the frame, not the clock minimums.
- It is not documented whether SDO is high-impedance while /CS is high.
- Hardware SPI use is untested (see D1).
- The `LCD_IO` number and any change to `lcd.h` need agreeing with whoever maintains the library.
- The delays after each instruction are datasheet minimums. This module may need longer ones, as it did in parallel mode.

## Decisions needed

1. Option A or B for the first version (the recommendation is B, then A).
2. The `LCD_IO` number or name for the new mode.
3. Which PIC pin to use for /CS (RA2 is suggested because its wire can move from header pin 11 to pin 16).
4. Whether the demos should keep running in both modes with a configuration switch, or move to serial only.

## References

- `SEH1602-A_OLED_notes.md`: findings so far, pin tables, timing, vendor initialisation.
- `SEH1602-A.pdf`: module datasheet.
- `IST0010.pdf`: controller specification with the serial timing.
- `datasheets/WS0010_specification_WS-RD-0001.pdf`: WS0010 specification.
- `SPI modify moethod.JPG`: vendor picture of the rework.
- `C:\GCstudio\gcbasic\include\lowlevel\lcd.h`: the library. See the `LCD_IO 16` section in the `#SCRIPT` block and `InitLCD_IO16_PICSPI` for the pattern to copy.
