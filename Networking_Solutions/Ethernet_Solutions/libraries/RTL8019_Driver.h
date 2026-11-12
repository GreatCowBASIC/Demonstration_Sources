//--------------------------------------------------------------------------------------------------------------------------------
// RTL8019AS driver (NE2000, 8-bit bus) for the minimal stack on the original PICDEM.net (PIC16F877)
//
// Frames stay in the RTL8019AS's own buffer: the program reads the headers it needs and copies or writes the rest
// through remote DMA, a byte at a time. There is no frame buffer in PIC RAM (the 16F877 has 368 bytes).
//
//   Transmit buffer  pages 0x40-0x45 (1536 bytes, one frame)
//   Receive ring     pages 0x46-0x5F (PSTART 0x46, PSTOP 0x60)
//
// The board file must define: NIC_DATA, NIC_DATA_DIR (PORTD), NIC_ADDR, NIC_ADDR_DIR (PORTB, RB0-RB4), NIC_IOR,
// NIC_IOW, NIC_RESET, BOARD_LCD_RW (RD5: LCD RW and NIC data bit 5 - handed back to the LCD, low, after each access).
// The program must define MY_MAC1 to MY_MAC6.
//
// The sequence follows Microchip's TCP/IP Stack 3.75 (Source\RTL8019AS.c).
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   02/11/2026  First version
//   04/11/2026  #option explicit
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

// ----- Registers (page 0 unless noted)

    #define NIC_CR        0x00
    #define NIC_PSTART    0x01
    #define NIC_PSTOP     0x02
    #define NIC_BNRY      0x03
    #define NIC_TPSR      0x04
    #define NIC_TBCR0     0x05
    #define NIC_TBCR1     0x06
    #define NIC_ISR       0x07
    #define NIC_RSAR0     0x08
    #define NIC_RSAR1     0x09
    #define NIC_RBCR0     0x0A
    #define NIC_RBCR1     0x0B
    #define NIC_RCR       0x0C
    #define NIC_TCR       0x0D
    #define NIC_DCR       0x0E
    #define NIC_IMR       0x0F
    #define NIC_DATAPORT  0x10
    #define NIC_RESETPORT 0x1F
    #define NIC_PAR0      0x01                  // page 1
    #define NIC_CURR      0x07                  // page 1
    #define NIC_ID0       0x0A                  // read on page 0: 0x50 'P'
    #define NIC_ID1       0x0B                  // read on page 0: 0x70 'p'

    #define NIC_TXSTART   0x40
    #define NIC_RXSTART   0x46
    #define NIC_RXSTOP    0x60

// ----- Variables

    // NicNext: the page of the next frame to read; NicThis: the page of the frame being handled
    Dim NicNext, NicThis, NicValue As Byte

// ----- Register access

Sub NicWrite(In NicReg, In NicData)
    // Address on RB0-RB4, data on PORTD, IOW low; then RD5 back to the LCD (RW low)
    NIC_ADDR = NicReg
    NIC_DATA = NicData
    NIC_DATA_DIR = 0x00
    Set NIC_IOW Off
    NOP
    NOP
    Set NIC_IOW On
    NIC_DATA_DIR = 0xFF
    Set BOARD_LCD_RW Off
    Dir BOARD_LCD_RW Out
End Sub

Function NicRead(In NicReadReg) As Byte
    // Address on RB0-RB4, PORTD input, IOR low; then RD5 back to the LCD (RW low)
    NIC_DATA_DIR = 0xFF
    NIC_ADDR = NicReadReg
    Set NIC_IOR Off
    NOP
    NOP
    NicValue = NIC_DATA
    Set NIC_IOR On
    Set BOARD_LCD_RW Off
    Dir BOARD_LCD_RW Out
    NicRead = NicValue
End Function

// ----- Initialisation

Function NicInit As Byte
    // Reset and start the RTL8019AS. Returns 1 when it entered reset and reads its ID "Pp"
    Dim NicIndex As Byte
    NicInit = 0
    Set NIC_RESET On
    Wait 1 ms
    Set NIC_RESET Off
    Wait 2 ms
    NicWrite NIC_RESETPORT, NicRead(NIC_RESETPORT)
    Wait 2 ms
    If (NicRead(NIC_ISR) And 0x80) = 0 Then Exit Function

    // Stop, page 0, abort remote DMA
    NicWrite NIC_CR, 0x21
    Wait 2 ms
    If NicRead(NIC_ID0) <> 0x50 Then Exit Function
    If NicRead(NIC_ID1) <> 0x70 Then Exit Function

    NicWrite NIC_DCR, 0x48                  // byte wide, normal, FIFO 8 bytes
    NicWrite NIC_RBCR0, 0
    NicWrite NIC_RBCR1, 0
    NicWrite NIC_RCR, 0x04                  // our address and broadcast
    NicWrite NIC_TCR, 0x02                  // internal loopback while setting up
    NicWrite NIC_TPSR, NIC_TXSTART
    NicWrite NIC_PSTART, NIC_RXSTART
    NicWrite NIC_PSTOP, NIC_RXSTOP
    NicWrite NIC_BNRY, NIC_RXSTOP - 1
    NicWrite NIC_ISR, 0xFF
    NicWrite NIC_IMR, 0x00                  // polled

    // Page 1: our MAC, no multicast, the current receive page
    NicWrite NIC_CR, 0x61
    NicWrite NIC_PAR0, MY_MAC1
    NicWrite NIC_PAR0 + 1, MY_MAC2
    NicWrite NIC_PAR0 + 2, MY_MAC3
    NicWrite NIC_PAR0 + 3, MY_MAC4
    NicWrite NIC_PAR0 + 4, MY_MAC5
    NicWrite NIC_PAR0 + 5, MY_MAC6
    For NicIndex = 0 To 7
        NicWrite 0x08 + NicIndex, 0
    Next
    NicWrite NIC_CURR, NIC_RXSTART
    NicNext = NIC_RXSTART

    // Page 0, start, normal transmit
    NicWrite NIC_CR, 0x22
    NicWrite NIC_TCR, 0x00
    NicInit = 1
End Function

// ----- Remote DMA

Sub NicReadStart(In NicReadAddr As Word, In NicReadCount As Word)
    // Remote read of NicReadCount bytes from buffer address NicReadAddr; then NicRead(NIC_DATAPORT) for each byte
    NicWrite NIC_ISR, 0x40
    NicWrite NIC_RSAR0, [byte]NicReadAddr
    NicWrite NIC_RSAR1, NicReadAddr_H
    NicWrite NIC_RBCR0, [byte]NicReadCount
    NicWrite NIC_RBCR1, NicReadCount_H
    NicWrite NIC_CR, 0x0A
End Sub

Sub NicWriteStart(In NicWriteAddr As Word, In NicWriteCount As Word)
    // Remote write of NicWriteCount bytes to buffer address NicWriteAddr; then NicWrite NIC_DATAPORT, byte
    NicWrite NIC_ISR, 0x40
    NicWrite NIC_RSAR0, [byte]NicWriteAddr
    NicWrite NIC_RSAR1, NicWriteAddr_H
    NicWrite NIC_RBCR0, [byte]NicWriteCount
    NicWrite NIC_RBCR1, NicWriteCount_H
    NicWrite NIC_CR, 0x12
End Sub

Function NicRxAddr(In NicOffset As Word) As Word
    // Buffer address of byte NicOffset of the frame being handled (from its 4-byte receive header), wrapped in the ring
    Dim NicRxWord As Word
    [byte]NicRxWord = 0
    NicRxWord_H = NicThis
    NicRxWord = NicRxWord + NicOffset
    If NicRxWord_H >= NIC_RXSTOP Then NicRxWord_H = NicRxWord_H - (NIC_RXSTOP - NIC_RXSTART)
    NicRxAddr = NicRxWord
End Function

// ----- Receive and transmit

Function NicPacket As Byte
    // 1 when a frame is waiting (NicThis is its page). A receive overrun restarts the RTL8019AS
    Dim NicCurrent As Byte
    NicPacket = 0
    If (NicRead(NIC_ISR) And 0x10) <> 0 Then
        NicCurrent = NicInit
        Exit Function
    End If
    NicWrite NIC_CR, 0x62
    NicCurrent = NicRead(NIC_CURR)
    NicWrite NIC_CR, 0x22
    If NicCurrent = NicNext Then Exit Function
    NicThis = NicNext
    NicPacket = 1
End Function

Sub NicDiscard
    // Free the frame just handled: the boundary goes to the page before the next frame. NicNext must be set from the
    // frame's receive header; an impossible value restarts the ring
    Dim NicBoundary, NicDummy As Byte
    If NicNext < NIC_RXSTART Then
        NicDummy = NicInit
        Exit Sub
    End If
    If NicNext >= NIC_RXSTOP Then
        NicDummy = NicInit
        Exit Sub
    End If
    NicBoundary = NicNext - 1
    If NicBoundary < NIC_RXSTART Then NicBoundary = NIC_RXSTOP - 1
    NicWrite NIC_BNRY, NicBoundary
End Sub

Sub NicSend(In NicSendLength As Word)
    // Send the frame written at NIC_TXSTART (padded to 60 bytes by the length), then wait for the transmitter
    Dim NicTimeout As Word
    If NicSendLength < 60 Then NicSendLength = 60
    NicWrite NIC_TPSR, NIC_TXSTART
    NicWrite NIC_TBCR0, [byte]NicSendLength
    NicWrite NIC_TBCR1, NicSendLength_H
    NicWrite NIC_CR, 0x26
    NicTimeout = 0
    Do While (NicRead(NIC_CR) And 0x04) <> 0
        NicTimeout++
        If NicTimeout > 5000 Then Exit Do
    Loop
End Sub
