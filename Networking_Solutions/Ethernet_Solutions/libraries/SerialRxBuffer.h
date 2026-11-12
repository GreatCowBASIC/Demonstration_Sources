//--------------------------------------------------------------------------------------------------------------------------------
// Interrupt-driven receive buffer for the hardware serial port 1 (EUSART1 or UART1, whichever the chip has)
//
// The serial port holds only a few received characters. A console that prints while a line is still arriving (a
// terminal that sends the whole line on Enter, or a paste) loses the rest, and the overrun can stop reception.
// Here every character is moved into a ring buffer by the receive interrupt as it arrives.
//
// Use SerRx_Available and SerRx_Read in place of USARTHasData and HSerReceive. Needs the USART set up as usual
// (USART_BAUD_RATE). Call SerRx_Init once at start-up.
//
// The program may define (default below):
//   SERRX_BUFFER_SIZE    buffer size, a power of two up to 1024 (it holds one byte less)
//
//@author    Evan R. Venn
//@licence   GPL
//@date      01/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  UART1 (U1RXB) beside EUSART1; comments no longer name one chip family
//--------------------------------------------------------------------------------------------------------------------------------

    #option Explicit

    #ifndef SERRX_BUFFER_SIZE
        #define SERRX_BUFFER_SIZE 32
    #endif
    #define SERRX_MASK SERRX_BUFFER_SIZE - 1

    Dim SerRx_Buffer(SERRX_BUFFER_SIZE)
    Dim SerRx_Head, SerRx_Tail As Word

Sub SerRx_Init
    SerRx_Head = 0
    SerRx_Tail = 0
    #IFDEF BIT( RCIE )
        // EUSART1
        On Interrupt UsartRX1Ready Call SerRx_Isr
    #ENDIF
    #IFDEF BIT( U1RXIE )
        // UART1
        On Interrupt UART1ReceiveInterrupt Call SerRx_Isr
    #ENDIF

End Sub

Sub SerRx_Isr
    // One character per interrupt. When the buffer is full the character is dropped
    Dim SerRx_Next As Word
    SerRx_Next = (SerRx_Head + 1) And SERRX_MASK
    #IFDEF BIT( RCIE )
        If SerRx_Next <> SerRx_Tail Then
            SerRx_Buffer(SerRx_Head) = RC1REG
            SerRx_Head = SerRx_Next
        Else
            SerRx_Next = RC1REG
        End If
        // Overrun stops the receiver until CREN is cleared and set again
        If OERR = 1 Then
            CREN = 0
            CREN = 1
        End If
    #ELSE
        #IFDEF BIT( U1RXIE )
            If SerRx_Next <> SerRx_Tail Then
                SerRx_Buffer(SerRx_Head) = U1RXB
                SerRx_Head = SerRx_Next
            Else
                SerRx_Next = U1RXB
            End If
            
            U1RXEN = 1
            U1ERRIR=0
            if ( U1FERIF = 1 ) then
                // UART1 error: restart
                ON_U1CON1 = 0
                ON_U1CON1 = 1
            end if

        #ELSE
            !!Throw an error - this needs resloving
        #ENDIF
    #ENDIF

End Sub

Function SerRx_Available As Byte
    SerRx_Available = 0
    If SerRx_Head <> SerRx_Tail Then SerRx_Available = 1
End Function

Function SerRx_Read As Byte
    // Waits for a character
    Do While SerRx_Head = SerRx_Tail
    Loop
    SerRx_Read = SerRx_Buffer(SerRx_Tail)
    // Two bytes: no interrupt in between, so the interrupt never sees half an update
    IntOff
    SerRx_Tail = (SerRx_Tail + 1) And SERRX_MASK
    IntOn
End Function
