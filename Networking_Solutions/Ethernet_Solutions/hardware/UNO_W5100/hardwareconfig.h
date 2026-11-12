//--------------------------------------------------------------------------------------------------------------------------------
// Arduino Uno (ATmega328P, 16 MHz, 5 V) with the Arduino Ethernet shield: a WIZnet W5100 and a microSD card on the SPI
//
// Pins
//   SPI      SCK B.5 (D13), MOSI B.3 (D11), MISO B.4 (D12) - shared by the W5100 and the SD card (the shield's ICSP header)
//   W5100    chip select B.2 (D10), the AVR's SS pin
//   SD card  chip select D.4 (D4)
//   UART     TX D.1 (D1), RX D.0 (D0): the Uno's USB serial port (COM32 on the test PC), 9600 8N1
//   Outputs  D.2 (D2), D.3 (D3), D.5 (D5), D.6 (D6), D.7 (D7): the web page's toggles. Bits 0, 1 (serial) and 4 (SD card
//            chip select) are not toggled
// Programming: use.ini's "Arduino UNO @115200" programmer (avrdude, the Uno's bootloader, port COM32). Opening the
// serial port resets the Uno.
//
// The program defines USART_BAUD_RATE before including this file (9600: at 16 MHz the AVR's USART is 0.2 % out).
//
//@author    Evan R. Venn
//@licence   GPL
//@date      12/11/2026
//
// Changes:
//   09/11/2026  First version
//   12/11/2026  ReserveHighProg 256 (was OPTIBOOT, 1,024 words): the Uno's Optiboot 4.4 is 512 bytes at 0x7E00
//--------------------------------------------------------------------------------------------------------------------------------

    #Chip mega328p, 16
    #option ReserveHighProg 256    // the Uno's bootloader at the top of the flash: 256 words (512 bytes) kept free

    #define USART_BLOCKING

// ----- W5100 (W5100_Driver.h)

    #define WIZ_CS          PortB.2     // B.2 (D10)
    #define WIZ_SPI_SPEED   MasterFast  // Fosc / 4, 4 MHz

// ----- SD card (sd_card.h, sd_card_avr.h)

    #define SDC_SCK         PortB.5     // B.5 (D13)
    #define SDC_DO          PortB.3     // B.3 (D11), MOSI: to the card's DI
    #define SDC_DI          PortB.4     // B.4 (D12), MISO: from the card's DO
    #define SDC_CS          PortD.4     // D.4 (D4): the card's chip select
    #define SDC_SS          PortB.2     // B.2 (D10), the AVR's SS pin: an output in master mode (the W5100's chip select)
    #define SDC_SPI_SLOW    MasterSlow  // start-up: Fosc / 64, 250 kHz (the card needs 100 to 400 kHz)
    #define SDC_SPI_FAST    MasterFast  // data: Fosc / 4, 4 MHz

// ----- The page's toggles: PORTD bits that may be toggled (D.2, D.3, D.5, D.6, D.7)

    #define TOGGLE_MASK 0xEC

Sub BoardInit
    // Both chip selects high before anything uses the SPI, then the SPI pins and the toggle outputs (low)
    Dir PortB.2 Out
    Set PortB.2 On
    Dir PortD.4 Out
    Set PortD.4 On
    Dir PortB.5 Out
    Dir PortB.3 Out
    Dir PortB.4 In
    Dir PortD.2 Out
    Dir PortD.3 Out
    Dir PortD.5 Out
    Dir PortD.6 Out
    Dir PortD.7 Out
    PortD = PortD And 0x13              // the toggle bits (TOGGLE_MASK 0xEC) low
End Sub
