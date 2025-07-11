'Library of GCBASIC routines to support LNP send/receive over serial RX pin only

#define LNP_BUFFER_SIZE 16

#define LNP_STATE_WAITING 0
#define LNP_STATE_COUNT 1
#define LNP_STATE_DATA 2
#define LNP_STATE_CHECKSUM 3
#define LNP_RX_PIN DIGITAL_0

#define USART_BAUD_RATE 19200
#define USART_BLOCKING 

Dim LNPByteCount As byte
Dim LNPChecksum As byte
Dim LNPRecState As byte
Dim LNPInBytes As byte
Dim LNPInBuffer(16)
Dim LNPInChecksum As byte

#startup LNPInitialise

Sub LNPInitialise
	LNPState = LNP_STATE_WAITING
	LNPInBytes = 0
	
	'Odd parity
	Set UPM00 On
	Set UPM01 On
	
	On Interrupt UsartRX1Ready Call LNPSerInInt
End Sub

Sub LNPSerInInt
	'Check parity bit
	If UPE0 Then
		'Parity error occurred, packet will be invalid
		LNPState = LNP_STATE_WAITING
		LNPInBytes = 0
	End If
	'Read byte
	InByte = HSerReceive
	
	'Waiting state (default on startup)
	'If 0xF0 received, expect byte count next
	If LNPState = LNP_STATE_WAITING Then
		If InByte = 0xF0 Then
			LNPChecksum = InByte - 1
			LNPByteCount = 0
			LNPState = LNP_STATE_COUNT
		End If
	
	'Waiting for byte count, read and start expecting data
	Else If LNPState = LNP_STATE_COUNT Then
		LNPInBytes = InByte
		LNPChecksum = LNPChecksum + InByte
		LNPState = LNP_STATE_DATA
		
	'Expecting data. Read until expected number of bytes read
	Else If LNPState = LNP_STATE_DATA Then
		LNPByteCount = LNPByteCount + 1
		If LNPByteCount <= LNP_BUFFER_SIZE Then
			LNPInBuffer(LNPByteCount) = InByte
		End If
		LNPChecksum = LNPChecksum + InByte
		If LNPByteCount >= LNPInBytes Then
			LNPState = LNP_STATE_CHECKSUM
		End If
		
	'All bytes read, expecting checksum
	Else If LNPState = LNP_STATE_CHECKSUM Then
		LNPInChecksum = InByte
		
		'If received checksum incorrect, throw away data and return to waiting
		If LNPInChecksum <> LNPChecksum Then
			LNPInBytes = 0
			LNPState = LNP_STATE_WAITING
			
		'If received checksum correct, return to waiting and run callback (if present)
		Else
			LNPState = LNP_STATE_WAITING
			#ifdef LNP_REC_HANDLER
				LNP_REC_HANDLER
			#endif
		End If
		
	End If

End Sub

'''Send byte on receive pin
'''Sets LNPWriteConflict to TRUE if write conflict detected
'''@param LNPOutByte Byte to send
Sub SendOnRec (In LNPOutByte)
	'Parity state
	LNPOneCount = 0
	
	'Start bit
	IntOff
	Set RXEN0 Off
	Dir LNP_RX_PIN Out
	Set LNP_RX_PIN Off
	Wait 52 us
	
	'Send 8 data bits
	Repeat 8
		If LNPOutByte.0 Then
			Dir LNP_RX_PIN In
			'Check for conflict
			Wait 26 us
			If LNP_RX_PIN = 0 Then
				LNPWriteConflict = TRUE
			End If
			Wait 25 us
			LNPOneCount += 1
		Else
			Dir LNP_RX_PIN Out
			Set LNP_RX_PIN Off
			Wait 52 us
		End If
		Rotate LNPOutByte Right
		
	End Repeat
	
	'Odd parity. Odd number of ones, send zero
	If LNPOneCount.0 Then
		Dir LNP_RX_PIN Out
		Set LNP_RX_PIN Off
	Else
		'Set LNP_RX_PIN On
		Dir LNP_RX_PIN In
	End If
	Wait 52 us
	
	'Stop bit
	'Set LNP_RX_PIN On
	Dir LNP_RX_PIN In
	Wait 52 us
	
	TransmitAborted:
	Dir LNP_RX_PIN In
	Set RXEN0 On
	IntOn
	Wait 100 us
End Sub

Sub SendLNPPair (In AddressOut, In DataOut)
	'A pair takes about 3 ms, so make delay a multiple of that
	LNPSendDelay = AddressOut Mod 7 + 1
	LNPSendDelay = LNPSendDelay * 3
	LNPSuccessfulSendCount = 0
	LNPSendTryCount = 0
	Do
		'If bus busy, wait up to 20 ms for it to become free
		LNPSendRetryCount = 100
		Do While LNPState <> LNP_STATE_WAITING
			LNPSendRetryCount -= 1
			Wait 200 us
			If LNPSendRetryCount = 0 Then
				LNPState = LNP_STATE_WAITING
				Exit Do
			End If
		Loop
		LNPWriteConflict = FALSE
		SendOnRec 0xF0
		If LNPWriteConflict = FALSE Then
			SendOnRec 2
			If LNPWriteConflict = FALSE Then
				SendOnRec AddressOut
				If LNPWriteConflict = FALSE Then
					SendOnRec DataOut
					If LNPWriteConflict = FALSE Then
						SendOnRec 0xF1 + AddressOut + DataOut
					End If
				End If
			End If
		End If
		If LNPWriteConflict Then
			SendOnRec 0x55
			Wait Random And 63 10us
		Else
			LNPSuccessfulSendCount += 1
		End If
		LNPSendTryCount += 1
		If LNPSendTryCount > 100 Then
			Exit Sub
		End If
		Wait LNPSendDelay ms
	Loop While LNPSuccessfulSendCount < 2
End Sub

Sub SendLNPPairWord (In AddressOut, In DataOut As Word)
	LNPSendDelay = AddressOut Mod 4 + 10
	Repeat 3
		LNPSendRetryCount = 100
		Do While LNPState <> LNP_STATE_WAITING
			LNPSendRetryCount -= 1
			Wait 1 ms
			If LNPSendRetryCount = 0 Then Exit Do
		Loop
		SendOnRec 0xF0
		SendOnRec 3
		SendOnRec AddressOut
		SendOnRec DataOut_H
		SendOnRec DataOut
		SendOnRec 0xF2 + AddressOut + [byte]DataOut + DataOut_H
		Wait LNPSendDelay ms
	End Repeat
End Sub

Sub LNPDumpBuffer
	HSerPrint "LNP S"
	HSerPrint LNPState
	HSerPrint " #"
	HSerPrint LNPInBytes
	HSerPrint " :"
	If LNPInBytes > 0 Then
		For DebugBytePrint = 1 to LNPInBytes
			HSerPrint LNPInBuffer(DebugBytePrint)
			HSerPrint ","
		Next
	End If
	HSerPrint " sums in:"
	HSerPrint LNPInChecksum
	HSerPrint " calc:"
	HSerPrint LNPChecksum
	HSerPrintCRLF
End Sub