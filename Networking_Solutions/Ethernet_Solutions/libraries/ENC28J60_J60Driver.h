//--------------------------------------------------------------------------------------------------------------------------------
// ENC28J60 driver for the built-in Ethernet module (PIC18F67J60 and the rest of the 18F97J60 family) - initialisation,
// receive and transmit
//
// The same routines, variables and statistics as ENC28J60_Driver.h, so the rest of the stack works unchanged. The
// Ethernet controller is the ENC28J60's, but its registers are the chip's own (ECON1, ERDPTL, EDATA, ...): no SPI, no
// chip select, no register banks. The board file includes this file in place of ENC28J60_Driver.h.
// Frames are read into and sent from EthFrame.
//
// The program must define, before including this file:
//   MY_MAC1 to MY_MAC6                     this device's MAC address
//   Sub ENC_HandleFrame                    called by ENC_Service for each good frame in EthFrame
// The board file must run the chip from a 25 MHz crystal (FOSC HS or HSPLL): the Ethernet module needs it.
// The board file may define:
//   ENC28J60_ACTIVITY_LED                  LED pin, toggled for each frame received (none: no LED)
//   ENC28J60_RX_SWAP                       pin of a TPIN+/- polarity swap circuit (PICDEM.net 2 Rev 6): while the link
//                                          is up and nothing has been received, the polarity is swapped once a second
// The link and activity LEDs on RA0 / RA1 are driven by the module itself when the configuration has ETHLED = ON.
//
// The program may define (defaults below):
//   ETH_BUFFER_SIZE        bytes of each frame kept in EthFrame; longer frames are truncated
//   ENC_RXFILTER_NORMAL    ERXFCON value set by ENC_Init
//
// Uses the console (CONSOLE_Print, ENC28J60_Console.h) for diagnostics.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      10/11/2026
//
// Changes:
//   01/11/2026  First version, from ENC28J60_Driver.h
//   02/11/2026  A NOP between MAC / MII register accesses (MAADR3 was lost, so unicast frames were not received)
//   02/11/2026  Optional ENC28J60_RX_SWAP: RX polarity swap while linked and nothing received (PICDEM.net 2 Rev 6)
//   02/11/2026  PHY writes as Microchip's errata workaround (PRODL/PRODH, interrupts off); PHCON2 also RXAPDIS
//   02/11/2026  RA0 / RA1 made outputs, so the module drives the link and activity LEDs (dark before)
//   03/11/2026  ENC_ETH_BUILTIN 1 (Ethernet built into the PIC), shown on the configuration page
//   03/11/2026  RXAPDIS only with ENC28J60_RX_SWAP: other boards keep automatic RX polarity (PHCON2 0x0100). The PIC-WEB
//                    linked but received no frame with RXAPDIS set
//   03/11/2026  Overflow with no frame waiting (EPKTCNT 0) restarts the receive buffer, as ENC28J60_Driver.h
//   03/11/2026  Corrected as ENC28J60_Driver.h: only when the buffer is still full (less than one frame of room)//   04/11/2026  #option explicit
//   04/11/2026  ETH_BUFFER_SIZE default 600 (was 64): holds the 576-byte datagram every host must accept
//   06/11/2026  ENC_CheckAlive (as ENC28J60_Driver.h): the stack sets the module up again when its set-up is lost
//   06/11/2026  Receive header checks as Microchip's ETH97J60.c: an odd next-packet pointer or the status vector's zero
//                    bit set is a corrupt header - receive reset (an odd pointer would have reached ERXRDPT as an even value)
//   06/11/2026  Transmit: 2 us after the TX reset before TXRTS, as ETH97J60.c (errata: the TX logic needs 1.6 us to reset;
//                    it was set about 0.5 us later)
//   10/11/2026  ENC_CheckReceive (as ENC28J60_Driver.h): no frame waiting but the write pointer is not where the next
//                    frame will be read - receive reset after two checks in a row
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Statistics switch: 1 = counters and PrintStats in the program, 0 = left out (set by the program or ENC28J60_Stack)
    #ifndef STACK_STATS
        #define STACK_STATS 1
    #endif

// ----- Options

    // Kind of Ethernet controller for the configuration page: 0 an ENC28J60 on SPI, 1 built into the PIC
    #define ENC_ETH_BUILTIN 1

    #ifndef ETH_BUFFER_SIZE
        #define ETH_BUFFER_SIZE 600
    #endif

    // Receive filter: unicast to our MAC + broadcast + CRC check. ENC_RXFILTER_ALL accepts every frame with a good CRC
    #ifndef ENC_RXFILTER_NORMAL
        #define ENC_RXFILTER_NORMAL 0xA1
    #endif
    #define ENC_RXFILTER_ALL 0x20

// ----- Module constants (the registers are the chip's own: ECON1, ERDPTL, MACON1, MIREGADR, ...)

    // PHY registers (through MIREGADR)
    #define ENC_PHCON1   0x00
    #define ENC_PHCON2   0x10
    #define ENC_PHSTAT2  0x11
    #define ENC_PHLCON   0x14

    // Buffer memory: RX from 0, TX gets the top 1536 bytes for one full frame
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

// ----- Frame buffer. Offsets are from the first byte of the Ethernet header
    Dim EthFrame(ETH_BUFFER_SIZE)

    #define ETH_DEST     0
    #define ETH_SRC      6
    #define ETH_TYPE     12

// ----- Variables
    Dim ENC_RevID, ENC_RxFilter, ENC_LinkUp As Byte
    // RX polarity swap: 1 once a good frame has been received on this link; the swap state
    Dim ENC_RxSeen, ENC_RxSwapped As Byte
    Dim ENC_NextPkt, ENC_RxLen As Word
    Dim ENC_RxStatus As Byte
    // ENC_CheckReceive: checks in a row that found the read position behind the write pointer
    Dim ENC_RxLag As Byte

    // Statistics. Stat_RxOther is for the frame handler to count frames it does not use
    #if STACK_STATS = 1
        Dim Stat_RxFrames, Stat_RxOther, Stat_RxBad, Stat_RxOverflow, Stat_RxRecover As Word
        Dim Stat_TxFrames, Stat_TxErrors, Stat_TxRetries As Word
    #endif

// ----- Driver

Sub ENC_Service
    // Receive and dispatch every waiting frame. Polls EPKTCNT, not EIR.PKTIF
    Dim EncSvRead, EncSvWrite, EncSvFree As Word
    Do While EPKTCNT > 0
        If ENC_Receive Then ENC_HandleFrame
        #ifdef ENC28J60_ACTIVITY_LED
            ENC28J60_ACTIVITY_LED = !ENC28J60_ACTIVITY_LED
        #endif
    Loop
    // Receive buffer overflow: the frames already in the buffer are kept, the flag is cleared. The loop above has read
    // every complete frame, so EPKTCNT is 0 here; the buffer is only stuck when it is still full all the same (less
    // than one frame of room behind the read pointer): restart it, as ENC28J60_Driver.h
    If EIR.RXERIF = 1 Then
        #if STACK_STATS = 1
            Stat_RxOverflow++
        #endif
        EIR.RXERIF = 0
        If EPKTCNT = 0 Then
            [byte]EncSvRead = ERXRDPTL
            EncSvRead_H = ERXRDPTH
            [byte]EncSvWrite = ERXWRPTL
            EncSvWrite_H = ERXWRPTH
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
    // Read the next frame into EthFrame (up to ETH_BUFFER_SIZE bytes), free it in the module, and return 1 if it is good
    Dim Header(6)
    Dim Index, RxByte, RxCorrupt As Byte
    Dim FrameLength, ReadLength, ReadPointer As Word

    ENC_Receive = 0

    // Read pointer = start of this frame; EDATA then steps through the buffer (AUTOINC)
    ERDPTL = [byte]ENC_NextPkt
    ERDPTH = ENC_NextPkt_H
    For Index = 0 To 5
        Header(Index) = EDATA
    Next

    // Header: next packet pointer, byte count (with CRC), receive status
    [byte]ENC_NextPkt = Header(0) : ENC_NextPkt_H = Header(1)
    [byte]FrameLength = Header(2) : FrameLength_H = Header(3)
    ENC_RxStatus = Header(4)

    // A corrupt header or buffer: reset receive. Checks as Microchip's ETH97J60.c: the next-packet pointer outside the
    // receive buffer or odd (frames start on even addresses), an impossible length, or the status vector's bit 31 (always
    // 0) set. An odd pointer must never reach ERXRDPT: written as pointer - 1 it would be even. One test per If
    // (If ... Or ... is a compiler-bug area)
    RxCorrupt = 0
    If ENC_NextPkt > ENC_RXEND Then RxCorrupt = 1
    If ENC_NextPkt.0 = 1 Then RxCorrupt = 1
    If FrameLength > ENC_MAX_FRAME + 4 Then RxCorrupt = 1
    RxByte = Header(5)
    If RxByte.7 = 1 Then RxCorrupt = 1
    If RxCorrupt = 1 Then
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
            EthFrame(ReadPointer - 1) = EDATA
        Next
    End If

    // Free the frame. ERXRDPT is kept odd (one before the next frame), as on the ENC28J60
    If ENC_NextPkt = ENC_RXSTART Then
        ReadPointer = ENC_RXEND
    Else
        ReadPointer = ENC_NextPkt - 1
    End If
    ERXRDPTL = [byte]ReadPointer
    ERXRDPTH = ReadPointer_H
    ECON2.PKTDEC = 1

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
    // A frame from another device (not our own, echoed back) proves the RX polarity
    If EthFrame(ETH_SRC + 5) <> MY_MAC6 Then ENC_RxSeen = 1
    ENC_Receive = 1
End Function

Sub ENC_ResetReceive
    // Recover from a corrupt receive buffer: reset the receive logic and restart it empty
    ECON1.RXEN = 0
    ECON1.RXRST = 1
    ECON1.RXRST = 0
    ENC_InitReceiveBuffer
    ECON1.RXEN = 1
End Sub

Sub ENC_InitReceiveBuffer
    ERXSTL = ENC_RXSTART_L
    ERXSTH = ENC_RXSTART_H
    ERXNDL = ENC_RXEND_L
    ERXNDH = ENC_RXEND_H
    ERXRDPTL = ENC_RXEND_L
    ERXRDPTH = ENC_RXEND_H
    ENC_NextPkt = ENC_RXSTART
    ENC_RxLag = 0
    // Drop any frame count left over
    Do While EPKTCNT > 0
        ECON2.PKTDEC = 1
    Loop
End Sub

Function ENC_CheckReceive As Byte
    // Once a second (Stack_Tick), as ENC28J60_Driver.h: 1 = the receive buffer was restarted because, with no frame
    // waiting, the write pointer ERXWRPT was not where the next frame will be read (ENC_NextPkt) two checks in a row
    Dim EncCkWrite As Word
    ENC_CheckReceive = 0
    If EPKTCNT <> 0 Then
        ENC_RxLag = 0
        Exit Function
    End If
    [byte]EncCkWrite = ERXWRPTL
    EncCkWrite_H = ERXWRPTH
    If EPKTCNT <> 0 Then
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
    // Send the first TxLength bytes of EthFrame. The module pads to 60 bytes and adds the CRC. Returns 1 when sent
    Dim TxAttempt As Byte
    Dim TxEnd, TxIndex, TxTimeout As Word

    ENC_Transmit = 0
    TxEnd = ENC_TXSTART + TxLength

    // Per-packet control byte (0 = use MACON3) followed by the frame
    EWRPTL = ENC_TXSTART_L
    EWRPTH = ENC_TXSTART_H
    EDATA = 0
    For TxIndex = 1 To TxLength
        EDATA = EthFrame(TxIndex - 1)
    Next

    ETXSTL = ENC_TXSTART_L
    ETXSTH = ENC_TXSTART_H
    ETXNDL = [byte]TxEnd
    ETXNDH = TxEnd_H

    For TxAttempt = 1 To ENC_TX_RETRIES
        // Reset the transmit logic before each transmission, it can stall after an error
        ECON1.TXRST = 1
        ECON1.TXRST = 0
        // Errata: the TX logic needs at least 1.6 us to reset before TXRTS is set (ETH97J60.c)
        Wait 2 us
        EIR.TXERIF = 0
        EIR.3 = 0                           // TXIF
        ECON1.TXRTS = 1

        // Wait for the end of transmission: a 1518-byte frame takes 1.2 ms at 10 Mbit/s, so 20 ms is generous
        TxTimeout = 0
        Do While ECON1.TXRTS = 1
            Wait 10 us
            TxTimeout++
            If TxTimeout > 2000 Then Exit Do
        Loop

        If EIR.TXERIF = 0 And TxTimeout <= 2000 Then
            #if STACK_STATS = 1
                Stat_TxFrames++
            #endif
            ENC_Transmit = 1
            Exit Function
        End If

        // A late collision can leave TXRTS set; clear it and retry
        ECON1.TXRTS = 0
        #if STACK_STATS = 1
            Stat_TxRetries++
        #endif
    Next
    #if STACK_STATS = 1
        Stat_TxErrors++
    #endif
    #if STACK_CONSOLE <> 0
        CONSOLE_Print "TX failed, ESTAT 0x" : CONSOLE_Print hex(ESTAT) : CONSOLE_CRLF
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
    Dim PhyTimeout As Word

    // RAM is not cleared at reset, so the counters start from zero here
    #if STACK_STATS = 1
        ENC_ClearStats
    #endif

    #ifdef ENC28J60_ACTIVITY_LED
        Dir ENC28J60_ACTIVITY_LED Out
    #endif

    // The link and activity LEDs (configuration ETHLED = ON) are driven on RA0 / RA1 only when those are outputs
    Dir PortA.0 Out
    Dir PortA.1 Out

    // The module is reset while ETHEN is 0; switch it on and wait for the PHY
    ECON2.ETHEN = 0
    Wait 1 ms
    ECON2.ETHEN = 1
    ENC_RevID = 0
    ENC_RxSeen = 0
    ENC_RxSwapped = 0
    #ifdef ENC28J60_RX_SWAP
        // Start with the IEEE 802.3 polarity
        Set ENC28J60_RX_SWAP Off
        Dir ENC28J60_RX_SWAP Out
    #endif

    PhyTimeout = 0
    Do While ESTAT.PHYRDY = 0
        Wait 100 us
        PhyTimeout++
        If PhyTimeout > 1000 Then
            #if STACK_CONSOLE <> 0
                CONSOLE_Print "Ethernet PHY not ready (PHYRDY never set) - check the 25 MHz crystal and FOSC" : CONSOLE_CRLF
            #endif
            Return False
        End If
    Loop

    ENC_InitReceiveBuffer
    ETXSTL = ENC_TXSTART_L
    ETXSTH = ENC_TXSTART_H

    ENC_RxFilter = ENC_RXFILTER_NORMAL
    ERXFCON = ENC_RxFilter

    // MAC and MII registers (MACON1 ... MIRDH): the datasheet requires another instruction between two accesses to
    // them, or the second is lost (MAADR3 = MY_MAC3 followed by MAADR4 = 0 left MAADR3 0). Hence a NOP after each

    // MAC: receive on, pad to 60 bytes, add CRC, check frame length, half duplex, IEEE deferral
    MACON1 = 0x01
    NOP
    MACON3 = 0x32
    NOP
    MACON4 = 0x40
    NOP
    MAMXFLL = ENC_MAX_FRAME_L
    NOP
    MAMXFLH = ENC_MAX_FRAME_H
    NOP
    MABBIPG = 0x12
    NOP
    MAIPGL = 0x12
    NOP
    MAIPGH = 0x0C
    NOP

    MAADR1 = MY_MAC1
    NOP
    MAADR2 = MY_MAC2
    NOP
    MAADR3 = MY_MAC3
    NOP
    MAADR4 = MY_MAC4
    NOP
    MAADR5 = MY_MAC5
    NOP
    MAADR6 = MY_MAC6
    NOP

    // PHY: half duplex, no loopback in half duplex (HDLDIS), LEDA link, LEDB activity. RX polarity: a board with a polarity
    // swap circuit (ENC28J60_RX_SWAP, PICDEM.net 2) sets RXAPDIS and swaps itself; any other board keeps the PHY's automatic
    // polarity correction - with RXAPDIS the PIC-WEB linked but received nothing (RX frames 0) when its RX pair was reversed
    ENC_WritePhy ENC_PHCON1, 0x0000
    #ifdef ENC28J60_RX_SWAP
        ENC_WritePhy ENC_PHCON2, 0x0110
    #endif
    #ifndef ENC28J60_RX_SWAP
        ENC_WritePhy ENC_PHCON2, 0x0100
    #endif
    ENC_WritePhy ENC_PHLCON, 0x3476

    EFLOCON = 0x00                          // no flow control
    EIE = 0x00                              // polled, no interrupts
    EIR = 0x00

    ECON2.AUTOINC = 1
    ECON1.RXEN = 1

    Return True
End Function

Function ENC_CheckAlive As Byte
    // 1 = the Ethernet module still holds our set-up (as ENC28J60_Driver.h): receive buffer end and MAC address
    ENC_CheckAlive = 0
    If ERXNDH <> ENC_RXEND_H Then Exit Function
    If MAADR6 <> MY_MAC6 Then Exit Function
    ENC_CheckAlive = 1
End Function

Function ENC_LinkIsUp As Byte
    // PHSTAT2.LSTAT
    ENC_LinkIsUp = 0
    If (ENC_ReadPhy(ENC_PHSTAT2) And 0x0400) <> 0 Then ENC_LinkIsUp = 1
    #ifdef ENC28J60_RX_SWAP
        // Called once a second (Stack_Tick). Linked but nothing received: try the other RX polarity. No link: back to
        // the normal polarity, to be found again on the next link (another device may wire it the other way)
        If ENC_LinkIsUp = 0 Then
            ENC_RxSeen = 0
            ENC_RxSwapped = 0
        Else
            If ENC_RxSeen = 0 Then ENC_RxSwapped = ENC_RxSwapped Xor 1
        End If
        If ENC_RxSwapped = 1 Then
            Set ENC28J60_RX_SWAP On
        Else
            Set ENC28J60_RX_SWAP Off
        End If
    #endif
End Function

Sub ENC_SetReceiveFilter(In FilterValue)
    ENC_RxFilter = FilterValue
    ERXFCON = ENC_RxFilter
End Sub

Function ENC_ReadPhy(In PhyAddr) As Word
    // A NOP between MII register accesses (see ENC_Init)
    MIREGADR = PhyAddr
    NOP
    MICMD = 0x01                            // MIIRD
    NOP
    Wait 12 us
    ENC_WaitMII
    MICMD = 0
    NOP
    [byte]ENC_ReadPhy = MIRDL
    NOP
    ENC_ReadPhy_H = MIRDH
    NOP
End Function

Sub ENC_WritePhy(In PhyAddr, In PhyValue As Word)
    // A NOP between MII register accesses (see ENC_Init)
    MIREGADR = PhyAddr
    NOP
    // Silicon errata: an access to any address whose low 6 bits are 0x16 between the MIWRL and MIWRH writes corrupts
    // MIWRL. So the value goes through PRODL / PRODH (0xFF3 / 0xFF4) and interrupts are off, as Microchip's driver does
    PRODL = [byte]PhyValue
    PRODH = PhyValue_H
    IntOff
    MIWRL = PRODL
    NOP
    // Writing MIWRH starts the PHY write
    MIWRH = PRODH
    IntOn
    Wait 12 us
    ENC_WaitMII
End Sub

Sub ENC_WaitMII
    // MII operations take 10.24 us; give up after 10 ms
    Dim MiiTimeout As Word
    MiiTimeout = 0
    Do While MISTAT.BUSY = 1
        Wait 10 us
        MiiTimeout++
        If MiiTimeout > 1000 Then Exit Do
    Loop
End Sub

// ----- Diagnostics

#if STACK_CONSOLE <> 0
Sub ShowENCStatus
    Dim PhyValue As Word
    CONSOLE_Print "Ethernet built in"
    CONSOLE_Print "  MAADR " : CONSOLE_Print hex(MAADR1) : CONSOLE_Print ":" : CONSOLE_Print hex(MAADR2)
    CONSOLE_Print ":" : CONSOLE_Print hex(MAADR3) : CONSOLE_Print ":" : CONSOLE_Print hex(MAADR4)
    CONSOLE_Print ":" : CONSOLE_Print hex(MAADR5) : CONSOLE_Print ":" : CONSOLE_Print hex(MAADR6)
    CONSOLE_CRLF
    CONSOLE_Print "ESTAT 0x" : CONSOLE_Print hex(ESTAT)
    CONSOLE_Print "  EIR 0x" : CONSOLE_Print hex(EIR)
    CONSOLE_Print "  ECON1 0x" : CONSOLE_Print hex(ECON1)
    CONSOLE_Print "  EPKTCNT " : CONSOLE_Number EPKTCNT
    CONSOLE_Print "  ERXFCON 0x" : CONSOLE_Print hex(ERXFCON)
    CONSOLE_CRLF
    CONSOLE_Print "Next packet 0x" : PrintHexWord ENC_NextPkt
    CONSOLE_Print "  ERXRDPT 0x" : CONSOLE_Print hex(ERXRDPTH) : CONSOLE_Print hex(ERXRDPTL)
    CONSOLE_Print "  ERXWRPT 0x" : CONSOLE_Print hex(ERXWRPTH) : CONSOLE_Print hex(ERXWRPTL)
    CONSOLE_CRLF
    // The PHY settings written by ENC_Init, read back: PHCON2 should be 0x0100 (0x0110 with ENC28J60_RX_SWAP), PHLCON 0x3476
    PhyValue = ENC_ReadPhy(ENC_PHCON2)
    CONSOLE_Print "PHCON2 0x" : PrintHexWord PhyValue
    PhyValue = ENC_ReadPhy(ENC_PHLCON)
    CONSOLE_Print "  PHLCON 0x" : PrintHexWord PhyValue
    #ifdef ENC28J60_RX_SWAP
        CONSOLE_Print "  RX swap " : CONSOLE_Number ENC_RxSwapped
    #endif
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
