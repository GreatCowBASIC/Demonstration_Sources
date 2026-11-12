//--------------------------------------------------------------------------------------------------------------------------------
// Hardware configuration - Olimex PIC-WEB (PIC18F67J60, Ethernet built in)
//
// Everything that belongs to the board: configuration, supply voltage, pins, serial port and the Ethernet driver.
// Network addresses and test settings stay in the test program.
//
// A test selects this board with   #option IncludePath "..\libraries;..\hardware\18F67J60"
//                         and      #include <hardwareconfig.h>   (before the libraries)
//
// The program defines the serial speed before including this file, e.g.   #define USART_BAUD_RATE 115200
// (a board default could not be overridden without a compiler warning), and the chip and clock - #Chip and #Config
// are not conditional, so they cannot be chosen here:
//   #Chip 18F67J60, 25         #Config FOSC = HS        25 MHz, straight from the crystal
//   #Chip 18F67J60, 41.667     #Config FOSC = HSPLL     41.667 MHz, the crystal through the PLL (/ 3 x 5)
//
// Board: PIC18F67J60 (64-pin), 25 MHz crystal (the Ethernet module needs it; the CPU runs at 25 MHz or, through the
//        PLL, 41.667 MHz), 3.3 V; potentiometer on AN8, 10K thermistor on AN9, red status LED on RB4, button on RB0;
//        RJ45 LEDs on RA0 / RA1 driven by the Ethernet module; EUSART1 TX RC6, RX RC7 to the RS232 driver; ICSP
//
//@author    Evan R. Venn
//@licence   GPL
//@date      02/11/2026
//
// Changes:
//   01/11/2026  First version: the Olimex PIC-WEB (PIC18F67J60 at 25 MHz, built-in Ethernet, EUSART1)
//   02/11/2026  41.667 MHz: HSPLL, PLL on at start-up (25 MHz / 3 x 5)
//   02/11/2026  Chip and clock set by the program (#Chip 18F67J60, 25 or 41.667 with FOSC HS or HSPLL)
//   02/11/2026  Board I/O: BOARD_POT, BOARD_TEMP (10K thermistor), BOARD_LED (RB4, on when low), BOARD_BUTTON
//   04/11/2026  USART_BAUD_RATE only when the program uses the serial port: the check moved to the stack
//--------------------------------------------------------------------------------------------------------------------------------

// ----- Chip

    // The program's #Chip sets the clock. The Ethernet module uses the 25 MHz crystal directly, whatever the CPU clock.
    // BOARD_PLL: 1 = switch the PLL on (ClockInit). BOARD_MHZ: the clock in whole MHz for byte values (the /s page),
    // as ChipMHz 41.667 is not a whole number
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
            Error Clock - the program must use #Chip 18F67J60, 25 (FOSC HS) or 41.667 (FOSC HSPLL)
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

    #define BOARD_POT    AN8                    // potentiometer
    #define BOARD_TEMP   AN9                    // 10K NTC thermistor (B 4100) from VDD, 10K to ground; as Olimex's demo
    #define BOARD_LED    PortB.4                // red status LED, on when low
    #define BOARD_LED_LAT LATB.4
    #define BOARD_BUTTON PortB.0                // button, low when pressed

    // Hardware start-up: the clock (at 41.667 MHz the PLL is switched on here; until then the chip runs at 25 MHz) and
    // the LED and button pins
    #startup ClockInit, 85

    Sub ClockInit
        #if BOARD_PLL = 1
            // OSCTUNE: PLLEN on, PLL prescaler / 3 (PPRE 0), no postscaler (PPST0 0)
            OSCTUNE = 0x40
            // PLL lock time (up to 2 ms)
            Wait 2 ms
        #endif
        // LED off (high) before the pin drives it
        BOARD_LED_LAT = 1
        Dir BOARD_LED Out
        Dir BOARD_BUTTON In
    End Sub

// ----- Supply voltage

    // The PIC18F67J60 runs at 3.3 V only
    #define SYSTEM_VDD_MV 3300

// ----- Serial port

    // The program defines USART_BAUD_RATE when it uses the serial port (serial console, serial to UDP); without it the
    // serial port is not set up. The stack checks that a program using the serial port defines it
    #define USART_BLOCKING

    // SerialRxBuffer.h reads the receive register as RC1REG; on this chip it is named RCREG1. Without this an RC1REG
    // would compile as a plain RAM variable (no warning) and nothing would be received
    #define RC1REG RCREG1

// ----- Device names (MQTT, DHCP)

    // Each board is its own device to Home Assistant: these names match HADiscovery.json in this folder
    #define MQTT_CLIENT_ID "enc28j60-5"
    #define MQTT_STATUS_TOPIC "enc28j60-5/status"
    #define MQTT_TOPIC_VALUES "enc28j60-5/values"
    #define MQTT_TOPIC_COMMAND "enc28j60-5/led/+"
    #define MQTT_COMMAND_PREFIX "enc28j60-5/led/"

    // Name in the router's client list (DHCP option 12)
    #define DHCP_HOSTNAME "enc28j60-5"

// ----- Ethernet driver

    // The Ethernet module built into the chip
    #include <ENC28J60_J60Driver.h>

// ----- Report

Sub HardwarePrintConfig
    // The host name first: the name the router lists (DHCP), also the MQTT device
    CONSOLE_Print DHCP_HOSTNAME : CONSOLE_Print " PIC18F67J60 "
    #if BOARD_PLL = 0
        CONSOLE_Print "25 MHz, "
    #endif
    #if BOARD_PLL = 1
        CONSOLE_Print "41.667 MHz, "
    #endif
    CONSOLE_Print "VDD 3V3, Ethernet built in"
    CONSOLE_CRLF
End Sub
