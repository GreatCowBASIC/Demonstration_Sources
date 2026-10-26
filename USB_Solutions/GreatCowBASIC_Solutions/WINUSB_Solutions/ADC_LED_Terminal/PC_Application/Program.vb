'
' ADC LED Terminal: a USB comms demonstration with the PICDEM FS USB board (WinUSB, no driver) and
' WINUSB_18F4550_ADC_LEDs.gcb. The loop:
'   1. Send request 150: the board replies with its potentiometer's reading
'   2. Work out the LEDs from the reading, here on the PC
'   3. Send request 151 with the LEDs: the board sets them
'   4. Back to 1
'
' User: Evan R. Venn
' Date: 2026

Imports LibUsbDotNet
Imports LibUsbDotNet.Main
Imports System.Globalization

Module Program

    'The board: 04D8:0052 with bcdDevice 0x0200. LibUsbDotNet reads the revision from Windows' hardware ID
    '("REV_0200") as the decimal number 200.
    Private Const UsbVid = &H4D8
    Private Const UsbPid = &H52
    Private Const UsbRev = 200

    'Request 150: read the reading (a Word, low byte first, 0 to 1023)
    'Request 151: write the LEDs (0 to 15, D1 the lowest bit) in wValue
    Private Const AdcRead As Byte = 150
    Private Const LedsWrite As Byte = 151
    Private Const MaxReplySize = 64

    Private Const AdcMax = 1023
    Private Const SupplyVolts = 5.0
    Private Const PollMilliseconds = 200
    Private Const WaitMilliseconds = 500

    Private ReadOnly Invariant As CultureInfo = CultureInfo.InvariantCulture

    'False when the output is a file or a pipe: then each new reading is a line of its own
    Private Interactive As Boolean
    Private LastLine As String = ""

    Sub Main()
        Dim Version = Reflection.Assembly.GetExecutingAssembly().GetName().Version
        Dim Title = "GCBASIC WinUSB ADC LED Terminal v" & Version.Major & "." & Version.Minor & "." & Version.Build
        Interactive = IsInteractive()
        If Interactive Then Console.Title = Title

        Console.WriteLine(Title)
        Console.WriteLine("The PICDEM FS USB board's potentiometer (RA0, AN0) and its LEDs D1 to D4 (RD0 to RD3).")
        Console.WriteLine("Read the ADC (request 150), work out the LEDs here (the top four bits),")
        Console.WriteLine("send them (request 151), repeat. Q or Esc: quit.")
        Console.WriteLine()

        Dim Waiting = False
        Do
            Dim Device = OpenBoard()
            If Device Is Nothing Then
                If Not Waiting Then
                    Log("Waiting for the board (04D8:0052, bcdDevice 0x0200) ...")
                    Waiting = True
                End If
                If QuitPressed(WaitMilliseconds) Then Exit Do
                Continue Do
            End If

            Waiting = False
            Log("Connected: " & Device.Info.ProductString)
            Dim Quit = Show(Device)
            Try
                Device.Close()
            Catch
                'gone already
            End Try
            If Quit Then Exit Do
            Log("The board was removed.")
        Loop

        EndLine()
        Console.WriteLine("Bye.")
    End Sub

    'Read the ADC, set the LEDs and show them, until the board is removed (False) or Q is pressed (True)
    Private Function Show(Device As UsbDevice) As Boolean
        Do
            '1. Read the ADC
            Dim Reply = ReadReply(Device, AdcRead)
            If Reply Is Nothing OrElse Reply.Length < 2 Then Return False
            Dim AdcValue = Reply(0) + 256 * Reply(1)

            '2. The LEDs: the top four bits of the reading, 0 to 15
            Dim Leds = AdcValue \ 64

            '3. Send the LEDs
            If Not WriteRequest(Device, LedsWrite, Leds) Then Return False

            ShowLine(AdcValue, Leds)
            If QuitPressed(PollMilliseconds) Then Return True
        Loop
    End Function

    '  ADC  557 / 1023   54.4 %   2.72 V    LEDs  D4 [ ]  D3 [*]  D2 [ ]  D1 [ ]    8 = 1000
    Private Sub ShowLine(AdcValue As Integer, Leds As Integer)
        Dim Text As New System.Text.StringBuilder
        Text.Append(String.Format(Invariant, "ADC {0,4} / {1}  {2,6:0.0} %  {3,5:0.00} V    LEDs ",
                                  AdcValue, AdcMax, 100.0 * AdcValue / AdcMax, SupplyVolts * AdcValue / AdcMax))
        For Bit = 3 To 0 Step -1
            Text.Append(" D" & (Bit + 1) & If((Leds And (1 << Bit)) <> 0, " [*]", " [ ]"))
        Next
        Text.Append(String.Format(Invariant, "   {0,2} = {1}", Leds, Convert.ToString(Leds, 2).PadLeft(4, "0"c)))
        Dim Line = Text.ToString()

        If Interactive Then
            'One line, written over in place
            Console.Write(vbCr & Line.PadRight(Math.Max(Line.Length, LastLine.Length)))
        ElseIf Line <> LastLine Then
            'A file or a pipe: a line for each new reading
            Console.WriteLine(DateTime.Now.ToString("HH:mm:ss.fff", Invariant) & "  " & Line)
        End If
        LastLine = Line
    End Sub

    'A message on a line of its own, after the reading's line
    Private Sub Log(Message As String)
        EndLine()
        Console.WriteLine(DateTime.Now.ToString("HH:mm:ss", Invariant) & "  " & Message)
    End Sub

    Private Sub EndLine()
        If Interactive AndAlso LastLine <> "" Then Console.WriteLine()
        LastLine = ""
    End Sub

    Private Function OpenBoard() As UsbDevice
        Try
            Return UsbDevice.OpenUsbDevice(New UsbDeviceFinder(UsbVid, UsbPid, UsbRev))
        Catch
            Return Nothing
        End Try
    End Function

    'A vendor request to the device, reading its reply: Nothing when the transfer fails (the board has gone)
    Private Function ReadReply(Device As UsbDevice, Request As Byte) As Byte()
        '194: device to host, vendor request, to the device
        Dim Setup As New UsbSetupPacket(194, Request, 0, 0, MaxReplySize)
        Dim Buffer(MaxReplySize - 1) As Byte
        Dim Count As Integer
        Try
            If Not Device.ControlTransfer(Setup, Buffer, MaxReplySize, Count) Then Return Nothing
        Catch
            Return Nothing
        End Try
        Dim Reply(Count - 1) As Byte
        Array.Copy(Buffer, Reply, Count)
        Return Reply
    End Function

    'A vendor request to the device with a value and no data: False when the transfer fails (the board has gone)
    Private Function WriteRequest(Device As UsbDevice, Request As Byte, Value As Integer) As Boolean
        '66: host to device, vendor request, to the device
        Dim Setup As New UsbSetupPacket(66, Request, CShort(Value), 0, 0)
        Dim Buffer(0) As Byte
        Dim Count As Integer
        Try
            Return Device.ControlTransfer(Setup, Buffer, 0, Count)
        Catch
            Return False
        End Try
    End Function

    'Wait, and say whether Q or Esc was pressed meanwhile
    Private Function QuitPressed(Milliseconds As Integer) As Boolean
        Dim Until = DateTime.Now.AddMilliseconds(Milliseconds)
        Do
            If Interactive Then
                While Console.KeyAvailable
                    Dim Key = Console.ReadKey(True).Key
                    If Key = ConsoleKey.Q OrElse Key = ConsoleKey.Escape Then Return True
                End While
            End If
            Threading.Thread.Sleep(20)
        Loop While DateTime.Now < Until
        Return False
    End Function

    'A console window, not a file or a pipe: the cursor and the keyboard work
    Private Function IsInteractive() As Boolean
        Try
            'Both throw when the output or the input is a file or a pipe
            Dim Column = Console.CursorLeft
            Dim Pressed = Console.KeyAvailable
            Return True
        Catch
            Return False
        End Try
    End Function

End Module
