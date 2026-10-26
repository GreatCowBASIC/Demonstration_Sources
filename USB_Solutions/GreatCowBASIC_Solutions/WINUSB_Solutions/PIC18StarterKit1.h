'    Version 1.1 (2026-10-16)
'    PIC18StarterKit1.h - the basics of the Microchip PIC18F Starter Kit 1 (PIC18F46J50) for a
'    GCBASIC program loaded by the kit's SD-card bootloader
'
'    The one copy of these routines: every kit program includes this file (2026-10-13; it was
'    first made from MENU_GCB.gcb by a script, deleted on 2026-10-13). Edit it here.
'    OLED_GoTo divides by 16 with rotates (VOLT_GCB build 2), not with a byte division.
'    OLED_Write holds WR low for two instructions (a NOP, 167 ns; one, 83 ns, was below the SH1101A's
'    100 ns minimum; 2026-10-14).
'    With OLED_MIRROR defined (oled_mirror.h), OLED_Write passes every byte to OledMirrorByte, which copies
'    the screen to GLCDMirror.exe on the PC (1.1, 2026-10-16; programs without it are unchanged).
'
'    Include it after #chip / #option / #config:
'        #include <PIC18StarterKit1.h>
'
'    Gives
'      pins         APP_POWER, SD_CS, ACCEL_CS, OLED_RD / WR / CS / DC, MENU_BUTTON
'      AppPowerOn   switches APP_VDD (OLED, pot, accelerometer) on with the soft start, as
'                   the kit's soft_start.c (the bootloader leaves it off)
'      OLED_Init, OLED_Clear, OLED_GoTo(row, x), OLED_Char(c), OLED_Text(row, x, text),
'      OLED_Number(row, x, value) (5 characters, right aligned), OLED_Bar(row, width),
'      OLED_Cmd(byte), OLED_Data(byte), and the 6 x 8 font (Table OledFont).
'      Text row r (0..6) is display page r + 1; x is the pixel column (0..127).
'
'    Uses the variables Col, OledPage (Byte) and FontIndex (Word): do not use them for anything
'    else. MENU_GCB's variable Page is renamed OledPage here: PAGE is an MPASM directive, so
'    a variable of that name stops the build when use.ini selects MPASM.
'
'    Copyright (C) 2014-2026 Hugh Considine and Evan R. Venn
'    Licence: LGPL 2.1 for everyone, or a commercial licence for products that do not want the LGPL's conditions.
'    Licensor: Evan R. Venn, on behalf of the GCBASIC project.
'    For commercial inquiries and licensing, email: license_management AT anobium.co.uk
'
'    This file is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General
'    Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your
'    option) any later version. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
'    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
'    General Public License for more details.

' ----- Pins
#define APP_POWER    LATC.0           ' high = APP_VDD off
#define SD_CS        LATC.6
#define ACCEL_CS     LATC.7
#define OLED_RD      LATE.0
#define OLED_WR      LATE.1
#define OLED_CS      LATE.2
#define OLED_DC      LATB.5
#define MENU_BUTTON  PORTB.0          ' low when pressed
#define OLED_RESET   LATB.4           ' the OLED's reset (does nothing on boards without R44)
#define SPI2_SCK     LATC.2           ' MSSP2 by PPS (SCK2 = RP13): the SD card and the BMA150
#define SPI2_DO      LATB.3           ' SDO2 = RP6
#define SPI2_DI      PORTD.6          ' SDI2 = RP23
#define OLED_OFFSET  2                ' the SH1101A's first visible column

' ----- Variables used by the OLED routines
Dim Col, OledPage As Byte
Dim FontIndex As Word

' =============================================================== Application power
' Port of soft_start.c AppPowerEnable/AppPowerReady: CCP1 PWM on RP11 (RC0), duty
' ramped by Timer4 until CCPR1L reaches 0x40, then the PFET is switched fully on.
Sub AppPowerOn
    APP_POWER = 1                    ' PFET off to start
    Dir APP_POWER Out

    EECON2 = 0x55                    ' PPS unlock
    EECON2 = 0xAA
    IOLOCK = 0
    RPOR11 = 14                      ' CCP1 (P1A) output on RP11 = RC0
    EECON2 = 0x55                    ' PPS lock
    EECON2 = 0xAA
    IOLOCK = 1

    CCP1CON = 0b00001111             ' PWM, outputs active low
    CCPR1L = 0x00
    TCLKCON = 0
    PR2 = 0x80
    T2CON = 0b00000100               ' Timer2 on, 1:1
    TMR4IF = 0
    PR4 = 0x60
    T4CON = 0b01111111               ' Timer4 on, 1:16 prescale, 1:16 postscale

    Do
        If TMR4IF = 1 Then
            TMR4IF = 0
            If (CCP1CON And 0x30) = 0x30 Then
                If CCPR1L = 0x40 Then
                    APP_POWER = 0    ' PFET fully on
                    CCP1CON = 0
                    T2CON = 0
                    TCLKCON = 0
                    PR2 = 0xFF
                    T4CON = 0
                    PR4 = 0xFF
                    TMR4IF = 0
                    Exit Do
                End If
                CCPR1L++
                CCP1CON = CCP1CON And 0xCF
            Else
                CCP1CON = CCP1CON + 0x10
            End If
        End If
    Loop
    Wait 10 ms
End Sub

' =============================================================== OLED (SH1101A, 8080 parallel)
Sub OLED_Write(In OledByte, In IsData As Bit)
    Dir PORTD Out
    LATD = OledByte
    OLED_RD = 1
    OLED_WR = 1
    OLED_DC = IsData
    OLED_CS = 0
    OLED_WR = 0
    NOP                              ' WR low for 2 instructions, 167 ns at 48 MHz: the SH1101A needs 100 ns
    OLED_WR = 1
    OLED_CS = 1
    Dir PORTD In
    #ifdef OLED_MIRROR
    OledMirrorByte(OledByte, IsData)  ' oled_mirror.h: the byte to the PC's copy of the screen
    #endif
End Sub

Sub OLED_Cmd(In OledByte)
    OLED_Write(OledByte, 0)
End Sub

Sub OLED_Data(In OledByte)
    OLED_Write(OledByte, 1)
End Sub

Sub OLED_Init
    OLED_WR = 0 : Dir OLED_WR Out
    OLED_RD = 0 : Dir OLED_RD Out
    OLED_CS = 1 : Dir OLED_CS Out
    OLED_DC = 0 : Dir OLED_DC Out
    Wait 1 ms

    ' Same sequence as the kit's oled.c ResetDevice()
    OLED_Cmd(0xAE)                   ' display off
    OLED_Cmd(0xDB) : OLED_Cmd(0x23)  ' VCOMH
    OLED_Cmd(0xD9) : OLED_Cmd(0x22)  ' pre-charge
    OLED_Cmd(0xA1)                   ' segment re-map
    OLED_Cmd(0xC8)                   ' COM scan direction
    OLED_Cmd(0xDA) : OLED_Cmd(0x12)  ' COM pins
    OLED_Cmd(0xA8) : OLED_Cmd(0x3F)  ' 64 MUX
    OLED_Cmd(0xD5) : OLED_Cmd(0xA0)  ' clock divide
    OLED_Cmd(0x81) : OLED_Cmd(0x60)  ' contrast
    OLED_Cmd(0xD3) : OLED_Cmd(0x00)  ' display offset
    OLED_Cmd(0xA6)                   ' normal display
    OLED_Cmd(0xAD) : OLED_Cmd(0x8B)  ' DC-DC on
    OLED_Cmd(0xAF)                   ' display on
    Wait 10 ms
    OLED_Cmd(0xA4)                   ' show RAM contents
    OLED_Cmd(0x40)                   ' start line 0
    OLED_Cmd(0x00 + OLED_OFFSET)
    OLED_Cmd(0x10)
End Sub

' Set position: Row = text row 0..6 (display page Row+1, as the kit code does), XPos = pixel column
Sub OLED_GoTo(In Row, In XPos)
    Dim OledCol As Byte
    OLED_Cmd(0xB1 + Row)
    OledCol = XPos + OLED_OFFSET
    OLED_Cmd(OledCol And 0x0F)
    Repeat 4                         ' / 16
        Set C Off
        Rotate OledCol Right
    End Repeat
    OLED_Cmd(0x10 Or OledCol)
End Sub

Sub OLED_Clear
    For OledPage = 0 To 7
        OLED_Cmd(0xB0 + OledPage)
        OLED_Cmd(0x00 + OLED_OFFSET)
        OLED_Cmd(0x10)
        For Col = 1 To 132
            OLED_Data(0)
        Next
    Next
End Sub

Sub OLED_Char(In OledChar)
    Dim FontByte, FontCol As Byte
    If OledChar < 32 Or OledChar > 127 Then OledChar = "?"
    FontIndex = [Word](OledChar - 32) * 6 + 1
    For FontCol = 0 To 5
        ReadTable OledFont, FontIndex, FontByte
        OLED_Data(FontByte)
        FontIndex++
    Next
End Sub

Sub OLED_Text(In Row, In XPos, In OledString As String)
    Dim StrPos As Byte
    OLED_GoTo(Row, XPos)
    For StrPos = 1 To Len(OledString)
        OLED_Char(OledString(StrPos))
    Next
End Sub

' Five digits, right aligned, so old values are always overwritten
Sub OLED_Number(In Row, In XPos, In OledValue As Word)
    Dim Divisor As Word
    Dim Digit As Byte
    Dim Leading As Bit
    OLED_GoTo(Row, XPos)
    Leading = 1
    Divisor = 10000
    Do
        Digit = OledValue / Divisor
        OledValue = OledValue % Divisor
        If Digit = 0 And Leading = 1 And Divisor > 1 Then
            OLED_Char(" ")
        Else
            Leading = 0
            OLED_Char(Digit + 48)
        End If
        If Divisor = 1 Then Exit Do
        Divisor = Divisor / 10
    Loop
End Sub

' Solid bar of BarWidth columns on a text row, rest of the row cleared
Sub OLED_Bar(In Row, In BarWidth)
    OLED_GoTo(Row, 0)
    For Col = 1 To 126
        If Col <= BarWidth Then
            OLED_Data(0x7E)
        Else
            OLED_Data(0x00)
        End If
    Next
End Sub

' 6x8 font, ASCII 0x20..0x7F, from the kit's oled.c (g_pucFont)
Table OledFont
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00    ' " " 0x20
    0x00, 0x00, 0x4F, 0x00, 0x00, 0x00    ' !   0x21
    0x00, 0x07, 0x00, 0x07, 0x00, 0x00    ' "   0x22
    0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00    ' #   0x23
    0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00    ' $   0x24
    0x23, 0x13, 0x08, 0x64, 0x62, 0x00    ' %   0x25
    0x36, 0x49, 0x55, 0x22, 0x50, 0x00    ' &   0x26
    0x00, 0x05, 0x03, 0x00, 0x00, 0x00    ' '   0x27
    0x00, 0x1C, 0x22, 0x41, 0x00, 0x00    ' (   0x28
    0x00, 0x41, 0x22, 0x1C, 0x00, 0x00    ' )   0x29
    0x14, 0x08, 0x3E, 0x08, 0x14, 0x00    ' *   0x2A
    0x08, 0x08, 0x3E, 0x08, 0x08, 0x00    ' +   0x2B
    0x00, 0x50, 0x30, 0x00, 0x00, 0x00    ' ,   0x2C
    0x08, 0x08, 0x08, 0x08, 0x08, 0x00    ' -   0x2D
    0x00, 0x60, 0x60, 0x00, 0x00, 0x00    ' .   0x2E
    0x20, 0x10, 0x08, 0x04, 0x02, 0x00    ' /   0x2F
    0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00    ' 0   0x30
    0x00, 0x42, 0x7F, 0x40, 0x00, 0x00    ' 1   0x31
    0x42, 0x61, 0x51, 0x49, 0x46, 0x00    ' 2   0x32
    0x21, 0x41, 0x45, 0x4B, 0x31, 0x00    ' 3   0x33
    0x18, 0x14, 0x12, 0x7F, 0x10, 0x00    ' 4   0x34
    0x27, 0x45, 0x45, 0x45, 0x39, 0x00    ' 5   0x35
    0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00    ' 6   0x36
    0x01, 0x71, 0x09, 0x05, 0x03, 0x00    ' 7   0x37
    0x36, 0x49, 0x49, 0x49, 0x36, 0x00    ' 8   0x38
    0x06, 0x49, 0x49, 0x29, 0x1E, 0x00    ' 9   0x39
    0x00, 0x36, 0x36, 0x00, 0x00, 0x00    ' :   0x3A
    0x00, 0x56, 0x36, 0x00, 0x00, 0x00    ' ;   0x3B
    0x08, 0x14, 0x22, 0x41, 0x00, 0x00    ' <   0x3C
    0x14, 0x14, 0x14, 0x14, 0x14, 0x00    ' =   0x3D
    0x00, 0x41, 0x22, 0x14, 0x08, 0x00    ' >   0x3E
    0x02, 0x01, 0x51, 0x09, 0x06, 0x00    ' ?   0x3F
    0x32, 0x49, 0x79, 0x41, 0x3E, 0x00    ' @   0x40
    0x7E, 0x11, 0x11, 0x11, 0x7E, 0x00    ' A   0x41
    0x7F, 0x49, 0x49, 0x49, 0x36, 0x00    ' B   0x42
    0x3E, 0x41, 0x41, 0x41, 0x22, 0x00    ' C   0x43
    0x7F, 0x41, 0x41, 0x22, 0x1C, 0x00    ' D   0x44
    0x7F, 0x49, 0x49, 0x49, 0x41, 0x00    ' E   0x45
    0x7F, 0x09, 0x09, 0x09, 0x01, 0x00    ' F   0x46
    0x3E, 0x41, 0x49, 0x49, 0x7A, 0x00    ' G   0x47
    0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00    ' H   0x48
    0x00, 0x41, 0x7F, 0x41, 0x00, 0x00    ' I   0x49
    0x20, 0x40, 0x41, 0x3F, 0x01, 0x00    ' J   0x4A
    0x7F, 0x08, 0x14, 0x22, 0x41, 0x00    ' K   0x4B
    0x7F, 0x40, 0x40, 0x40, 0x40, 0x00    ' L   0x4C
    0x7F, 0x02, 0x0C, 0x02, 0x7F, 0x00    ' M   0x4D
    0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00    ' N   0x4E
    0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00    ' O   0x4F
    0x7F, 0x09, 0x09, 0x09, 0x06, 0x00    ' P   0X50
    0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00    ' Q   0X51
    0x7F, 0x09, 0x19, 0x29, 0x46, 0x00    ' R   0X52
    0x46, 0x49, 0x49, 0x49, 0x31, 0x00    ' S   0X53
    0x01, 0x01, 0x7F, 0x01, 0x01, 0x00    ' T   0X54
    0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00    ' U   0X55
    0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00    ' V   0X56
    0x3F, 0x40, 0x38, 0x40, 0x3F, 0x00    ' W   0X57
    0x63, 0x14, 0x08, 0x14, 0x63, 0x00    ' X   0X58
    0x07, 0x08, 0x70, 0x08, 0x07, 0x00    ' Y   0X59
    0x61, 0x51, 0x49, 0x45, 0x43, 0x00    ' Z   0X5A
    0x00, 0x7F, 0x41, 0x41, 0x00, 0x00    ' [   0X5B
    0x02, 0x04, 0x08, 0x10, 0x20, 0x00    ' "\" 0X5C
    0x00, 0x41, 0x41, 0x7F, 0x00, 0x00    ' ]   0X5D
    0x04, 0x02, 0x01, 0x02, 0x04, 0x00    ' ^   0X5E
    0x40, 0x40, 0x40, 0x40, 0x40, 0x00    ' _   0X5F
    0x00, 0x01, 0x02, 0x04, 0x00, 0x00    ' `   0X60
    0x20, 0x54, 0x54, 0x54, 0x78, 0x00    ' a   0X61
    0x7F, 0x48, 0x44, 0x44, 0x38, 0x00    ' b   0X62
    0x38, 0x44, 0x44, 0x44, 0x20, 0x00    ' c   0X63
    0x38, 0x44, 0x44, 0x48, 0x7F, 0x00    ' d   0X64
    0x38, 0x54, 0x54, 0x54, 0x18, 0x00    ' e   0X65
    0x08, 0x7E, 0x09, 0x01, 0x02, 0x00    ' f   0X66
    0x0C, 0x52, 0x52, 0x52, 0x3E, 0x00    ' g   0X67
    0x7F, 0x08, 0x04, 0x04, 0x78, 0x00    ' h   0X68
    0x00, 0x44, 0x7D, 0x40, 0x00, 0x00    ' i   0X69
    0x20, 0x40, 0x44, 0x3D, 0x00, 0x00    ' j   0X6A
    0x7F, 0x10, 0x28, 0x44, 0x00, 0x00    ' k   0X6B
    0x00, 0x41, 0x7F, 0x40, 0x00, 0x00    ' l   0X6C
    0x7C, 0x04, 0x18, 0x04, 0x78, 0x00    ' m   0X6D
    0x7C, 0x08, 0x04, 0x04, 0x78, 0x00    ' n   0X6E
    0x38, 0x44, 0x44, 0x44, 0x38, 0x00    ' o   0X6F
    0x7C, 0x14, 0x14, 0x14, 0x08, 0x00    ' p   0X70
    0x08, 0x14, 0x14, 0x18, 0x7C, 0x00    ' q   0X71
    0x7C, 0x08, 0x04, 0x04, 0x08, 0x00    ' r   0X72
    0x48, 0x54, 0x54, 0x54, 0x20, 0x00    ' s   0X73
    0x04, 0x3F, 0x44, 0x40, 0x20, 0x00    ' t   0X74
    0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00    ' u   0X75
    0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00    ' v   0X76
    0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00    ' w   0X77
    0x44, 0x28, 0x10, 0x28, 0x44, 0x00    ' x   0X78
    0x0C, 0x50, 0x50, 0x50, 0x3C, 0x00    ' y   0X79
    0x44, 0x64, 0x54, 0x4C, 0x44, 0x00    ' z   0X7A
    0x00, 0x08, 0x36, 0x41, 0x00, 0x00    ' {   0X7B
    0x00, 0x00, 0x7F, 0x00, 0x00, 0x00    ' |   0X7C
    0x00, 0x41, 0x36, 0x08, 0x00, 0x00    ' }   0X7D
    0x02, 0x01, 0x02, 0x04, 0x02, 0x00    ' ~   0X7E
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00    ' -- filler --
End Table

' asin(n / 256) in degrees for n = 0..256 (index n + 1)
