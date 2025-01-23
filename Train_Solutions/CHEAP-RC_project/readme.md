**CHEAP-RC project**

**Why “CHEAP-RC”?**

Cheap-RC are a translation of “Billig-RC” (the German word “Billig” means the same as Cheap, but the word “Billig” has a negative touch in this conjunction). So, I use CHEAP-RC. But “ cheap ” doesn’t mean that the system can’t do anything (quite the opposite).

To explain: The **R**adio **C**ontrol including receiver is available from China at around €20 to €25. Delivery time approx. 2 weeks. Also available from AMAZON or EBAY.

**Target area:**

This control is intended for a small entry-level locomotive (e.g. 5-inch or 7-¼ inch) (there is a Foto in the description). However, that does not mean that the control cannot also be used in really large models. In order to fit into smaller models, some components were deliberately kept small (e.g. standing resistors), without limiting versatility or making it difficult to replicate. With the exception of an 8-pin IC (SMD), only wired components are used. At 98 x 73mm, the board is quite compact despite all its options. The transmitter fits comfortably in one hand and enables the model to be controlled over a distance of several hundred meters. There is also the option of local control (with cable).

**Components of the control system:**

The entire system consists of three components.

1. A six-channel transmitter DS600
2. A six-channel receiver F-06A
3. A printed circuit board for preparing and outputting the control signals

**Possibilities of the board:**

Two analog outputs (max. 10V for e.g. motor controller), six loadable digital outputs (e.g. horn, brake, sound, etc.), a relay output, an output for a RC-Servo and a connection for the power supply of the RC receiver are available as control connections. There is also a connector for local (cable) control.

The circuit is supplied with power via the POWER input. A voltage of **+12V** or **+24V can** be connected here. This voltage can be reported back via the input (Postback / Return Voltage) on the receiver. This means that the battery voltage can also be monitored during operation. A really nice extra!

The six digital outputs each switch the operating voltage (**+12V** or **+24V**) to ground (**GND**) and can handle up to 3A. However, if there is a simultaneous and large load on these outputs, the conductor tracks must be reinforced (see control system structure).

An I2C connection is also implemented. An LCD can be connected here for status or diagnostic purposes. This interface could also be used for other peripherals.

**Reference:**

For a much more detailed description look to the PDF-File: Projekt Cheap-RC english.pdf.

**Summary:**

I hope that reading this was interesting and that it has perhaps inspired one or more people to build this control system or something similar. Approaching such projects is not “rocket science”. I am happy to answer any questions (or criticism or suggestions).

Hans-Joachim (Hajo) Kaps

Chairman of Dampfbahn Leverkusen e. V.

[Hajo AT Arenka.de](mailto:Hajo AT Arenka.de)

<https://www.Dampfbahn-Leverkusen.com>

