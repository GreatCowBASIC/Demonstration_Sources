# TC77 SPI Temperature Sensor for GCBASIC

GCBASIC library and demo programs for the Microchip **TC77** SPI digital temperature sensor
(datasheet DS20092B), targeting a PIC18F4550 board with a serial terminal on COM4.

## Files

| File | Purpose |
|---|---|
| `TC77_to_Serial_Terminal_SW_SPI_18F4550.gcb` | Demo using bit-banged Software SPI |
| `TC77_to_Serial_Terminal_HW_SPI_18F4550.gcb` | Demo using the chip's Hardware SPI module (MSSP1) |
| `20092B.pdf` | Microchip TC77 datasheet |


Both demos are confirmed working end-to-end on real hardware: correct Manufacturer ID
detection (`0x54xx`) and stable, physically accurate temperature readings over COM4 at 9600 bps.

## Wiring (this board)

The TC77 is wired with a single physical SI/O line (no separate MOSI/MISO):

| TC77 pin | MCU pin |
|---|---|
| CS | PortB.2 |
| SCK | PortB.1 |
| SI/O | PortB.0 |

`TC77_DO` and `TC77_DI` are both `#define`d to PortB.0 in the demos. The library releases
`TC77_DO` as an input except while actively writing the Configuration register, so sharing one
pin this way does not cause bus contention on reads.

## Hardware vs Software SPI

Both demos share `TC77.h`; only the port configuration block differs:

```gcbasic
#DEFINE TC77_HardwareSPI                                          ' omit this line for Software SPI
#DEFINE HWSPIClockMode  SPI_SS_0 + SPI_CPOL_0 + SPI_CPHA_0         ' TC77 requires SPI Mode 0,0

#DEFINE TC77_CS   PortB.2
#DEFINE TC77_SCK  PortB.1
#DEFINE TC77_DO   PortB.0
#DEFINE TC77_DI   PortB.0

#include <TC77.h>
```

When `TC77_HardwareSPI` is defined, `TC77_SCK`/`TC77_DO`/`TC77_DI` must be wired to the target
chip's actual hardware SPI pins (on the 18F4550, MSSP1 is fixed to RC3/RC4/RC5 - there is no PPS
on this chip to remap it). On this particular board those pins happen to be PortB.1/0/0 instead;
see **Implementation notes** below for why that still works correctly.

## Library API (`TC77.h`)

Exposed results, mirroring the DS18B20 library's `DSint`/`DSdec` pattern:

| Variable | Type | Meaning |
|---|---|---|
| `TC77Int` | Integer | Whole-degree Celsius. A negative reading is encoded as `128+n` - test `TC77Int >= 128` and subtract 128 to recover the magnitude |
| `TC77Dec` | String\*4 | Fractional part in 0.0625°C steps, e.g. `"3125"` for `x.3125` |
| `TC77Dec1` | Byte | `TC77Dec` rounded to a single decimal digit (0-9) |
| `TC77Str` | String\*8 | `TC77FormatTemp`'s fixed `"-xx.xxxx"` to `"+xx.xxxx"` result (see below) |
| `TC77RawRegister` | Word | Diagnostic: the untouched 16-bit register value from the last read |

Routines:

| Call | Effect |
|---|---|
| `TC77ReadTemp` | Reads the Temperature register; updates `TC77Int`, `TC77Dec`, `TC77Dec1` |
| `TC77ReadTemp12` | Returns the raw signed-magnitude 13-bit value (0.0625°C/bit); mirrors DS18B20's `readtemp12` |
| `TC77FormatTemp` | Calls `TC77ReadTemp` and formats the result into `TC77Str`, an 8-character `"-xx.xxxx"`/`"+xx.xxxx"` string. Only shows the low 2 digits of the whole-degree part (suits -99 to +99°C use; use `TC77Int`/`TC77Dec` directly for the sensor's full -55 to +125°C range) |
| `TC77Shutdown` / `TC77Wake` | Write the Configuration register to enter Shutdown (0.1µA typ.) or Continuous Conversion mode |
| `TC77ReadManufacturerID` | Reads the Manufacturer ID register (only valid while already in Shutdown mode) |
| `TC77Detect` | Runs the datasheet's documented single-CS-session sequence (§3.3): read temp, write Shutdown, read Manufacturer ID, write Continuous Conversion - retried 4 times, 25ms apart. High byte of the result is `0x54` for a genuine TC77 |

`TC77Shutdown`/`TC77Wake`/`TC77ReadManufacturerID`/`TC77Detect` write the Configuration register,
which requires `TC77_DO` to be physically wired to the sensor (tied together with `TC77_DI` on
this board's single-SI/O wiring). Plain temperature reads do not need `TC77_DO` connected at all.

