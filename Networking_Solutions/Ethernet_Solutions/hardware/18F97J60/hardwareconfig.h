//--------------------------------------------------------------------------------------------------------------------------------
// Hardware configuration - Microchip PICDEM.net 2 (PIC18F97J60)
//
// Everything that belongs to the board: configuration, supply voltage, pins, LCD and serial port. Network addresses and
// test settings stay in the test program.
//
// A test selects this board with   #option IncludePath "..\libraries;..\hardware\18F97J60"
//                         and      #include <hardwareconfig.h>   (before the libraries)
//
// The program defines the serial speed before including this file, e.g.   #define USART_BAUD_RATE 115200
// (a board default could not be overridden without a compiler warning), and the chip and clock - #Chip and #Config
// are not conditional, so they cannot be chosen here:
//   #Chip 18F97J60, 25         #Config FOSC = HS        25 MHz, straight from the crystal
//   #Chip 18F97J60, 41.667     #Config FOSC = HSPLL     41.667 MHz, the crystal through the PLL (/ 3 x 5)
//
// Board: PIC18F97J60 (100-pin), 25 MHz crystal, 3.3 V. Pins from Microchip's TCP/IP stack (HWP PICDN2_ETH97.h,
//        HWP PICDN2_ENC28.h): LED0-LED7 on RJ0-RJ7 (on when high), buttons S5 S4 S3 S2 on RB3 RB2 RB1 RB0 (low when
//        pressed), potentiometer AN2, TC1047A temperature sensor AN3, 16x2 LCD with 8-bit data on PORTE and E RH0,
//        RW RH1, RS RH2; 25LC256 EEPROM on SPI1 (CS RD7); EUSART1 TX RC6, RX RC7 to the RS232 driver; two Ethernet
//        ports: J1 built into the PIC, J2 an ENC28J60 on SPI1 (CS RD3, RESET RD2 through JP5)
//
//@author    Evan R. Venn
//@licence   GPL
//@date      02/11/2026
//
// Changes:
//   02/11/2026  First version: chip, clock, LCD, LEDs, buttons, serial port (LCD proven with PICDEMNET2_LCD.gcb)
//   02/11/2026  Ethernet: ENC28J60 pins, RX polarity swap pin (ENC28J60_RX_SWAP, RG0), device names enc28j60-6, report; the program includes
//               the driver (two ports)
//   04/11/2026  USART_BAUD_RATE only when the program uses the serial port: the check moved to the stack
//--------------------------------------------------------------------------------------------------------------------------------

// ----- Chip

    // The program's #Chip sets the clock. BOARD_PLL: 1 = switch the PLL on (BoardInit). BOARD_MHZ: the clock in whole
    // MHz for byte values, as ChipMHz 41.667 is not a whole number
    #script
        BOARD_PLL = 2
        if ChipMHz = 25 then
            BOARD_PLL = 0
            BOARD_MHZ = 25
        end if
        if ChipMHz = 41.667 then
            BOARD_PLL = 1
            BOARD_MHZ = 41
        end if
        if BOARD_PLL = 2 then
            Error Clock - the program must use #Chip 18F97J60, 25 (FOSC HS) or 41.667 (FOSC HSPLL)
        end if
    #endscript
    #Config FOSC2 = ON                  // the clock chosen by FOSC (not the internal oscillator)
    #Config WDT = OFF
    #Config XINST = OFF
    #Config STVR = ON
    #Config FCMEN = OFF
    #Config IESO = OFF
    #Config DEBUG = OFF
    #Config CP0 = OFF
    #Config ETHLED = ON                 // RA0 / RA1 are the Ethernet link and activity LEDs

// ----- Board I/O

    #define BOARD_POT    AN2                    // potentiometer
    #define BOARD_TEMP   AN3                    // TC1047A: 500 mV at 0 C, 10 mV per C
    #define BOARD_LEDS   LATJ                   // LED0-LED7, on when high
    #define BOARD_BUTTON0 PortB.3               // S5, low when pressed
    #define BOARD_BUTTON1 PortB.2               // S4
    #define BOARD_BUTTON2 PortB.1               // S3
    #define BOARD_BUTTON3 PortB.0               // S2
    #define BOARD_EEPROM_CS PortD.7             // 25LC256 on SPI1, not used: kept deselected
    // Built-in port TPIN+/- polarity swap (Rev 6): ENC28J60_J60Driver.h swaps it while linked and nothing received
    #define ENC28J60_RX_SWAP PortG.0

// ----- LCD (GCBASIC lcd.h): 8-bit data on PORTE

    #define LCD_IO 8
    #define LCD_DATA_PORT PORTE
    #define LCD_Enable PortH.0
    #define LCD_RW PortH.1
    #define LCD_RS PortH.2

// ----- Start-up

    // Hardware start-up: the clock (at 41.667 MHz the PLL is switched on here; until then the chip runs at 25 MHz),
    // the LEDs (outputs, off), the button pull-ups and the EEPROM chip select
    #startup BoardInit, 85

    Sub BoardInit
        #if BOARD_PLL = 1
            // OSCTUNE: PLLEN on, PLL prescaler / 3 (PPRE 0), no postscaler (PPST0 0)
            OSCTUNE = 0x40
            // PLL lock time (up to 2 ms)
            Wait 2 ms
        #endif
        BOARD_LEDS = 0
        Dir PortJ Out
        // PORTB pull-ups for the buttons
        RBPU = 0
        Set BOARD_EEPROM_CS On
        Dir BOARD_EEPROM_CS Out
    End Sub

// ----- Supply voltage

    // The PIC18F97J60 runs at 3.3 V only
    #define SYSTEM_VDD_MV 3300

// ----- Serial port

    // The program defines USART_BAUD_RATE when it uses the serial port (serial console, serial to UDP); without it the
    // serial port is not set up. The stack checks that a program using the serial port defines it
    #define USART_BLOCKING

    // SerialRxBuffer.h reads the receive register as RC1REG; on this chip it is named RCREG1. Without this an RC1REG
    // would compile as a plain RAM variable (no warning) and nothing would be received
    #define RC1REG RCREG1

// ----- ENC28J60 (the second Ethernet port, J2): SPI1, shared with the EEPROM. RESET through JP5 to RD2 (JP5 open:
// not connected, then the driver's pulse on RD2 does nothing). JP9 (ENC28J60 INT to RB0, Button 3) should be open

    #define ENC28J60_CS     PortD.3
    #define ENC28J60_RESET  PortD.2
    #define ENC28J60_SCK    PortC.3
    #define ENC28J60_DO     PortC.5                 // SDO1 to ENC28J60 SI
    #define ENC28J60_DI     PortC.4                 // SDI1 from ENC28J60 SO

// ----- Device names (MQTT, DHCP)

    // Each board is its own device to Home Assistant: these names match HADiscovery.json in this folder. Both
    // Ethernet ports use them: a program runs one port
    #define MQTT_CLIENT_ID "enc28j60-6"
    #define MQTT_STATUS_TOPIC "enc28j60-6/status"
    #define MQTT_TOPIC_VALUES "enc28j60-6/values"
    #define MQTT_TOPIC_COMMAND "enc28j60-6/led/+"
    #define MQTT_COMMAND_PREFIX "enc28j60-6/led/"

    // Name in the router's client list (DHCP option 12)
    #define DHCP_HOSTNAME "enc28j60-6"

// ----- Ethernet driver

    // The board has two Ethernet ports, so the program includes the driver after this file: ENC28J60_J60Driver.h
    // for the built-in port (J1), ENC28J60_Driver.h for the ENC28J60 (J2)

// ----- Report

Sub HardwarePrintConfig
    // The host name first: the name the router lists (DHCP), also the MQTT device
    CONSOLE_Print DHCP_HOSTNAME : CONSOLE_Print " PICDEM.net 2 PIC18F97J60 "
    #if BOARD_PLL = 0
        CONSOLE_Print "25 MHz, "
    #endif
    #if BOARD_PLL = 1
        CONSOLE_Print "41.667 MHz, "
    #endif
    CONSOLE_Print "VDD 3V3"
    CONSOLE_CRLF
End Sub
