//--------------------------------------------------------------------------------------------------------------------------------
// Hardware configuration - Microchip PICDEM.net (original, PIC16F877 + RTL8019AS)
//
// Everything that belongs to the board: chip and clock, configuration, pins, LCD and the RTL8019AS bus. Network addresses
// and test settings stay in the program.
//
// A program selects this board with   #option IncludePath "..\libraries;..\hardware\16f877"
//                            and      #include <hardwareconfig.h>
//
// Board: PIC16F877, 19.6608 MHz crystal, 5 V. Pins from Microchip's TCP/IP Stack 3.75 (Include\Compiler.h, PICDEMNET;
//        Source\RTL8019AS.c): RTL8019AS data bus PORTD, address RB0-RB4, IOR RE0, IOW RE1, RESET RE2; LCD 4-bit on
//        RD0-RD3 with RS RD4, RW RD5, E RA5 (it shares PORTD with the RTL8019AS: the RTL8019AS only drives PORTD while
//        IOR is low); user LEDs RA2, RA3, system LED RA4 (found with PICDEMNET_LEDS.gcb); switch RB5;
//        potentiometers AN0, AN1; 24LC256 on I2C (RC3/RC4, not used); USART RC6/RC7. D1-D3 are the RTL8019AS's
//        link, receive and transmit LEDs
//
//@author    Evan R. Venn
//@licence   GPL
//@date      02/11/2026
//
// Changes:
//   02/11/2026  First version
//   02/11/2026  LCD write only (LCD_NO_RW, RW held low), as Microchip's LCDBlocking.c: the LCD did not initialise
//   02/11/2026  LEDs named: BOARD_LED0 RA2, BOARD_LED1 RA3 (user), BOARD_SYS_LED RA4 (system); all on when low
//   02/11/2026  PORTB pull-ups on (NOT_RBPU = 0): the switch on RB5 did not respond
//--------------------------------------------------------------------------------------------------------------------------------

// ----- Chip

    #Chip 16F877, 19.6608
    #Config FOSC = HS, WDTE = OFF, PWRTE = ON, LVP = OFF, CP = OFF

// ----- Board I/O

    #define BOARD_POT0   AN0                    // potentiometer
    #define BOARD_POT1   AN1                    // potentiometer
    #define BOARD_SWITCH PortB.5                // push button
    // All three LEDs light when their pin is low (user, board test)
    #define BOARD_LED0   PortA.2                // user LED
    #define BOARD_LED1   PortA.3                // user LED
    #define BOARD_SYS_LED PortA.4               // system LED (open drain)

// ----- LCD (GCBASIC lcd.h): 4-bit on RD0-RD3, shared with the RTL8019AS data bus

    #define LCD_IO 4
    #define LCD_DB4 PortD.0
    #define LCD_DB5 PortD.1
    #define LCD_DB6 PortD.2
    #define LCD_DB7 PortD.3
    #define LCD_RS PortD.4
    #define LCD_Enable PortA.5
    // RW (RD5) is held low by the board: written only, with delays, as Microchip's LCDBlocking.c does on this board.
    // RD5 is also RTL8019AS data bit 5, so the NIC routines must leave it an output, low, after each access
    #define LCD_NO_RW
    #define BOARD_LCD_RW PortD.5
    // The slowest write timing (100 us per write): the board's old LCD module
    #define LCD_SPEED SLOW



// ----- RTL8019AS bus

    #define NIC_DATA     PORTD                  // data bus, input except while writing
    #define NIC_DATA_DIR TRISD
    #define NIC_ADDR     PORTB                  // RB0-RB4 address, RB5-RB7 inputs
    #define NIC_ADDR_DIR TRISB
    #define NIC_IOR      PortE.0                // read strobe, low active
    #define NIC_IOW      PortE.1                // write strobe, low active
    #define NIC_RESET    PortE.2                // high active

// ----- Start-up

    // Hardware start-up: the RTL8019AS strobes inactive before anything else, the LED pins outputs
    #startup BoardInit, 85

    Sub BoardInit
        Set NIC_IOR On
        Set NIC_IOW On
        Set NIC_RESET Off
        Dir NIC_IOR Out
        Dir NIC_IOW Out
        Dir NIC_RESET Out
        NIC_ADDR_DIR = 0xE0
        NIC_DATA_DIR = 0xFF
        // PORTB pull-ups: the switch on RB5 has none of its own (Microchip's RTL8019AS.c sets RBPU too)
        NOT_RBPU = 0
        // LCD RW low (write only)
        Set BOARD_LCD_RW Off
        Dir BOARD_LCD_RW Out
        // LEDs off (high)
        Set BOARD_LED0 On
        Set BOARD_LED1 On
        Set BOARD_SYS_LED On
        Dir BOARD_LED0 Out
        Dir BOARD_LED1 Out
        Dir BOARD_SYS_LED Out
    End Sub
