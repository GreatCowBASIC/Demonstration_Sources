//--------------------------------------------------------------------------------------------------------------------------------
// Hardware configuration - PIC16F18877 test rig with ENC28J60
//
// Everything that belongs to the board: chip and clock, configuration, supply voltage, pins, PPS, serial port and
// SPI speed. Network addresses and test settings stay in the test program.
//
// A test selects this rig with   #option IncludePath "..\libraries;..\hardware\16f18877"
//                        and     #include <hardwareconfig.h>   (before the libraries)
//
// The program defines the serial speed before including this file, e.g.   #define USART_BAUD_RATE 115200
// (a board default could not be overridden without a compiler warning).
//
// Board: ENC28J60 CS RA5, RESET RB4; SPI SCK RB1, SDI RB0 (from ENC28J60 SO), SDO RB3 (to ENC28J60 SI);
//        UART TX RC6 (and RC5), RX RC7; activity LED RE0
//
//@author    Evan R. Venn
//@licence   GPL
//@date      01/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  Clock 32 MHz (was 16 MHz); SPI MasterFast (Fosc/4 = 8 MHz) - works only with the scope probes off the
//                    SPI lines (with them, use Master, Fosc/16 = 2 MHz)
//   01/11/2026  Activity LED moved from RD3 to RE0 (RD3 is one of the PORTD toggles); named ENC28J60_ACTIVITY_LED.
//                    RigButton (RA4) removed: never used
//   01/11/2026  CON_ names renamed CONSOLE_
//   01/11/2026  MQTT names enc28j60-3/... (client id, topics), matching HADiscovery.json
//   01/11/2026  DHCP host name enc28j60-3, printed at start-up in place of "Rig"
//   01/11/2026  Includes the Ethernet driver ENC28J60_Driver.h (was in ENC28J60_Stack.h)
//   04/11/2026  USART_BAUD_RATE only when the program uses the serial port: the check moved to the stack
//--------------------------------------------------------------------------------------------------------------------------------

// ----- Chip

    #Chip 16f18877, 32
    #Config MCLRE = On
    #Config WDT = Off
    #Config LVP = Off
    #Config BOREN = Off
    #Config STVREN = On

// ----- Supply voltage

    // Supply voltage of the microcontroller in mV - STATE THIS FOR THE BOARD.
    // The ENC28J60 is a 3.3 V device: its inputs are 5 V tolerant, but its SO output only reaches 3.3 V.
    // At 5V0 the pin reading SO is switched to TTL input levels (a 1 from 2.0 V) instead of the
    // Schmitt trigger default (a 1 from 0.8 VDD = 4.0 V at 5 V), which would not see the ENC28J60's 1s.
    #define SYSTEM_VDD_MV 3300                      // test rig measured 3.3 V by the programmer, 28/10/2026

    // Sets SYSTEM_VDD_3V3 or SYSTEM_VDD_5V0 for #ifdef tests; any other supply stops the compile
    #script
        if SYSTEM_VDD_MV >= 3000 then
            if SYSTEM_VDD_MV <= 3600 then
                SYSTEM_VDD_3V3 = 1
            end if
        end if
        if SYSTEM_VDD_MV >= 4500 then
            if SYSTEM_VDD_MV <= 5500 then
                SYSTEM_VDD_5V0 = 1
            end if
        end if
        if nodef(SYSTEM_VDD_3V3) then
            if nodef(SYSTEM_VDD_5V0) then
                Error Unsupported supply voltage - use 3000 to 3600 mV for 3V3, 4500 to 5500 mV for 5V0
            end if
        end if
    #endscript

// ----- Pins

    #define ENC28J60_CS     PortA.5
    #define ENC28J60_RESET  PortB.4
    #define ENC28J60_SCK    PortB.1
    #define ENC28J60_DO     PortB.3                 // to ENC28J60 SI
    #define ENC28J60_DI     PortB.0                 // from ENC28J60 SO
    #define ENC28J60_DI_INLVL INLVLB0               // input level bit of ENC28J60_DI
    #define ENC28J60_ACTIVITY_LED PortE.0

    // Hardware start-up. Only one #startup is allowed in a program, so all early set-up is here
    #startup PPSInit, 85

    Sub PPSInit
        // RXPPS  = 0x14           // RC4 is EUSART RX
        RXPPS  = 0x17           // RC7 is EUSART RX
        RC6PPS = 0x10           // RC6 is EUSART TX    // Claude debugger
        RC5PPS = 0x10           // RC5 is EUSART TX    // users debug terminal
        
        SSP1CLKPPS = 0x09       // RB1 is SCK1 in
        RB1PPS = 0x14           // RB1 is SCK1 out
        SSP1DATPPS = 0x08       // RB0 is SDI1
        RB3PPS = 0x15           // RB3 is SDO1

        #ifdef SYSTEM_VDD_5V0
            ENC28J60_DI_INLVL = 0   // TTL input levels for the 3.3 V SO signal
        #endif

        Dir PORTD Out
        Dir PORTB In
        PORTB = 0
    End Sub

// ----- Serial port

    // The program defines USART_BAUD_RATE when it uses the serial port (serial console, serial to UDP); without it the
    // serial port is not set up. The stack checks that a program using the serial port defines it
    #define USART_BLOCKING
// ----- SPI

    // MasterFast is Fosc/4 = 8 MHz at 32 MHz (the ENC28J60 allows 20 MHz). It works only with the scope probes removed
    // from the SPI lines: with them connected it failed - use Master (Fosc/16 = 2 MHz) while measuring
    #define ENC_SPI_SPEED MasterFast

// ----- Device names (MQTT, DHCP)

    // Each rig is its own device to Home Assistant: these names match HADiscovery.json in this folder
    #define MQTT_CLIENT_ID "enc28j60-3"
    #define MQTT_STATUS_TOPIC "enc28j60-3/status"
    #define MQTT_TOPIC_VALUES "enc28j60-3/values"
    #define MQTT_TOPIC_COMMAND "enc28j60-3/led/+"
    #define MQTT_COMMAND_PREFIX "enc28j60-3/led/"

    // Name in the router's client list (DHCP option 12)
    #define DHCP_HOSTNAME "enc28j60-3"

// ----- Ethernet driver

    // The ENC28J60 on SPI. The chips with the controller built in (18F67J60 ...) use ENC28J60_J60Driver.h
    #include <ENC28J60_Driver.h>

// ----- Report

Sub HardwarePrintConfig
    // The host name first: the name the router lists (DHCP), also the MQTT device
    CONSOLE_Print DHCP_HOSTNAME : CONSOLE_Print " PIC16F18877 " : CONSOLE_Number ChipMHz : CONSOLE_Print " MHz, "
    #ifdef SYSTEM_VDD_5V0
        CONSOLE_Print "VDD 5V0, ENC28J60 SO input TTL"
    #endif
    #ifdef SYSTEM_VDD_3V3
        CONSOLE_Print "VDD 3V3, ENC28J60 SO input Schmitt trigger"
    #endif
    CONSOLE_CRLF
End Sub
