//--------------------------------------------------------------------------------------------------------------------------------
// ENC28J60 driver - SPI access, initialisation, receive and transmit
//
// Shared library for the restarted ENC28J60 stack. Frames are read into and sent from EthFrame.
//
// The program must define, before including this file:
//   MY_MAC1 to MY_MAC6                     this device's MAC address
//   ENC28J60_CS, ENC28J60_SCK, ENC28J60_DO, ENC28J60_DI   pins (and PPS if the chip has it)
//   Sub ENC_HandleFrame                    called by ENC_Service for each good frame in EthFrame
// The board file may define:
//   ENC28J60_RESET                         RESET pin (none: soft reset only, e.g. PICDEM.net 2)
//   ENC28J60_ACTIVITY_LED                  LED pin, toggled for each frame received (none: no LED)
//
// The program may define (defaults below):
//   ETH_BUFFER_SIZE        bytes of each frame kept in EthFrame; longer frames are truncated
//   ENC_SPI_SPEED          SPIMode speed; the ENC28J60 maximum is 20 MHz
//   ENC_RXFILTER_NORMAL    ERXFCON value set by ENC_Init
//
// Uses the hardware SPI (HWSPITransfer) and the console (CONSOLE_Print, ENC28J60_Console.h) for diagnostics.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      10/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  Comments no longer name one chip family
//   01/11/2026  ActivityLed renamed ENC28J60_ACTIVITY_LED (board file pin), now optional
//   01/11/2026  CON_ names renamed CONSOLE_
//   02/11/2026  ENC28J60_RESET optional: without it only the soft reset (the PICDEM.net 2 leaves RESET unconnected)
//   03/11/2026  ENC_ETH_BUILTIN 0 (an ENC28J60 on SPI), shown on the configuration page
//   03/11/2026  Overflow with no frame waiting (EPKTCNT 0) restarts the receive buffer: it stayed full for good (18F rig)
//   03/11/2026  Corrected: EPKTCNT is always 0 after the read loop, so every overflow restarted the buffer (frames lost,
//                    "RX corrupt"). Now only when it is still full: less than one frame of room behind the read pointer
//   04/11/2026  #option explicit
//   04/11/2026  ETH_BUFFER_SIZE default 600 (was 64): holds the 576-byte datagram every host must accept
//   06/11/2026  ENC_CheckAlive: 0 when the ENC28J60 has reset on its own (MAADR6 / ERXNDH no longer ours) - the stack
//                    then sets it up again (it stayed offline for hours, the PIC running on)
//   06/11/2026  Receive header checks as Microchip's driver: an odd next-packet pointer or the status vector's zero bit
//                    set is a misread header (one SPI bit error) - receive reset. An odd pointer reached ERXRDPT as an
//                    even value, which lets the receive hardware corrupt the buffer (errata)
//   06/11/2026  Transmit ends on EIR.TXIF or TXERIF, then TXRTS is cleared (errata B5/B7: TXRTS can stay set after the
//                    frame has gone - each attempt ran the full 20 ms, about 60 ms of stall)
//   06/11/2026  ENC_SetBank, ENC_WriteOp and ENC_SPIWrite are macros (inlined): 3 call levels fewer on every register
//                    access. The PIC16F1's 16-level return stack overflowed (PCON0.STKOVF resets on the 16F18877 rig):
//                    18 levels with ARP_Resolve's wait inside MQTT's connect and an interrupt on top
//   10/11/2026  ENC_CheckReceive (once a second from Stack_Tick): no frame waiting (EPKTCNT 0) but the chip's write
//                    pointer is not where the next frame will be read - receive reset after two checks in a row. The
//                    read position had fallen 1-1.6 KB behind (16F18877 rig 09/11/2026, after "RX corrupt"): every
//                    new frame released an old one, pages took 10-14 s
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Console switch STACK_CONSOLE (0 headless, 1 serial, 2 TCP terminal) is set by the stack, from the program. No
    // default here: a default inside #ifndef was taken as well as the program's value (both console versions were compiled)

    // Statistics switch: 1 = counters and PrintStats in the program, 0 = left out (set by the program or ENC28J60_Stack)
    #ifndef STACK_STATS
        #define STACK_STATS 1
    #endif

// ----- Options

    // Kind of Ethernet controller for the configuration page: 0 an ENC28J60 on SPI, 1 built into the PIC
    #define ENC_ETH_BUILTIN 0

    #ifndef ETH_BUFFER_SIZE
        #define ETH_BUFFER_SIZE 600
    #endif

    // MasterFast is the fastest SPIMode speed; the board file sets ENC_SPI_SPEED for its chip and clock
    #ifndef ENC_SPI_SPEED
        #define ENC_SPI_SPEED MasterFast
    #endif

    // Receive filter: unicast to our MAC + broadcast + CRC check. ENC_RXFILTER_ALL accepts every frame with a good CRC
    #ifndef ENC_RXFILTER_NORMAL
        #define ENC_RXFILTER_NORMAL 0xA1
    #endif
    #define ENC_RXFILTER_ALL 0x20

// ----- ENC28J60 registers
    // Bits 0-4 address, bits 5-6 bank, bit 7 set for MAC and MII registers (they return a dummy byte first)

    // All banks
    #define ENC_EIE      0x1B
    #define ENC_EIR      0x1C
    #define ENC_ESTAT    0x1D
    #define ENC_ECON2    0x1E
    #define ENC_ECON1    0x1F
    // Bank 0
    #define ENC_ERDPTL   0x00
    #define ENC_ERDPTH   0x01
    #define ENC_EWRPTL   0x02
    #define ENC_EWRPTH   0x03
    #define ENC_ETXSTL   0x04
    #define ENC_ETXSTH   0x05
    #define ENC_ETXNDL   0x06
    #define ENC_ETXNDH   0x07
    #define ENC_ERXSTL   0x08
    #define ENC_ERXSTH   0x09
    #define ENC_ERXNDL   0x0A
    #define ENC_ERXNDH   0x0B
    #define ENC_ERXRDPTL 0x0C
    #define ENC_ERXRDPTH 0x0D
    #define ENC_ERXWRPTL 0x0E
    #define ENC_ERXWRPTH 0x0F
    // Bank 1
    #define ENC_ERXFCON  0x38
    #define ENC_EPKTCNT  0x39
    // Bank 2 (MAC and MII)
    #define ENC_MACON1   0xC0
    #define ENC_MACON3   0xC2
    #define ENC_MACON4   0xC3
    #define ENC_MABBIPG  0xC4
    #define ENC_MAIPGL   0xC6
    #define ENC_MAIPGH   0xC7
    #define ENC_MAMXFLL  0xCA
    #define ENC_MAMXFLH  0xCB
    #define ENC_MICMD    0xD2
    #define ENC_MIREGADR 0xD4
    #define ENC_MIWRL    0xD6
    #define ENC_MIWRH    0xD7
    #define ENC_MIRDL    0xD8
    #define ENC_MIRDH    0xD9
    // Bank 3
    #define ENC_MAADR5   0xE0
    #define ENC_MAADR6   0xE1
    #define ENC_MAADR3   0xE2
    #define ENC_MAADR4   0xE3
    #define ENC_MAADR1   0xE4
    #define ENC_MAADR2   0xE5
    #define ENC_MISTAT   0xEA
    #define ENC_EREVID   0x72
    #define ENC_ECOCON   0x75
    #define ENC_EFLOCON  0x77
    // PHY
    #define ENC_PHCON1   0x00
    #define ENC_PHSTAT1  0x01
    #define ENC_PHID1    0x02
    #define ENC_PHCON2   0x10
    #define ENC_PHSTAT2  0x11
    #define ENC_PHLCON   0x14

    // Register bits
    #define ENC_ECON1_TXRST   0x80
    #define ENC_ECON1_RXRST   0x40
    #define ENC_ECON1_TXRTS   0x08
    #define ENC_ECON1_RXEN    0x04
    #define ENC_ECON1_BSEL    0x03
    #define ENC_ECON2_AUTOINC 0x80
    #define ENC_ECON2_PKTDEC  0x40
    #define ENC_EIR_PKTIF     0x40
    #define ENC_EIR_TXIF      0x08
    #define ENC_EIR_TXERIF    0x02
    #define ENC_EIR_RXERIF    0x01
    #define ENC_EIR_TXDONE    0x0A            // TXIF or TXERIF: the transmission has ended
    #define ENC_ESTAT_CLKRDY  0x01
    #define ENC_ESTAT_TXABRT  0x02
    #define ENC_ESTAT_LATECOL 0x10
    #define ENC_MISTAT_BUSY   0x01
    #define ENC_MICMD_MIIRD   0x01

    // SPI opcodes
    #define ENC_OP_RCR 0x00
    #define ENC_OP_RBM 0x3A
    #define ENC_OP_WCR 0x40
    #define ENC_OP_WBM 0x7A
    #define ENC_OP_BFS 0x80
    #define ENC_OP_BFC 0xA0
    #define ENC_OP_SRC 0xFF

    // Buffer memory: RX from 0 (errata: RX must start at 0), TX gets the top 1536 bytes for one full frame
    #define ENC_RXSTART 0x0000
    #define ENC_RXEND   0x19FF
    #define ENC_TXSTART 0x1A00
    #define ENC_RXSTART_L 0x00
    #define ENC_RXSTART_H 0x00
    #define ENC_RXEND_L   0xFF
    #define ENC_RXEND_H   0x19
    #define ENC_TXSTART_L 0x00
    #define ENC_TXSTART_H 0x1A

    #define ENC_MAX_FRAME 1518
    #define ENC_MAX_FRAME_L 0xEE
    #define ENC_MAX_FRAME_H 0x05
    #define ENC_TX_RETRIES 3

    #define ENC_Select   Set ENC28J60_CS Off
    #define ENC_Deselect Set ENC28J60_CS On

// ----- Frame buffer. Offsets are from the first byte of the Ethernet header
    Dim EthFrame(ETH_BUFFER_SIZE)

    #define ETH_DEST     0
    #define ETH_SRC      6
    #define ETH_TYPE     12

// ----- Variables
    Dim ENC_Bank, ENC_RevID, ENC_RxFilter, ENC_LinkUp As Byte
    // For the macros ENC_SetBank and ENC_SPIWrite
    Dim ENC_NewBank, ENC_SPIDummy As Byte
    Dim ENC_NextPkt, ENC_RxLen As Word
    Dim ENC_RxStatus As Byte
    // ENC_CheckReceive: checks in a row that found the read position behind the chip's write pointer
    Dim ENC_RxLag As Byte

    // Statistics. Stat_RxOther is for the frame handler to count frames it does not use
    #if STACK_STATS = 1
        Dim Stat_RxFrames, Stat_RxOther, Stat_RxBad, Stat_RxOverflow, Stat_RxRecover As Word
        Dim Stat_TxFrames, Stat_TxErrors, Stat_TxRetries As Word
    #endif

// ----- Driver

Sub ENC_Service
    // Receive and dispatch every waiting frame. Polls EPKTCNT, not EIR.PKTIF (errata: PKTIF is unreliable)
    Dim EncSvRead, EncSvWrite, EncSvFree As Word
    Do While ENC_ReadReg(ENC_EPKTCNT) > 0
        If ENC_Receive Then ENC_HandleFrame
        #ifdef ENC28J60_ACTIVITY_LED
            ENC28J60_ACTIVITY_LED = !ENC28J60_ACTIVITY_LED
        #endif
    Loop
    // Receive buffer overflow (RXB-01): the frames already in the buffer are kept, the flag is cleared.
    // The loop above has read every complete frame, so EPKTCNT is 0 here after any overflow. The buffer is only stuck
    // when it is still full all the same: less than one frame of room between the chip's write pointer and our read
    // pointer, with no complete frame in it. Then it never empties - restart it. Seen on the 18F47Q43 rig
    // (03/11/2026): ERXWRPT 0x04FA just behind ERXRDPT 0x053F, ESTAT.BUFER, 4075 overflows, every larger frame lost
    If (ENC_ReadReg(ENC_EIR) And ENC_EIR_RXERIF) <> 0 Then
        #if STACK_STATS = 1
            Stat_RxOverflow++
        #endif
        ENC_BitClear ENC_EIR, ENC_EIR_RXERIF
        If ENC_ReadReg(ENC_EPKTCNT) = 0 Then
            [byte]EncSvRead = ENC_ReadReg(ENC_ERXRDPTL)
            EncSvRead_H = ENC_ReadReg(ENC_ERXRDPTH)
            [byte]EncSvWrite = ENC_ReadReg(ENC_ERXWRPTL)
            EncSvWrite_H = ENC_ReadReg(ENC_ERXWRPTH)
            // Room from the write pointer up to the read pointer, round the ring
            If EncSvRead >= EncSvWrite Then
                EncSvFree = EncSvRead - EncSvWrite
            Else
                EncSvFree = ENC_RXEND + 1 - EncSvWrite
                EncSvFree = EncSvFree + EncSvRead
            End If
            If EncSvFree < ENC_MAX_FRAME Then
                #if STACK_STATS = 1
                    Stat_RxRecover++
                #endif
                ENC_ResetReceive
            End If
        End If
    End If
End Sub

Function ENC_Receive As Byte
    // Read the next frame into EthFrame (up to ETH_BUFFER_SIZE bytes), free it in the ENC28J60, and return 1 if it is good
    Dim Header(6)
    Dim Index As Byte
    Dim RxByte, RxCorrupt As Byte
    Dim FrameLength, ReadLength, ReadPointer As Word

    ENC_Receive = 0

    // Read pointer = start of this frame
    ENC_WriteReg ENC_ERDPTL, [byte]ENC_NextPkt
    ENC_WriteReg ENC_ERDPTH, ENC_NextPkt_H

    ENC_Select
    ENC_SPIWrite ENC_OP_RBM
    For Index = 0 To 5
        HWSPITransfer 0, RxByte
        Header(Index) = RxByte
    Next

    // Header: next packet pointer, byte count (with CRC), receive status
    [byte]ENC_NextPkt = Header(0) : ENC_NextPkt_H = Header(1)
    [byte]FrameLength = Header(2) : FrameLength_H = Header(3)
    ENC_RxStatus = Header(4)

    // A misread header or a corrupt buffer: reset receive. Checks as Microchip's driver: the next-packet pointer outside
    // the receive buffer or odd (frames start on even addresses), an impossible length, or the status vector's bit 31
    // (always 0) set. An odd pointer must never reach ERXRDPT: written as pointer - 1 it would be even, and an even
    // ERXRDPT lets the receive hardware corrupt the buffer (errata). One test per If (If ... Or ... is a compiler-bug area)
    RxCorrupt = 0
    If ENC_NextPkt > ENC_RXEND Then RxCorrupt = 1
    If ENC_NextPkt.0 = 1 Then RxCorrupt = 1
    If FrameLength > ENC_MAX_FRAME + 4 Then RxCorrupt = 1
    RxByte = Header(5)
    If RxByte.7 = 1 Then RxCorrupt = 1
    If RxCorrupt = 1 Then
        ENC_Deselect
        #if STACK_STATS = 1
            Stat_RxRecover++
        #endif
        #if STACK_CONSOLE <> 0
            CONSOLE_Print "RX corrupt (next 0x" : PrintHexWord ENC_NextPkt : CONSOLE_Print ", length " : CONSOLE_Number FrameLength : CONSOLE_Print "), receive reset" : CONSOLE_CRLF
        #endif
        ENC_ResetReceive
        Exit Function
    End If

    ENC_RxLen = 0
    If FrameLength > 4 Then ENC_RxLen = FrameLength - 4
    ReadLength = ENC_RxLen
    If ReadLength > ETH_BUFFER_SIZE Then ReadLength = ETH_BUFFER_SIZE
    If ReadLength > 0 Then
        For ReadPointer = 1 To ReadLength
            HWSPITransfer 0, RxByte
            EthFrame(ReadPointer - 1) = RxByte
        Next
    End If
    ENC_Deselect

    // Free the frame. Errata: ERXRDPT must be odd, so it is set to one before the next frame
    If ENC_NextPkt = ENC_RXSTART Then
        ReadPointer = ENC_RXEND
    Else
        ReadPointer = ENC_NextPkt - 1
    End If
    ENC_WriteReg ENC_ERXRDPTL, [byte]ReadPointer
    ENC_WriteReg ENC_ERXRDPTH, ReadPointer_H
    ENC_BitSet ENC_ECON2, ENC_ECON2_PKTDEC

    #if STACK_STATS = 1
        Stat_RxFrames++
    #endif
    // Receive status bit 7 = Received OK (CRC and length good)
    If (ENC_RxStatus And 0x80) = 0 Or ENC_RxLen < 14 Then
        #if STACK_STATS = 1
            Stat_RxBad++
        #endif
        Exit Function
    End If
    ENC_Receive = 1
End Function

Sub ENC_ResetReceive
    // Recover from a corrupt receive buffer: reset the receive logic and restart it empty
    ENC_BitClear ENC_ECON1, ENC_ECON1_RXEN
    ENC_BitSet ENC_ECON1, ENC_ECON1_RXRST
    ENC_BitClear ENC_ECON1, ENC_ECON1_RXRST
    ENC_InitReceiveBuffer
    ENC_BitSet ENC_ECON1, ENC_ECON1_RXEN
End Sub

Sub ENC_InitReceiveBuffer
    ENC_WriteReg ENC_ERXSTL, ENC_RXSTART_L
    ENC_WriteReg ENC_ERXSTH, ENC_RXSTART_H
    ENC_WriteReg ENC_ERXNDL, ENC_RXEND_L
    ENC_WriteReg ENC_ERXNDH, ENC_RXEND_H
    ENC_WriteReg ENC_ERXRDPTL, ENC_RXEND_L
    ENC_WriteReg ENC_ERXRDPTH, ENC_RXEND_H
    ENC_NextPkt = ENC_RXSTART
    ENC_RxLag = 0
    // Drop any frame count left over
    Do While ENC_ReadReg(ENC_EPKTCNT) > 0
        ENC_BitSet ENC_ECON2, ENC_ECON2_PKTDEC
    Loop
End Sub

Function ENC_CheckReceive As Byte
    // Once a second (Stack_Tick). 1 = the receive buffer was restarted because the read position had fallen behind.
    // With no frame waiting (EPKTCNT 0) the chip's write pointer ERXWRPT (moved on at the end of each frame received)
    // must be where the next frame will be read (ENC_NextPkt). When it is not, frames sit in the buffer uncounted:
    // ENC_Service reads only when EPKTCNT > 0, so each new frame then releases the oldest one and every reply is late.
    // A misread next-packet pointer that is still even and inside the buffer passes ENC_Receive's checks and does this.
    // EPKTCNT is read again after ERXWRPT: a frame that ended in between is not a fault. Two checks in a row are needed,
    // so one misread register does not restart the buffer
    Dim EncCkWrite As Word
    ENC_CheckReceive = 0
    If ENC_ReadReg(ENC_EPKTCNT) <> 0 Then
        ENC_RxLag = 0
        Exit Function
    End If
    [byte]EncCkWrite = ENC_ReadReg(ENC_ERXWRPTL)
    EncCkWrite_H = ENC_ReadReg(ENC_ERXWRPTH)
    If ENC_ReadReg(ENC_EPKTCNT) <> 0 Then
        ENC_RxLag = 0
        Exit Function
    End If
    If EncCkWrite = ENC_NextPkt Then
        ENC_RxLag = 0
        Exit Function
    End If
    ENC_RxLag++
    If ENC_RxLag < 2 Then Exit Function
    #if STACK_STATS = 1
        Stat_RxRecover++
    #endif
    ENC_ResetReceive
    ENC_CheckReceive = 1
End Function

Function ENC_Transmit(In TxLength As Word) As Byte
    // Send the first TxLength bytes of EthFrame. The ENC28J60 pads to 60 bytes and adds the CRC. Returns 1 when sent
    Dim TxAttempt, TxOk As Byte
    Dim TxEnd, TxIndex, TxTimeout As Word

    ENC_Transmit = 0
    TxEnd = ENC_TXSTART + TxLength

    // Per-packet control byte (0 = use MACON3) followed by the frame
    ENC_WriteReg ENC_EWRPTL, ENC_TXSTART_L
    ENC_WriteReg ENC_EWRPTH, ENC_TXSTART_H
    ENC_Select
    ENC_SPIWrite ENC_OP_WBM
    ENC_SPIWrite 0
    For TxIndex = 1 To TxLength
        ENC_SPIWrite EthFrame(TxIndex - 1)
    Next
    ENC_Deselect

    ENC_WriteReg ENC_ETXSTL, ENC_TXSTART_L
    ENC_WriteReg ENC_ETXSTH, ENC_TXSTART_H
    ENC_WriteReg ENC_ETXNDL, [byte]TxEnd
    ENC_WriteReg ENC_ETXNDH, TxEnd_H

    For TxAttempt = 1 To ENC_TX_RETRIES
        // Errata: reset the transmit logic before each transmission, it can stall after an error
        ENC_BitSet ENC_ECON1, ENC_ECON1_TXRST
        ENC_BitClear ENC_ECON1, ENC_ECON1_TXRST
        ENC_BitClear ENC_EIR, ENC_EIR_TXERIF + ENC_EIR_TXIF
        ENC_BitSet ENC_ECON1, ENC_ECON1_TXRTS

        // Wait for the end of transmission: EIR.TXIF (sent) or TXERIF (aborted), as Microchip's driver. Errata (B5, B7):
        // TXRTS can stay set after the frame has gone, so it is not the end signal. A 1518-byte frame takes 1.2 ms at
        // 10 Mbit/s, so 20 ms is generous
        TxTimeout = 0
        Do While (ENC_ReadReg(ENC_EIR) And ENC_EIR_TXDONE) = 0
            Wait 10 us
            TxTimeout++
            If TxTimeout > 2000 Then Exit Do
        Loop
        // Cancel a transmission request that has become stuck set
        ENC_BitClear ENC_ECON1, ENC_ECON1_TXRTS

        TxOk = 0
        If TxTimeout <= 2000 Then
            If (ENC_ReadReg(ENC_EIR) And ENC_EIR_TXERIF) = 0 Then TxOk = 1
        End If
        If TxOk = 1 Then
            #if STACK_STATS = 1
                Stat_TxFrames++
            #endif
            ENC_Transmit = 1
            Exit Function
        End If

        // Aborted (a late collision) or no end: retry
        #if STACK_STATS = 1
            Stat_TxRetries++
        #endif
    Next
    #if STACK_STATS = 1
        Stat_TxErrors++
    #endif
    #if STACK_CONSOLE <> 0
        CONSOLE_Print "TX failed, ESTAT 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ESTAT)) : CONSOLE_CRLF
    #endif
End Function

#if STACK_STATS = 1
Sub ENC_ClearStats
    Stat_RxFrames = 0
    Stat_RxOther = 0
    Stat_RxBad = 0
    Stat_RxOverflow = 0
    Stat_RxRecover = 0
    Stat_TxFrames = 0
    Stat_TxErrors = 0
    Stat_TxRetries = 0
End Sub
#endif

Function ENC_Init
    Dim ClkTimeout As Word

    // RAM is not cleared at reset, so the counters start from zero here
    #if STACK_STATS = 1
        ENC_ClearStats
    #endif

    Dir ENC28J60_CS Out
    #ifdef ENC28J60_RESET
        Dir ENC28J60_RESET Out
    #endif
    Dir ENC28J60_SCK Out
    Dir ENC28J60_DO Out
    Dir ENC28J60_DI In
    #ifdef ENC28J60_ACTIVITY_LED
        Dir ENC28J60_ACTIVITY_LED Out
    #endif
    ENC_Deselect

    SPIMode ENC_SPI_SPEED, 0

    // Hardware reset (when the board wires RESET), then a soft reset
    #ifdef ENC28J60_RESET
        Set ENC28J60_RESET Off
        Wait 2 ms
        Set ENC28J60_RESET On
    #endif
    Wait 10 ms
    ENC_Select
    ENC_SPIWrite ENC_OP_SRC
    ENC_Deselect
    // Errata: CLKRDY may be set too early after a soft reset, so wait at least 1 ms first
    Wait 2 ms
    ENC_Bank = 255

    // No SPI answer: SO floating high reads 0xFF. ESTAT bit 3 is unimplemented and reads 0, so 0xFF is never a real ESTAT
    ClkTimeout = 0

    Do While ENC_ReadReg(ENC_ESTAT) = 255
        Wait 100 us
        ClkTimeout++
        If ClkTimeout > 1000 Then
            #if STACK_CONSOLE <> 0
                CONSOLE_Print "ENC28J60 not responding (ESTAT reads 0xFF) - check SPI wiring (SO to SDI), CS, RESET and 3.3 V" : CONSOLE_CRLF
            #endif
            Return False
        End If
    Loop

    // SPI answers: now wait for the oscillator (CLKRDY) - the 25 MHz crystal must be running
    ClkTimeout = 0
    Do While (ENC_ReadReg(ENC_ESTAT) And ENC_ESTAT_CLKRDY) = 0
        Wait 100 us
        ClkTimeout++
        If ClkTimeout > 1000 Then
            #if STACK_CONSOLE <> 0
                CONSOLE_Print "ENC28J60 oscillator not ready (CLKRDY never set, ESTAT 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ESTAT))
                CONSOLE_Print ") - check the 25 MHz crystal and 3.3 V" : CONSOLE_CRLF
            #endif
            Return False
        End If
    Loop

    // Silicon revision: 0 or 0xFF means the reads are not real (SO stuck low or high)
    ENC_RevID = ENC_ReadReg(ENC_EREVID)
    If ENC_RevID = 0 Or ENC_RevID = 255 Then
        #if STACK_CONSOLE <> 0
            CONSOLE_Print "ENC28J60 EREVID 0x" : CONSOLE_Print hex(ENC_RevID) : CONSOLE_Print " is not a valid revision - check SO to SDI" : CONSOLE_CRLF
        #endif
        Return False
    End If

    ENC_InitReceiveBuffer
    ENC_WriteReg ENC_ETXSTL, ENC_TXSTART_L
    ENC_WriteReg ENC_ETXSTH, ENC_TXSTART_H

    ENC_RxFilter = ENC_RXFILTER_NORMAL
    ENC_WriteReg ENC_ERXFCON, ENC_RxFilter

    // MAC: receive on, pad to 60 bytes, add CRC, check frame length, half duplex, IEEE deferral
    ENC_WriteReg ENC_MACON1, 0x01
    ENC_WriteReg ENC_MACON3, 0x32
    ENC_WriteReg ENC_MACON4, 0x40
    ENC_WriteReg ENC_MAMXFLL, ENC_MAX_FRAME_L
    ENC_WriteReg ENC_MAMXFLH, ENC_MAX_FRAME_H
    ENC_WriteReg ENC_MABBIPG, 0x12
    ENC_WriteReg ENC_MAIPGL, 0x12
    ENC_WriteReg ENC_MAIPGH, 0x0C

    ENC_WriteReg ENC_MAADR1, MY_MAC1
    ENC_WriteReg ENC_MAADR2, MY_MAC2
    ENC_WriteReg ENC_MAADR3, MY_MAC3
    ENC_WriteReg ENC_MAADR4, MY_MAC4
    ENC_WriteReg ENC_MAADR5, MY_MAC5
    ENC_WriteReg ENC_MAADR6, MY_MAC6

    // PHY: half duplex, no loopback in half duplex (HDLDIS), LEDA link, LEDB activity
    ENC_WritePhy ENC_PHCON1, 0x0000
    ENC_WritePhy ENC_PHCON2, 0x0100
    ENC_WritePhy ENC_PHLCON, 0x3476

    ENC_WriteReg ENC_ECOCON, 0x00          // CLKOUT off
    ENC_WriteReg ENC_EFLOCON, 0x00         // no flow control
    ENC_WriteReg ENC_EIE, 0x00             // polled, no interrupts
    ENC_WriteReg ENC_EIR, 0x00

    ENC_BitSet ENC_ECON2, ENC_ECON2_AUTOINC
    ENC_BitSet ENC_ECON1, ENC_ECON1_RXEN

    Return True
End Function

Function ENC_CheckAlive As Byte
    // 1 = the ENC28J60 still holds our set-up. A reset of the chip on its own (a dip on the module's supply, a glitch on
    // RESET, or a stray 0xFF byte read as the System Reset command) clears the MAC address, the receive buffer limits
    // and the MAC set-up while the PIC runs on: the board then answers nothing (no ARP, no ping, no TCP) until the
    // chip is set up again. Seen on the 18F47Q43 rig 06/11/2026: MAADR 00:00:00:00:00:00, ERXRDPT 0x19FF, offline
    // for hours. Two fingerprints our set-up writes and a chip reset changes: MAADR6 and ERXNDH (reset value 0x1F)
    ENC_CheckAlive = 0
    // After a chip reset ECON1 holds bank 0, whatever ENC_Bank remembers: select the bank afresh
    ENC_Bank = 255
    If ENC_ReadReg(ENC_ERXNDH) <> ENC_RXEND_H Then Exit Function
    If ENC_ReadReg(ENC_MAADR6) <> MY_MAC6 Then Exit Function
    ENC_CheckAlive = 1
End Function

Function ENC_LinkIsUp As Byte
    // PHSTAT2.LSTAT
    ENC_LinkIsUp = 0
    If (ENC_ReadPhy(ENC_PHSTAT2) And 0x0400) <> 0 Then ENC_LinkIsUp = 1
End Function

Sub ENC_SetReceiveFilter(In FilterValue)
    ENC_RxFilter = FilterValue
    ENC_WriteReg ENC_ERXFCON, ENC_RxFilter
End Sub

// ENC_SetBank, ENC_WriteOp and ENC_SPIWrite are macros: each register access would otherwise be five calls deep
// (ENC_WriteReg, ENC_SetBank, ENC_WriteOp, ENC_SPIWrite, HWSPITransfer), too deep for the PIC16F1's 16-level stack

Macro ENC_SetBank (BankAddr)
    // Select the bank of a banked register; the registers at 0x1B to 0x1F are in every bank. ENC_Bank holds the bank
    // bits as in the register constants (0x00, 0x20, 0x40, 0x60; 255 = unknown): no division, which is a call
    If (BankAddr And 0x1F) < 0x1B Then
        ENC_NewBank = BankAddr And 0x60
        If ENC_NewBank <> ENC_Bank Then
            ENC_WriteOp ENC_OP_BFC, ENC_ECON1, ENC_ECON1_BSEL
            If ENC_NewBank.5 = 1 Then
                ENC_WriteOp ENC_OP_BFS, ENC_ECON1, 1
            End If
            If ENC_NewBank.6 = 1 Then
                ENC_WriteOp ENC_OP_BFS, ENC_ECON1, 2
            End If
            ENC_Bank = ENC_NewBank
        End If
    End If
End Macro

Function ENC_ReadReg(In RegAddr) As Byte
    Dim Dummy As Byte
    ENC_SetBank RegAddr
    ENC_Select
    ENC_SPIWrite ENC_OP_RCR Or (RegAddr And 0x1F)
    // MAC and MII registers send a dummy byte first
    If (RegAddr And 0x80) <> 0 Then HWSPITransfer 0, Dummy
    HWSPITransfer 0, ENC_ReadReg
    ENC_Deselect
End Function

Sub ENC_WriteReg(In RegAddr, In RegValue)
    ENC_SetBank RegAddr
    ENC_WriteOp ENC_OP_WCR, RegAddr, RegValue
End Sub

Sub ENC_BitSet(In RegAddr, In RegMask)
    // Ethernet registers only (not MAC/MII)
    ENC_SetBank RegAddr
    ENC_WriteOp ENC_OP_BFS, RegAddr, RegMask
End Sub

Sub ENC_BitClear(In RegAddr, In RegMask)
    ENC_SetBank RegAddr
    ENC_WriteOp ENC_OP_BFC, RegAddr, RegMask
End Sub

Macro ENC_WriteOp (OpCode, OpAddr, OpData)
    ENC_Select
    ENC_SPIWrite OpCode Or (OpAddr And 0x1F)
    ENC_SPIWrite OpData
    ENC_Deselect
End Macro

Function ENC_ReadPhy(In PhyAddr) As Word
    ENC_WriteReg ENC_MIREGADR, PhyAddr
    ENC_WriteReg ENC_MICMD, ENC_MICMD_MIIRD
    Wait 12 us
    ENC_WaitMII
    ENC_WriteReg ENC_MICMD, 0
    [byte]ENC_ReadPhy = ENC_ReadReg(ENC_MIRDL)
    ENC_ReadPhy_H = ENC_ReadReg(ENC_MIRDH)
End Function

Sub ENC_WritePhy(In PhyAddr, In PhyValue As Word)
    ENC_WriteReg ENC_MIREGADR, PhyAddr
    ENC_WriteReg ENC_MIWRL, [byte]PhyValue
    // Writing MIWRH starts the PHY write
    ENC_WriteReg ENC_MIWRH, PhyValue_H
    Wait 12 us
    ENC_WaitMII
End Sub

Macro ENC_SPIWrite (SPIByte)
    // Send a byte and read the byte clocked in, so the SPI receive buffer is empty before the next transfer
    HWSPITransfer SPIByte, ENC_SPIDummy
End Macro

Sub ENC_WaitMII
    // MII operations take 10.24 us; give up after 10 ms
    Dim MiiTimeout As Word
    MiiTimeout = 0
    Do While (ENC_ReadReg(ENC_MISTAT) And ENC_MISTAT_BUSY) <> 0
        Wait 10 us
        MiiTimeout++
        If MiiTimeout > 1000 Then Exit Do
    Loop
End Sub

// ----- Diagnostics

#if STACK_CONSOLE <> 0
Sub ShowENCStatus
    // INI-02, INI-03, INI-04
    Dim PhyValue As Word
    CONSOLE_Print "ENC28J60 EREVID " : CONSOLE_Number ENC_RevID
    CONSOLE_Print "  MAADR " : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR1)) : CONSOLE_Print ":" : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR2))
    CONSOLE_Print ":" : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR3)) : CONSOLE_Print ":" : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR4))
    CONSOLE_Print ":" : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR5)) : CONSOLE_Print ":" : CONSOLE_Print hex(ENC_ReadReg(ENC_MAADR6))
    CONSOLE_CRLF
    CONSOLE_Print "ESTAT 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ESTAT))
    CONSOLE_Print "  EIR 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_EIR))
    CONSOLE_Print "  ECON1 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ECON1))
    CONSOLE_Print "  EPKTCNT " : CONSOLE_Number ENC_ReadReg(ENC_EPKTCNT)
    CONSOLE_Print "  ERXFCON 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ERXFCON))
    CONSOLE_CRLF
    CONSOLE_Print "Next packet 0x" : PrintHexWord ENC_NextPkt
    CONSOLE_Print "  ERXRDPT 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ERXRDPTH)) : CONSOLE_Print hex(ENC_ReadReg(ENC_ERXRDPTL))
    CONSOLE_Print "  ERXWRPT 0x" : CONSOLE_Print hex(ENC_ReadReg(ENC_ERXWRPTH)) : CONSOLE_Print hex(ENC_ReadReg(ENC_ERXWRPTL))
    CONSOLE_CRLF
    PhyValue = ENC_ReadPhy(ENC_PHSTAT2)
    CONSOLE_Print "PHSTAT2 0x" : PrintHexWord PhyValue
    If (PhyValue And 0x0400) <> 0 Then
        CONSOLE_Print "  link up"
        ENC_LinkUp = 1
    Else
        CONSOLE_Print "  link down"
        ENC_LinkUp = 0
    End If
    CONSOLE_CRLF
End Sub
#endif

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub ENC_PrintStats
    CONSOLE_Print "RX frames " : CONSOLE_Number Stat_RxFrames
    CONSOLE_Print "  other " : CONSOLE_Number Stat_RxOther
    CONSOLE_Print "  bad " : CONSOLE_Number Stat_RxBad
    CONSOLE_Print "  overflow " : CONSOLE_Number Stat_RxOverflow
    CONSOLE_Print "  recovered " : CONSOLE_Number Stat_RxRecover
    CONSOLE_CRLF
    CONSOLE_Print "TX frames " : CONSOLE_Number Stat_TxFrames
    CONSOLE_Print "  errors " : CONSOLE_Number Stat_TxErrors
    CONSOLE_Print "  retries " : CONSOLE_Number Stat_TxRetries
    CONSOLE_CRLF
End Sub
#endif
#endif

#if STACK_CONSOLE <> 0
Sub PrintHexWord(In HexValue As Word)
    CONSOLE_Print hex(HexValue_H) : CONSOLE_Print hex(HexValue)
End Sub
#endif
