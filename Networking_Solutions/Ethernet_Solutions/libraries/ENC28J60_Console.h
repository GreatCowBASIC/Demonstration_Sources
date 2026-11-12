//--------------------------------------------------------------------------------------------------------------------------------
// Console for the ENC28J60 stack - where the stack's and the program's messages go, and where commands come from
//
//   STACK_CONSOLE 0   headless: no console. Every message in the stack and the program is inside
//                     "#if STACK_CONSOLE <> 0", so none of it, and none of its text, is in the program
//   STACK_CONSOLE 1   serial: messages to the hardware serial port (HSerPrint), commands from it (SerialRxBuffer)
//   STACK_CONSOLE 2   TCP terminal: messages to, and commands from, a telnet connection to TCP port TCP_TERMINAL_PORT
//                     (23) - connection 2 of ENC28J60_TCP.h. One terminal at a time; with none connected the
//                     messages are dropped
//
// Output:  CONSOLE_Print "text" or a string (e.g. hex(x))     CONSOLE_Number value (decimal, up to a Long)
//          CONSOLE_CRLF (optionally CONSOLE_CRLF 2)                 CONSOLE_Char byte (one character)
// Input:   CONSOLE_Init once at start-up, CONSOLE_Available (1 when a character is waiting), CONSOLE_Read
//
// One set of routines; inside each, "#if STACK_CONSOLE = 1" / "= 2" picks the serial or the TCP code. (An #include
// inside #if is not conditional in GCBASIC, so two files with the same routine names cannot be chosen that way.)
//
// TCP terminal: the messages collect in CONSOLE_Tx (CONSOLE_TX_SIZE bytes; more is dropped) and are sent when the main loop
// calls CONSOLE_Available. The bytes being sent stay in CONSOLE_Tx until TCP has them acknowledged, so a retransmission sends
// the same bytes. Received characters go to a 32-byte ring (CONSOLE_Rx); telnet option requests (255, command, option)
// are skipped. The stack passes connection 2's data here (CONSOLE_TcpHandleData, CONSOLE_TcpFillData).
//
// Needs, for STACK_CONSOLE 1: the serial port set up by the board file (USART_BAUD_RATE) and SerialRxBuffer.h.
// Needs, for STACK_CONSOLE 2: ENC28J60_TCP.h with TCP_TERMINAL 1 (the stack sets it).
// STACK_CONSOLE itself is set by the stack, from the program (no default here).
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  CON_ names renamed CONSOLE_
//   04/11/2026  #option explicit
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Serial receive buffer: its routines are only compiled when called (STACK_CONSOLE 1)
    #include <SerialRxBuffer.h>

    // TCP terminal: messages waiting to be sent, and how many of them TCP is sending now (kept until acknowledged)
    #define CONSOLE_TX_SIZE 240
    #if STACK_CONSOLE = 2
        Dim CONSOLE_Tx(CONSOLE_TX_SIZE)
        Dim CONSOLE_TxCount, CONSOLE_TxSending As Byte
        // Received characters: a ring of 32
        Dim CONSOLE_Rx(32)
        Dim CONSOLE_RxHead, CONSOLE_RxTail As Byte
        // 1 while a terminal is connected; telnet option bytes still to skip
        Dim CONSOLE_Connected, CONSOLE_SkipCount As Byte
    #endif

// ----- Console routines

Sub CONSOLE_Init
    #if STACK_CONSOLE = 1
        SerRx_Init
    #endif
    #if STACK_CONSOLE = 2
        CONSOLE_TxCount = 0
        CONSOLE_TxSending = 0
        CONSOLE_RxHead = 0
        CONSOLE_RxTail = 0
        CONSOLE_Connected = 0
        CONSOLE_SkipCount = 0
    #endif
End Sub

Sub CONSOLE_Print(In ConText As String)
    #if STACK_CONSOLE = 1
        HSerPrint ConText
    #endif
    #if STACK_CONSOLE = 2
        Dim ConTextIndex As Byte
        For ConTextIndex = 1 To Len(ConText)
            CONSOLE_Char ConText(ConTextIndex)
        Next
    #endif
End Sub

Sub CONSOLE_Number(In ConValue As Long)
    #if STACK_CONSOLE = 1
        HSerPrint ConValue
    #endif
    #if STACK_CONSOLE = 2
        // Decimal, most significant digit first
        Dim ConDigits(10)
        Dim ConDigitCount As Byte
        Dim ConQuotient As Long
        ConDigitCount = 0
        Do
            ConQuotient = ConValue / 10
            ConDigitCount++
            ConDigits(ConDigitCount) = ConValue - ConQuotient * 10
            ConValue = ConQuotient
        Loop While ConValue > 0
        Do While ConDigitCount > 0
            CONSOLE_Char 48 + ConDigits(ConDigitCount)
            ConDigitCount--
        Loop
    #endif
End Sub

Sub CONSOLE_CRLF(Optional In ConLines = 1)
    Repeat ConLines
        CONSOLE_Char 13
        CONSOLE_Char 10
    End Repeat
End Sub

Sub CONSOLE_Char(In ConChar)
    #if STACK_CONSOLE = 1
        HSerSend ConChar
    #endif
    #if STACK_CONSOLE = 2
        // Into the send buffer; dropped when no terminal is connected or the buffer is full. Only stores: the main loop
        // sends (CONSOLE_Available), so this is safe to call from inside the stack
        If CONSOLE_Connected = 0 Then Exit Sub
        If CONSOLE_TxCount >= CONSOLE_TX_SIZE Then Exit Sub
        CONSOLE_TxCount++
        CONSOLE_Tx(CONSOLE_TxCount) = ConChar
    #endif
End Sub

Function CONSOLE_Available As Byte
    // Called by the main loop: 1 when a character has come in. TCP terminal: first sends waiting messages
    #if STACK_CONSOLE = 1
        CONSOLE_Available = SerRx_Available
    #endif
    #if STACK_CONSOLE = 2
        CONSOLE_Flush
        CONSOLE_Available = 0
        If CONSOLE_RxHead <> CONSOLE_RxTail Then CONSOLE_Available = 1
    #endif
End Function

Function CONSOLE_Read As Byte
    // The next received character (waits for one)
    #if STACK_CONSOLE = 1
        CONSOLE_Read = SerRx_Read
    #endif
    #if STACK_CONSOLE = 2
        Do While CONSOLE_RxHead = CONSOLE_RxTail
            ENC_Service
            CONSOLE_Flush
        Loop
        CONSOLE_Read = CONSOLE_Rx(CONSOLE_RxTail)
        CONSOLE_RxTail = (CONSOLE_RxTail + 1) And 31
    #endif
End Function

// ----- TCP terminal only (not called, so not compiled, with the serial console)

Sub CONSOLE_Flush
    // Terminal connected? Drop what was sent and acknowledged, then send what is waiting
    #if STACK_CONSOLE = 2
        Dim ConMoveIndex As Byte
        If TCP_ConnState(2) <> TCP_ESTABLISHED Then
            CONSOLE_Connected = 0
            CONSOLE_TxCount = 0
            CONSOLE_TxSending = 0
            Exit Sub
        End If
        If CONSOLE_Connected = 0 Then
            // A new terminal: start with an empty buffer
            CONSOLE_Connected = 1
            CONSOLE_TxCount = 0
            CONSOLE_TxSending = 0
        End If
        If TCP_ConnBusy(2) = 1 Then Exit Sub
        If CONSOLE_TxSending > 0 Then
            // The last part was acknowledged: move the rest to the front
            For ConMoveIndex = 1 To CONSOLE_TxCount - CONSOLE_TxSending
                CONSOLE_Tx(ConMoveIndex) = CONSOLE_Tx(ConMoveIndex + CONSOLE_TxSending)
            Next
            CONSOLE_TxCount = CONSOLE_TxCount - CONSOLE_TxSending
            CONSOLE_TxSending = 0
        End If
        If CONSOLE_TxCount = 0 Then Exit Sub
        CONSOLE_TxSending = CONSOLE_TxCount
        TCP_ConnSend 2, CONSOLE_TxSending
    #endif
End Sub

Sub CONSOLE_TcpFillData(In ConOffset As Word, In ConCount As Word)
    // TCP asks for ConCount bytes from byte ConOffset (0 = first) of what is being sent
    #if STACK_CONSOLE = 2
        Dim ConFillPos, ConFillIndex As Word
        ConFillPos = TCP_DATA
        For ConFillIndex = ConOffset + 1 To ConOffset + ConCount
            EthFrame(ConFillPos) = CONSOLE_Tx(ConFillIndex)
            ConFillPos++
        Next
    #endif
End Sub

Sub CONSOLE_TcpHandleData
    // Characters from the terminal, TCP_RxLength bytes in EthFrame from TCP_RxData, into the ring. Telnet option
    // requests (255 followed by two bytes) are skipped; a full ring drops the rest
    #if STACK_CONSOLE = 2
        Dim ConInIndex As Word
        Dim ConInByte, ConNextHead As Byte
        For ConInIndex = TCP_RxData To TCP_RxData + TCP_RxLength - 1
            ConInByte = EthFrame(ConInIndex)
            If CONSOLE_SkipCount > 0 Then
                CONSOLE_SkipCount--
            Else
                If ConInByte = 255 Then
                    CONSOLE_SkipCount = 2
                Else
                    ConNextHead = (CONSOLE_RxHead + 1) And 31
                    If ConNextHead <> CONSOLE_RxTail Then
                        CONSOLE_Rx(CONSOLE_RxHead) = ConInByte
                        CONSOLE_RxHead = ConNextHead
                    End If
                End If
            End If
        Next
    #endif
End Sub
