# PIC18FxxQ35 GCBASIC Demo Series — Overview

This document describes a series of GCBASIC demonstration programs written for the
**PIC18FxxQ35** (Q35 family), progressing from basic digital I/O through ADC, debounced
input, UART/LCD output, RAM/string handling, hardware timers, and external interrupts.

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

| # | Demo | Output | Input | Config | ADC | RAM | Timer | USART |
|---|------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 010 | hello_world | ✓ | | | | | | |
| 020 | blink | ✓ | | | | | | |
| 030 | blink_another_way | ✓ | | | | | | |
| 040 | rotate_the_leds | ✓ | | | | | | |
| 050 | show_a2d_value_on_leds | ✓ | | | ✓ | | | |
| 060 | variable_rotate_the_leds | ✓ | | | ✓ | | | |
| 070 | debounce_the_switch | ✓ | ✓ | | | | | |
| 080 | using_the_reset_switch_as_an_input | ✓ | ✓ | ✓ | | | | |
| 090 | reversible_leds_with_variable_delay | ✓ | ✓ | | ✓ | | | |
| 100 | ...to_serial_terminal | ✓ | ✓ | ✓ | ✓ | ✓ | | ✓ |
| 105 | ...to_LCD | ✓ | ✓ | ✓ | ✓ | | | |
| 110 | ...timer_overflow_event | ✓ | ✓ | ✓ | | | ✓ | |
| 120 | ...8bit_timer0 | ✓ | ✓ | ✓ | | | ✓ | |
| — | external_interrupt_INT0 | ✓ | ✓ | ✓ | | | | |

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

## External Interrupt — `..._external_interrupt_INT0.gcb`
**Tests:** Output, Input, Config

Demonstrates the external interrupt input, **INT0**: `PORTA.4` is routed via PPS
(`INT0PPS`) to the interrupt manager, configured for a falling edge (`INT0EDG = 0`). The
ISR (`On Interrupt ExtInt0 Call InterruptHandler`) toggles `LEDD2` asynchronously, while
the main loop independently toggles `LEDD3` every 100 ms via a plain `Wait` — contrasting
a hardware-interrupt-driven output against a software-timed polled one on the same
device.

> **Note:** the port-map diagram in this file labels `PORTB.0` as "INT", but the
> interrupt is actually sourced from `PORTA.4` via PPS. `#DEFINE INT0 PORTB.0` and
> `#DEFINE LEDD0 PORTB.0` both still point at the same pin; that constant isn't
> referenced elsewhere in the code, but it's worth checking against your actual board
> wiring.

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
                     -> Hardware Timer0: interrupt-driven (110)
                        vs. polled (120)
                           -> External interrupt: INT0 via PPS
```

Every demo that drives an LED depends on **VDDIO2** being correctly supplied, since the
LED pins (`PORTB.0-3`) sit on that secondary power domain on this device.
