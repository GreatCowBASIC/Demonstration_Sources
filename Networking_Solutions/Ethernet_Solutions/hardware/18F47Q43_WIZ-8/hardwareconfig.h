//--------------------------------------------------------------------------------------------------------------------------------
// Hardware configuration - PIC18F47Q43 with a WIZnet W5200 or W5500 module
//
// The 18F47Q43 rig's chip, configuration, PPS and serial port, with the WIZnet module on the ENC28J60's SPI pins.
// Network addresses and test settings stay in the program.
//
// A program selects this board with   #option IncludePath "..\libraries;..\hardware\18F47Q43_WIZ"
//                             and     #include <hardwareconfig.h>   (before the libraries)
//
// The program defines before including this file:
//   USART_BAUD_RATE        serial speed, e.g. 115200
//   WIZ_CHIP               optional: 5200 or 5500 compiles that chip only; left out, the chip is found at start-up
//
// Board: PIC18F47Q43 (40-pin), 64 MHz internal oscillator; module CS RA5, RESET RB4;
//        SPI1 SCK RB1, SDI RB0 (from the module's MISO), SDO RB3 (to the module's MOSI); W5200 PWDN to GND;
//        UART1 TX RC6 (and RC5), RX RC7
//
//@author    Evan R. Venn
//@licence   GPL
//@date      03/11/2026
//
// Changes:
//   03/11/2026  First version, from hardware\18F47Q43\hardwareconfig.h; SPI MasterSlow (1 MHz): at Master (4 MHz)
//                    the board test read single bits wrong
//   03/11/2026  Clock 4 MHz for a test, then back to 64 MHz: the "read errors" were the socket states while the link was down
//   03/11/2026  SPI Master (4 MHz) tried: 30 of 50 pages failed; back to MasterSlow (1 MHz)
//   03/11/2026  Clock 32 MHz (was 64 MHz), MasterSlow then 0.5 MHz; another W5200 module on short wires
//   03/11/2026  After the board was rewired (the read errors were the wiring): 64 MHz and SPI Master (4 MHz) again,
//                    50 of 50 dashboards, 40 of 40 /c and /s; MasterFast (8 MHz) tried: 43 of 50, back to Master
//   03/11/2026  Device name wiz5200-8 (was enc28j60-8): MQTT client ID and topics, DHCP host name
//   04/11/2026  USART_BAUD_RATE only when the program uses the serial port: the check moved to the stack
//   04/11/2026  WIZ_CHIP optional (WIZ_Driver.h finds the chip when it is left out); the report shows the build's choice
//--------------------------------------------------------------------------------------------------------------------------------

// ----- Chip

    #Chip 18F47Q43, 64
    #Config FEXTOSC = OFF               // no external oscillator
    #Config RSTOSC = HFINTOSC_64MHZ     // internal oscillator, 64 MHz
    #Config MCLRE = EXTMCLR             // MCLR pin is reset (programmer)
    #Config WDTE = OFF
    #Config LVP = OFF
    #Config BOREN = OFF
    #Config STVREN = ON
    #Config XINST = OFF
    #Config PPS1WAY = OFF               // PPS may be set more than once

    // No I2C1 baud rate check message from the compiler (I2C is not used on this board)
    #DEFINE MASKI2C1BAUDCHECKMESSAGE

// ----- Supply voltage

    // The WIZnet modules are 3.3 V devices
    #define SYSTEM_VDD_MV 3300

// ----- The module

    #define WIZ_CS     PortA.5
    #define WIZ_RESET  PortB.4
    #define WIZ_SCK    PortB.1
    #define WIZ_DO     PortB.3                  // to the module's MOSI
    #define WIZ_DI     PortB.0                  // from the module's MISO

    // SPI speed: Master, 4 MHz at 64 MHz. Measured on this board after the rewiring (03/11/2026), 50 dashboards each:
    //   MasterSlow  1 MHz   50 of 50, dashboard 0.26 s
    //   Master      4 MHz   50 of 50, dashboard 0.24 s
    //   MasterFast  8 MHz   43 of 50 (bit errors: pages too long, too short or no answer) - do not use
    // The page time is the PIC building the page, not SPI: more than 4 MHz gains next to nothing
    #define WIZ_SPI_SPEED Master

    // Hardware start-up. Only one #startup is allowed in a program, so all early set-up is here
    #startup PPSInit, 85

    Sub PPSInit
        U1RXPPS = 0x17          // RC7 is UART1 RX
        RC6PPS = 0x20           // RC6 is UART1 TX
        RC5PPS = 0x20           // RC5 is UART1 TX (user's terminal)

        SPI1SCKPPS = 0x09       // RB1 is SPI1 SCK in
        RB1PPS = 0x31           // RB1 is SPI1 SCK out
        SPI1SDIPPS = 0x08       // RB0 is SPI1 SDI
        RB3PPS = 0x32           // RB3 is SPI1 SDO

        Dir PORTD Out
    End Sub

// ----- Serial port

    // The program defines USART_BAUD_RATE when it uses the serial port (serial console, serial to UDP); without it the
    // serial port is not set up. The stack checks that a program using the serial port defines it
    #define USART_BLOCKING

// ----- Device names (MQTT, DHCP)

    // A device of its own to Home Assistant and the router (the ENC28J60 18F rig is enc28j60-4)
    #define MQTT_CLIENT_ID "wiz5200-8"
    #define MQTT_STATUS_TOPIC "wiz5200-8/status"
    #define MQTT_TOPIC_VALUES "wiz5200-8/values"
    #define MQTT_TOPIC_COMMAND "wiz5200-8/led/+"
    #define MQTT_COMMAND_PREFIX "wiz5200-8/led/"
    #define DHCP_HOSTNAME "wiz5200-8"

// ----- Ethernet driver

    #include <WIZ_Driver.h>

// ----- Report

Sub HardwarePrintConfig
    // Before WIZ_Init: the build's choice (the chip found is in ShowWIZStatus)
    CONSOLE_Print DHCP_HOSTNAME : CONSOLE_Print " PIC18F47Q43 " : CONSOLE_Number ChipMHz : CONSOLE_Print " MHz, "
    #if WIZ_CHIP = 0
        CONSOLE_Print "W5200 or W5500 (found at start-up)"
    #endif
    #if WIZ_CHIP <> 0
        CONSOLE_Print "W" : CONSOLE_Number WIZ_CHIP
    #endif
    CONSOLE_CRLF
End Sub
