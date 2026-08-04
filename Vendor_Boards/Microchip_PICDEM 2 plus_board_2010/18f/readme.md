# PIC18FxxQ35 GCBASIC Demo Series — Overview

This document describes a series of GCBASIC demonstration programs written for the
**PIC18FxxQ35** (Q35 family), progressing from basic digital I/O through ADC, debounced
input, UART/LCD output, RAM/string handling, hardware timers, external interrupts,
EEPROM/program-memory data storage, I2C/SPI graphical displays, and PWM/motor-brightness
control.

All demos share the same physical board layout (4 LEDs on `PORTB.0-3`, a potentiometer
on `PORTA.0`, a direction switch on `PORTA.4`, an LCD header on `PORTD`, and a reset
button on `PORTE.3`), so later demos build directly on the constants and wiring
established in the earlier ones.

---

## ⚠️ Board-wide note: VDDIO2

On this device family, **VDDIO2 supplies power to a secondary I/O bank** (on this
particular Q35 part, that bank includes `PORTB.0-3`, `PORTB.6/7`, and `RA1` — the pins
used for every LED in this series). If VDDIO2 is not correctly wired to the supply
rail, those pins will not drive or read correctly — regardless of firmware — even
though the primary VDD/VSS pins are powered. Always verify VDDIO2 before troubleshooting
"dead" I/O or unexpected resets on any of these demos.

---

## Capability matrix

| # | Demo | Output | Input | Config | ADC | RAM | Timer | USART | I2C | SPI | PWM | EEPROM | GLCD |
|---|------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 010 | hello_world | ✓ | | | | | | | | | | | |
| 020 | blink | ✓ | | | | | | | | | | | |
| 030 | blink_another_way | ✓ | | | | | | | | | | | |
| 040 | rotate_the_leds | ✓ | | | | | | | | | | | |
| 050 | show_a2d_value_on_leds | ✓ | | | ✓ | | | | | | | | |
| 060 | variable_rotate_the_leds | ✓ | | | ✓ | | | | | | | | |
| 070 | debounce_the_switch | ✓ | ✓ | | | | | | | | | | |
| 080 | using_the_reset_switch_as_an_input | ✓ | ✓ | ✓ | | | | | | | | | |
| 090 | reversible_leds_with_variable_delay | ✓ | ✓ | | ✓ | | | | | | | | |
| 100 | ...to_serial_terminal | ✓ | ✓ | ✓ | ✓ | ✓ | | ✓ | | | | | |
| 105 | ...to_LCD | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| 110 | ...timer_overflow_event | ✓ | ✓ | ✓ | | | ✓ | | | | | | |
| 120 | ...8bit_timer0 | ✓ | ✓ | ✓ | | | ✓ | | | | | | |
| 140 | showing_eeprom_data_to_serial_terminal | ✓ | ✓ | ✓ | | | | ✓ | | | | ✓ | |
| 150 | showing_tableeeprom_data_to_serial_terminal | ✓ | | ✓ | | | | ✓ | | | | ✓ | |
| 160 | ensuring_program_matches_chip_specified | ✓ | | ✓ | | | | ✓ | | | | | |
| 170 | show_i2c_devices_to_serial_terminal | ✓ | ✓ | ✓ | | | | ✓ | ✓ | | | | |
| 180 | i2c_glcd_using_ssd1306_64_32 | ✓ | | ✓ | ✓ | | | | ✓ | | | | ✓ |
| 190 | i2c_glcd_using_ssd1306_128_64 | ✓ | | ✓ | ✓ | | | | ✓ | | | | ✓ |
| 200 | i2c_glcd_using_ssd1306_128_32 | ✓ | | ✓ | ✓ | | | | ✓ | | | | ✓ |
| 210 | i2c_glcd_sprites_using_ssd1306 | ✓ | | ✓ | | | | | ✓ | | | | ✓ |
| 220 | i2c_glcd_voltmeter_using_ssd1306 | ✓ | | ✓ | ✓ | | | | ✓ | | | | ✓ |
| 225 | i2c_glcd_bmp_ssd1306_128_64 | ✓ | | ✓ | | | | | ✓ | | | | ✓ |
| 230 | spi_glcd_using_ILI9341 | ✓ | | ✓ | | | | | | ✓ | | | ✓ |
| 240 | ccppwm_discovery | ✓ | | ✓ | | | | ✓ | | | ✓ | | |
| 241 | use_pinIO_to_control_led_brightness | ✓ | | | | | | | | | ✓ | | |
| 242 | use_pulseout_to_control_led_brightness | ✓ | | | | | | | | | ✓ | | |
| 243 | use_pwmout_to_control_led_brightness | ✓ | | | | | | | | | ✓ | | |
| 244 | use_fixed_mode_pwm_via_ccp | ✓ | | ✓ | | | | ✓ | | | ✓ | | |
| 245 | use_pwm_via_ccp_and_adc | ✓ | | ✓ | ✓ | | | | | | ✓ | | |
| 250 | using_external_interrupt_to_raise_an_event | ✓ | ✓ | ✓ | | | | | | | | | |
| 251 | using_an_interrupt_control_an_leds_brightness | ✓ | | ✓ | | | ✓ | | | | ✓ | | |
| 260 | showing_datablock_to_LCD | ✓ | | ✓ | | | | ✓ | | | | ✓ | |

---

## 010 — `010_hello_world.gcb`
**Tests:** Output

Bare-minimum bring-up: direct `Dir`/`PORTB` bit writes with no main loop. Confirms the
chip boots and pins can be driven high/low. No peripherals beyond raw GPIO.

## 020 — `020_blink.gcb`
**Tests:** Output

Whole-port digital output (`DIR PORTB Out`, `PORTB = 255` / `PORTB = 0`) alternated with
software `Wait` delays — the simplest possible blink pattern.

## 030 — `030_blink_another_way.gcb`
**Tests:** Output

Same blink goal as 020, but via named pin constants (`#DEFINE`) and the `NOT`/`!`
operator on a single bit rather than writing the whole port. A style/idiom demo rather
than a new capability.

## 040 — `040_rotate_the_leds.gcb`
**Tests:** Output

Introduces `Rotate ... Left Simple` on a byte variable with a fixed 100 ms delay,
animating the 4 LEDs as a moving pattern instead of a simple on/off blink.

## 050 — `050_show_a2d_value_on_leds.gcb`
**Tests:** Output, ADC

8-bit ADC read (`ReadAD(AN0)`) from the potentiometer on `PORTA.0`, with the result
bucketed via `If`/`Else If` thresholds into a corresponding number of lit LEDs — the
first analog-input demo.

## 060 — `060_variable_rotate_the_leds.gcb`
**Tests:** Output, ADC

Steps up to a 10-bit ADC read (`ReadAD10`), uses `Scale()` to map that into a variable
delay (100–500 ms), and drives `Rotate ... Right` with manual carry handling — the ADC
now controls *timing* rather than just a static display.

## 070 — `070_debounce_the_switch.gcb`
**Tests:** Output, Input

Adds digital input debouncing on `PORTA.4` via a poll-and-compare `funcKeyPressed()`
function, toggling all 4 LEDs together on each clean button press.

## 080 — `080_using_the_reset_switch_as_an_input.gcb`
**Tests:** Output, Input, Config

Sets `#CONFIG MCLRE=OFF` to repurpose the MCLR/`RE3` pin as an ordinary digital input
(`RSTBUTTON`) instead of a hardware reset line — the first demo to exercise a
configuration fuse rather than just runtime code.

## 090 — `090_reversible_leds_with_variable_delay.gcb`
**Tests:** Output, Input, ADC

The first full "integration" demo: combines switch debounce, direction reversal
(`NOT direction`), ADC-scaled delay, and `Rotate` into one working application. Still
entirely polling-based (no interrupts, no hardware timer).

## 100 — `100_reversible_leds_with_variable_delay_to_serial_terminal.gcb`
**Tests:** Output, Input, Config, ADC, RAM, USART

Builds on 090 and adds:
- **Hardware UART1** routed via Peripheral Pin Select (`InitPPS`, `U1RXPPS`/`RC6PPS`),
  with `HSerPrint`/`HSerSend` at 9600 baud reporting chip ID (`ChipNameStr`, `ChipMHz`)
  and live LED/delay state.
- **RAM / string-handling test**: declares `Dim ... As String` variables, builds a
  string via concatenation (`+`, `ByteToString`, `Len()`), and reports the result and
  its length over serial — exercising the RAM-backed `SYSDEFAULTCONCATSTRING`
  concatenation buffer.

## 105 — `105_reversible_leds_with_variable_delay_to_LCD.gcb`
**Tests:** Output, Input, Config, ADC

Same LED/switch/ADC core as 090/100, but output is routed to a 4-bit parallel character
LCD (Ocular OM1614 driver: `LCD_IO 4`, `LCD_RS`/`LCD_RW`/`LCD_Enable`, `LCD_POWER`) wired
on `PORTD`, instead of the serial terminal.

## 110 — `110_rotate_the_leds_using_the_timer_overflow_event.gcb`
**Tests:** Output, Input, Config, Timer

Moves the periodic heartbeat off the main loop entirely: configures Timer0 in 8-bit mode
(`PRE0_256 + TMR0_FOSC4`) and uses `On Interrupt Timer0Overflow Call blink` so an ISR
increments a counter in the background, freeing the main loop from timing duties —
interrupt-driven timing via the `On Interrupt` construct.

## 120 — `120_rotate_the_leds_using_8bit_timer0.gcb`
**Tests:** Output, Input, Config, Timer

Same 8-bit Timer0 configuration as 110, but **polled instead of interrupt-driven**
(`Wait While TMR0IF = 0`, manual flag clear, and `SetTimer` reload each pass). A direct
side-by-side contrast of ISR vs. flag-polling use of the same hardware timer; also
touches the `OSCTUNE` register.

## 140 — `140_showing_eeprom_data_to_serial_terminal.gcb`
**Tests:** Output, Input, Config, USART, EEPROM

Writes a computed byte (`255 - address`) to every location across the chip's full
on-board EEPROM (`0 To ChipEEProm - 1`) via `EPWrite`, immediately reads it back with
`EPRead`, and prints a hex grid to the serial terminal — flagging any write/read
mismatch as `--`. Demonstrates runtime EEPROM read/write as non-volatile storage, and
repeats on a switch press.

## 150 — `150_showing_tableeeprom_data_to_serial_terminal.gcb`
**Tests:** Output, Config, USART, EEPROM

A different EEPROM technique: instead of writing at runtime, data is declared at
**compile time** using `EEPROM <name> <address> ... End EEPROM` blocks, pre-loading
specific EEPROM addresses (`0x10`, `0x16`) with fixed values as part of the hex file
itself. `ShowEEProm()` then dumps the entire EEPROM contents to serial as a hex table,
so you can confirm the pre-loaded values landed at the expected addresses.

## 160 — `160_ensuring_program_matches_chip_specfiied_to_serial_terminal.gcb`
**Tests:** Output, Config, USART

A portability/safety-check demo: compares the compiler-provided `ChipNameStr` against
an expected target string (`"18F46Q35"`) using `Trim`/`UCase`, and reports over serial
whether the firmware actually matches the chip it's running on — useful for catching a
mismatched build flashed to the wrong board.

## 170 — `170_show_i2c_devices_to_serial_terminal.gcb`
**Tests:** Output, Input, Config, USART, I2C

An I2C bus scanner: routes SDA/SCL to `PORTC.4`/`PORTC.3` via PPS, then for every
possible 8-bit address issues `HI2CStart` / `HI2CSend` / `HI2CStop` and checks
`HI2CAckpollState` to detect whether a device acknowledged. Results print as a hex grid
over serial — a practical tool for discovering what I2C peripherals are actually wired
up before writing a driver for them.

## 180 — `180_i2c_glcd_using_ssd1306_64_32.gcb`
**Tests:** Output, Config, ADC, I2C, GLCD

First graphical-display demo: drives a 64×32 SSD1306 OLED over I2C using the `glcd.h`
library (`#DEFINE GLCD_TYPE GLCD_TYPE_SSD1306_64x32`). Draws boxes, a circle, and a line,
prints text/numbers, and live-updates a potentiometer reading (`ReadAD`) on screen —
exercising `GLCDPrint`, `Box`, `Circle`, `Line`, and `GLCDCLS` in "Full Memory" mode.

## 190 — `190_i2c_glcd_using_ssd1306_128_64.gcb`
**Tests:** Output, Config, ADC, I2C, GLCD

Same idea as 180, scaled up to a 128×64 SSD1306 panel. Also demonstrates the
`GLCD_TYPE_SSD1306_LOWMEMORY_GLCD_MODE` compile switch and
`GLCD_Open_PageTransaction`/`GLCD_Close_PageTransaction`, showing how to trade RAM usage
for display update method (full-memory buffer vs. low-memory page-at-a-time writes).

## 200 — `200_i2c_glcd_using_ssd1306_128_32.gcb`
**Tests:** Output, Config, ADC, I2C, GLCD

Same pattern again for a 128×32 SSD1306 panel (`GLCD_TYPE_SSD1306_32`) — confirms the
same GLCD API/code works unchanged across all three supported SSD1306 resolutions by
just swapping the `GLCD_TYPE` constant.

## 210 — `210_i2c_glcd_sprites_using_ssd1306.gcb`
**Tests:** Output, Config, I2C, GLCD

Adds sprite animation: a custom `GLCDDrawSprite_SSD1306` routine reads 8-pixel-tall
sprite column data out of a program-memory `Table`/`ReadTable`, XORs it into the GLCD
frame buffer at a moving X/Y position, and redraws it each loop — demonstrating
table-driven bitmap graphics rather than just primitive shapes/text.

## 220 — `220_i2c_glcd_voltmeter_using_ssd1306.gcb`
**Tests:** Output, Config, ADC, I2C, GLCD

Combines ADC + math + graphics into an analog-style voltmeter gauge: reads a 10-bit ADC
value, scales it to a needle angle, and uses `Line`/`Box`/`GLCDDrawChar` to redraw a
rotating needle and the numeric voltage reading each pass — a worked example of
trig/scale-driven graphics rather than static shapes.

## 225 — `225_i2c_glcd_bmp_ssd1306_128_64.gcb`
**Tests:** Output, Config, I2C, GLCD

Demonstrates bitmap image display: `#INCLUDE "ANOBIUMFULL.BMP"` auto-converts a BMP file
into a program-memory table at compile time, which is then walked pixel-by-pixel with
`PSet` to render the image onto a 128×64 SSD1306 panel — a compile-time asset pipeline
for graphics rather than hand-coded shapes or sprites.

## 230 — `230_spi_glcd_using_ILI9341.gcb`
**Tests:** Output, Config, SPI, GLCD

Moves from I2C to **SPI** for a color graphical LCD, with pin mappings for `GLCD_DC`,
`GLCD_CS`, `GLCD_RESET`, `GLCD_DO` (data-out), and `GLCD_SCK` on `PORTC`. Supports
toggling between hardware and software SPI via `#DEFINE SSD1331_HardwareSPI`. Draws the
same lines/boxes/circles/text as the I2C demos, proving the GLCD library's drawing API
is transport-agnostic (I2C vs. SPI).

> **Note:** the filename says `ILI9341`, but the code itself sets
> `#define GLCD_TYPE GLCD_TYPE_SSD1331` and the header text describes an SSD1331 panel —
> worth double-checking which physical display this file is actually meant to drive
> before wiring it up.

## 240 — `240_ccppwm_discovery.gcb`
**Tests:** Output, Config, USART, PWM

A diagnostic/bring-up aid rather than an end-user demo: turns hardware CCP1 **Fixed
Mode PWM** on and off (`PWMOn`/`PWMoff`) with PPS routing all four `PORTB` LED pins to
`CCP1`, and prints guidance over serial (e.g. "compare `CCPCONCache` to `CCP1CON`") to
help diagnose why a PWM signal might not be appearing — useful when bringing up PWM on
new hardware.

## 241 — `241_use_pinIO_to_control_led_brightness.gcb`
**Tests:** Output

The crudest brightness-control technique: bit-bangs `LEDD3` directly with `NOT` inside a
tight loop padded with `NOP`s to approximate a 38 kHz toggle rate — no PWM peripheral or
library call at all, just raw pin timing.

## 242 — `242_use_pulseout_to_control_led_brightness.gcb`
**Tests:** Output

Same brightness goal as 241, but using the `PulseOut` primitive (`PulseOut LEDD3, 12 us`)
to generate a single timed pulse per call — a built-in instruction replacing the manual
NOP-padded loop.

## 243 — `243_use_pwmout_to_control_led_brightness.gcb`
**Tests:** Output

Steps up to the `PWMOut` software-PWM library call (`PWMOut 1, 127, 4`) — a
higher-level abstraction capped around 4 kHz, generating a duty-cycle-controlled output
without touching a hardware CCP module.

## 244 — `244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.gcb`
**Tests:** Output, Config, USART, PWM

The "production" counterpart to the 240 discovery demo: enables true **hardware** CCP
Fixed Mode PWM (`#DEFINE PWM_FREQ 38`, `#DEFINE PWM_DUTY 50`, `PWMOn`) for a fixed 38 kHz
/ 50% signal for a set duration, with register-state reporting over serial to confirm
it's actually running.

## 245 — `245_use_pwm_via_ccp_and_adc_to_control_led_brightness.gcb`
**Tests:** Output, Config, ADC, PWM

Combines ADC and hardware PWM: `HPWM 1, 38, ADCVal` continuously updates the CCP1 PWM
duty cycle from a live potentiometer reading, so LED brightness (or motor speed) tracks
the pot in real time — variable-mode hardware PWM, as opposed to 244's fixed duty cycle.

## 250 — `250_using_external_interrupt_to_raise_an_event.gcb`
**Tests:** Output, Input, Config

The external interrupt input, **INT0**: `PORTA.4` is routed via PPS (`INT0PPS`) to the
interrupt manager, configured for a falling edge (`INT0EDG = 0`). The ISR
(`On Interrupt ExtInt0 Call InterruptHandler`) toggles `LEDD2` asynchronously, while the
main loop independently toggles `LEDD3` every 100 ms via a plain `Wait` — contrasting a
hardware-interrupt-driven output against a software-timed polled one on the same device.

> **Note:** the port-map diagram in this file labels `PORTB.0` as "INT", but the
> interrupt is actually sourced from `PORTA.4` via PPS. `#DEFINE INT0 PORTB.0` and
> `#DEFINE LEDD0 PORTB.0` both still point at the same pin; that constant isn't
> referenced elsewhere in the code, but it's worth checking against your actual board
> wiring.

## 251 — `251_using_an_interrupt_control_an_leds_brightness.gcb`
**Tests:** Output, Config, Timer, PWM

Generates **software PWM entirely inside a Timer0-overflow ISR**
(`On Interrupt Timer0Overflow Call PWMHandler`): a free-running `PWMCounter` (0–99) is
compared against a `MotorSpeed` value each interrupt to decide whether the output pin is
high or low, producing a variable-duty waveform without any CCP hardware — framed as
driving a motor's speed, but applicable directly to LED brightness.

## 260 — `260_showing_datablock_to_LCD.gcb`
**Tests:** Output, Config, USART, EEPROM

Demonstrates **program-memory `DATA` blocks** alongside `EEPROM` blocks as two different
ways to store fixed reference data. Uses the `@` operator to get a data block's address
and `ProgramRead` to read values back out of program memory (PROGMEM), printing
addresses and values to both the LCD and the serial terminal — useful for storing
lookup tables, calibration constants, or text that shouldn't live in EEPROM.

---

## Overall arc

```
Raw pin I/O (010-030)
   -> Bit rotation (040)
      -> ADC: 8-bit then 10-bit (050-060)
         -> Debounced digital input (070)
            -> Config-fuse pin repurposing: MCLRE (080)
               -> Full integration: switch + ADC + direction (090)
                  -> Output peripherals: PPS UART + RAM/string test (100),
                     parallel LCD (105)
                     -> Hardware Timer0: interrupt-driven (110) vs. polled (120)
                        -> Non-volatile storage: runtime EEPROM (140),
                           compile-time EEPROM tables (150)
                              -> Build-safety check: chip-match verification (160)
                                 -> I2C bus scanning (170)
                                    -> I2C GLCD graphics: SSD1306 @ 64x32/128x64/128x32
                                       (180/190/200), sprites (210), voltmeter gauge (220),
                                       BMP image rendering (225)
                                       -> SPI GLCD graphics (230)
                                          -> PWM: discovery/diagnostics (240),
                                             bit-banged/PulseOut/PWMOut software
                                             techniques (241-243), hardware CCP
                                             fixed (244) and ADC-variable (245) PWM
                                             -> External interrupt: INT0 via PPS (250)
                                                -> Interrupt-driven software PWM (251)
                                                   -> Program-memory DATA/EEPROM
                                                      blocks (260)
```

Every demo that drives an LED depends on **VDDIO2** being correctly supplied, since the
LED pins (`PORTB.0-3`) sit on that secondary power domain on this device.