'
' The board types the application shows, read from BoardTypes.json next to the program.
' The application is a shell for this file: the LEDs, the inputs, the pin tables and the help text all come from it.
'
' User: Evan R. Venn
' Date: 2026

Imports System.IO
Imports System.Text
Imports System.Globalization

'A switch: read with UsbCode, its state is byte ReplyByte of the reply; it is on when that byte is OnValue
'(0 for a switch to 0V with a pull-up)
Public Class BoardSwitch
    Public Name As String
    Public IO As String
    Public Port As String
    Public UsbCode As Byte
    Public ReplyByte As Integer
    Public OnValue As Integer = 1
    'The firmware's name for it: USBCONTROLINPUT1 to 4 (the reply byte of request 140 is its number - 1)
    Public UsbControl As String
End Class

'An LED: read, turn on and turn off with its three codes
Public Class BoardLed
    Public Name As String
    Public IO As String
    Public Colour As String
    Public Port As String
    Public UsbCodeRead As Byte
    Public UsbCodeOn As Byte
    Public UsbCodeOff As Byte
    'The firmware's name for it: USBCONTROLOUTPUT1 to 8
    Public UsbControl As String
End Class

'An ADC channel: read with UsbCode, from byte ReplyByte of the reply (two bytes, low first, when RangeMax > 255)
Public Class BoardAdc
    Public Name As String
    Public IO As String
    Public Port As String
    Public Channel As String
    Public RangeMax As Integer
    Public UsbCode As Byte
    Public ReplyByte As Integer
    'The firmware's name for it: USBCONTROLADC1 to 4
    Public UsbControl As String

    Public ReadOnly Property ReplyBytes As Integer
        Get
            Return If(RangeMax > 255, 2, 1)
        End Get
    End Property
End Class

'The LED the keep-alive (request 255) toggles: shown in the pin table, and USBCONTROLKEEPALIVE in the firmware
Public Class BoardKeepAlive
    Public Name As String
    Public IO As String
    Public Port As String
    Public UsbControl As String
End Class

Public Class BoardType
    Public Id As String
    Public Name As String
    Public ProductMatch As New List(Of String)
    Public KeepAlive As BoardKeepAlive
    Public Switches As New List(Of BoardSwitch)
    Public Leds As New List(Of BoardLed)
    Public Adcs As New List(Of BoardAdc)
    Public BodyText As String = ""
    'Read the switches every SwitchPollSeconds; 0: only when Read is pressed
    Public SwitchPollSeconds As Integer
    'The firmware header Ctrl+G writes (WINUSB_18F4550_Demonstration.h); none: <id>.h
    Public HeaderFile As String

    'True when the board's USB product name ("GCBASIC WinUSB 18F4550") is this board
    Public Function Matches(ProductString As String) As Boolean
        If ProductString Is Nothing Then Return False
        For Each Match In ProductMatch
            If Match <> "" AndAlso ProductString.IndexOf(Match, StringComparison.OrdinalIgnoreCase) >= 0 Then Return True
        Next
        Return False
    End Function

    Public Overrides Function ToString() As String
        Return Id & " - " & Name
    End Function
End Class

Public Class BoardConfig

    Public Const FileName = "BoardTypes.json"
    Public Const MaxSwitches = 4
    Public Const MaxLeds = 8
    Public Const MaxAdcs = 8

    Public Boards As New List(Of BoardType)
    'Problems that did not stop the file loading (a missing id, too many switches ...)
    Public Warnings As New List(Of String)
    Public FilePath As String
    'True when this load wrote the template, because there was no file
    Public Created As Boolean

    Public Shared Function DefaultPath() As String
        Return Path.Combine(Application.StartupPath, FileName)
    End Function

    'Read the file. When there is none, write the template first. A file with a JSON error throws a FormatException.
    Public Shared Function Load(FilePath As String) As BoardConfig
        Dim Config As New BoardConfig
        Config.FilePath = FilePath
        If Not File.Exists(FilePath) Then
            Try
                File.WriteAllText(FilePath, Template(), New UTF8Encoding(False))
                Config.Created = True
            Catch ex As Exception
                Config.Warnings.Add("Could not create " & FilePath & ": " & ex.Message & " The built-in boards are used.")
                Config.Parse(Template())
                Return Config
            End Try
        End If
        Config.Parse(File.ReadAllText(FilePath))
        Return Config
    End Function

    'The built-in boards, when the file cannot be used
    Public Shared Function FromTemplate() As BoardConfig
        Dim Config As New BoardConfig
        Config.FilePath = "(built-in)"
        Config.Parse(Template())
        Return Config
    End Function

    'The template: BoardTypes.json, embedded in the program
    Public Shared Function Template() As String
        Using Stream = GetType(BoardConfig).Assembly.GetManifestResourceStream(FileName)
            Using Reader As New StreamReader(Stream, Encoding.UTF8)
                Return Reader.ReadToEnd()
            End Using
        End Using
    End Function

    Public Function FindBoard(Id As String) As BoardType
        For Each Board In Boards
            If String.Equals(Board.Id, Id, StringComparison.OrdinalIgnoreCase) Then Return Board
        Next
        Return Nothing
    End Function

    Public Function FindBoardForProduct(ProductString As String) As BoardType
        For Each Board In Boards
            If Board.Matches(ProductString) Then Return Board
        Next
        Return Nothing
    End Function

    Private Sub Parse(Text As String)
        Dim Root = TryCast(Json.Parse(Text), Dictionary(Of String, Object))
        If Root Is Nothing Then Throw New FormatException("The file must be a JSON object with a ""boards"" list")
        Dim BoardList = GetList(Root, "boards")
        If BoardList Is Nothing Then Throw New FormatException("The file has no ""boards"" list")

        For Index = 0 To BoardList.Count - 1
            Dim Item = TryCast(BoardList(Index), Dictionary(Of String, Object))
            If Item Is Nothing Then
                Warnings.Add("boards[" & Index & "] is not an object: ignored")
                Continue For
            End If
            Dim Board = ParseBoard(Item, Index)
            If Board Is Nothing Then Continue For
            If FindBoard(Board.Id) IsNot Nothing Then
                Warnings.Add("Board '" & Board.Id & "' is in the file twice: the second one is ignored")
                Continue For
            End If
            Boards.Add(Board)
        Next
    End Sub

    Private Function ParseBoard(Item As Dictionary(Of String, Object), Index As Integer) As BoardType
        Dim Board As New BoardType
        Board.Id = GetString(Item, "id", "").Trim()
        If Board.Id = "" Then
            Warnings.Add("boards[" & Index & "] has no id: ignored")
            Return Nothing
        End If
        Board.Name = GetString(Item, "name", Board.Id)

        'productMatch: one text or a list of texts. None: the id.
        Dim Match As Object = Nothing
        If Item.TryGetValue("productMatch", Match) AndAlso TypeOf Match Is List(Of Object) Then
            For Each MatchText In DirectCast(Match, List(Of Object))
                If MatchText IsNot Nothing Then Board.ProductMatch.Add(MatchText.ToString())
            Next
        Else
            Board.ProductMatch.Add(GetString(Item, "productMatch", Board.Id))
        End If

        Dim KeepAlive = TryCast(GetValue(Item, "keepAlive"), Dictionary(Of String, Object))
        If KeepAlive IsNot Nothing Then
            Board.KeepAlive = New BoardKeepAlive With {
                .Name = GetString(KeepAlive, "name", "Keep-alive"),
                .IO = GetString(KeepAlive, "io", ""),
                .Port = GetString(KeepAlive, "port", ""),
                .UsbControl = GetString(KeepAlive, "usbControl", "USBCONTROLKEEPALIVE").Trim().ToUpperInvariant()}
        End If

        Board.SwitchPollSeconds = GetInteger(Item, "switchPollSeconds", 0)
        If Board.SwitchPollSeconds < 0 OrElse Board.SwitchPollSeconds > 3600 Then
            Warnings.Add(Board.Id & ": switchPollSeconds must be 0 to 3600, the poll is off")
            Board.SwitchPollSeconds = 0
        End If

        For Each Entry In Objects(Item, "switches", Board.Id)
            If Board.Switches.Count = MaxSwitches Then
                Warnings.Add(Board.Id & ": more than " & MaxSwitches & " switches, the rest are ignored")
                Exit For
            End If
            Board.Switches.Add(New BoardSwitch With {
                .Name = GetString(Entry, "name", "Switch " & (Board.Switches.Count + 1)),
                .IO = GetString(Entry, "io", ""),
                .Port = GetString(Entry, "port", ""),
                .UsbCode = GetCode(Entry, "usbCode", Board.Id),
                .ReplyByte = GetInteger(Entry, "replyByte", Board.Switches.Count),
                .OnValue = GetInteger(Entry, "onValue", 1),
                .UsbControl = GetString(Entry, "usbControl", "USBCONTROLINPUT" & (Board.Switches.Count + 1)).Trim().ToUpperInvariant()})
        Next

        For Each Entry In Objects(Item, "leds", Board.Id)
            If Board.Leds.Count = MaxLeds Then
                Warnings.Add(Board.Id & ": more than " & MaxLeds & " LEDs, the rest are ignored")
                Exit For
            End If
            Board.Leds.Add(New BoardLed With {
                .Name = GetString(Entry, "name", "LED " & (Board.Leds.Count + 1)),
                .IO = GetString(Entry, "io", ""),
                .Colour = GetString(Entry, "colour", "LimeGreen"),
                .Port = GetString(Entry, "port", ""),
                .UsbCodeRead = GetCode(Entry, "usbCodeRead", Board.Id),
                .UsbCodeOn = GetCode(Entry, "usbCodeOn", Board.Id),
                .UsbCodeOff = GetCode(Entry, "usbCodeOff", Board.Id),
                .UsbControl = GetString(Entry, "usbControl", "USBCONTROLOUTPUT" & (Board.Leds.Count + 1)).Trim().ToUpperInvariant()})
        Next

        For Each Entry In Objects(Item, "adc", Board.Id)
            If Board.Adcs.Count = MaxAdcs Then
                Warnings.Add(Board.Id & ": more than " & MaxAdcs & " ADC channels, the rest are ignored")
                Exit For
            End If
            Board.Adcs.Add(New BoardAdc With {
                .Name = GetString(Entry, "name", "ADC " & (Board.Adcs.Count + 1)),
                .IO = GetString(Entry, "io", ""),
                .Port = GetString(Entry, "port", ""),
                .Channel = GetString(Entry, "channel", ""),
                .RangeMax = GetRange(Entry, Board.Id),
                .UsbCode = GetCode(Entry, "usbCode", Board.Id),
                .ReplyByte = GetInteger(Entry, "replyByte", 0),
                .UsbControl = GetString(Entry, "usbControl", "USBCONTROLADC" & (Board.Adcs.Count + 1)).Trim().ToUpperInvariant()})
        Next

        Board.HeaderFile = GetString(Item, "headerFile", Board.Id & ".h").Trim()
        CheckUsbControls(Board)

        'bodyText: one string per line, or one string
        Dim Body = GetValue(Item, "bodyText")
        If TypeOf Body Is List(Of Object) Then
            Dim Lines As New List(Of String)
            For Each Line In DirectCast(Body, List(Of Object))
                Lines.Add(If(Line Is Nothing, "", Line.ToString()))
            Next
            Board.BodyText = String.Join(vbCrLf, Lines.ToArray())
        ElseIf Body IsNot Nothing Then
            Board.BodyText = Body.ToString().Replace(vbCrLf, vbLf).Replace(vbLf, vbCrLf)
        End If

        Return Board
    End Function

    'The firmware names (usbControl) the demonstration programs handle, and each one used once on a board
    Private Sub CheckUsbControls(Board As BoardType)
        Dim Used As New HashSet(Of String)
        Dim Check = Sub(Name As String, Pattern As String, Allowed As String)
                        If Not System.Text.RegularExpressions.Regex.IsMatch(Name, "^" & Pattern & "$") Then
                            Warnings.Add(Board.Id & ": usbControl '" & Name & "' is not " & Allowed)
                        ElseIf Not Used.Add(Name) Then
                            Warnings.Add(Board.Id & ": usbControl '" & Name & "' is used twice")
                        End If
                    End Sub
        If Board.KeepAlive IsNot Nothing Then Check(Board.KeepAlive.UsbControl, "USBCONTROLKEEPALIVE", "USBCONTROLKEEPALIVE")
        For Each Led In Board.Leds
            Check(Led.UsbControl, "USBCONTROLOUTPUT[1-8]", "USBCONTROLOUTPUT1 to 8")
        Next
        For Each Switch In Board.Switches
            Check(Switch.UsbControl, "USBCONTROLINPUT[1-4]", "USBCONTROLINPUT1 to 4")
        Next
        For Each Adc In Board.Adcs
            Check(Adc.UsbControl, "USBCONTROLADC[1-4]", "USBCONTROLADC1 to 4")
        Next
    End Sub

    'The objects in a list field; anything else in the list is reported and skipped
    Private Function Objects(Item As Dictionary(Of String, Object), Key As String, BoardId As String) As List(Of Dictionary(Of String, Object))
        Dim Result As New List(Of Dictionary(Of String, Object))
        Dim Value = GetValue(Item, Key)
        If Value Is Nothing Then Return Result
        If Not TypeOf Value Is List(Of Object) Then
            Warnings.Add(BoardId & ": " & Key & " is not a list: ignored")
            Return Result
        End If
        For Each Entry In DirectCast(Value, List(Of Object))
            If TypeOf Entry Is Dictionary(Of String, Object) Then
                Result.Add(DirectCast(Entry, Dictionary(Of String, Object)))
            Else
                Warnings.Add(BoardId & ": an entry in " & Key & " is not an object: ignored")
            End If
        Next
        Return Result
    End Function

    'A USB request code: 0 to 255, as a number, or a text such as "140" or "0x8C"
    Private Function GetCode(Item As Dictionary(Of String, Object), Key As String, BoardId As String) As Byte
        Dim Code = GetInteger(Item, Key, -1)
        If Code < 0 OrElse Code > 255 Then
            Warnings.Add(BoardId & ": " & Key & " is missing or not 0 to 255")
            Return 0
        End If
        Return CByte(Code)
    End Function

    '"0-255", "0-1023", "0-4095" (or just the top value, or "8bit", "10bit", "12bit")
    Private Function GetRange(Item As Dictionary(Of String, Object), BoardId As String) As Integer
        Dim Text = GetString(Item, "range", "0-255").Trim().ToLowerInvariant().Replace(" ", "")
        Select Case Text
            Case "8bit" : Return 255
            Case "10bit" : Return 1023
            Case "12bit" : Return 4095
        End Select
        If Text.Contains("-") Then Text = Text.Substring(Text.LastIndexOf("-"c) + 1)
        Dim Max As Integer
        If Integer.TryParse(Text, NumberStyles.Integer, CultureInfo.InvariantCulture, Max) AndAlso Max > 0 AndAlso Max <= 65535 Then Return Max
        Warnings.Add(BoardId & ": ADC range '" & GetString(Item, "range", "") & "' is not understood, 0-255 is used")
        Return 255
    End Function

    Private Shared Function GetValue(Item As Dictionary(Of String, Object), Key As String) As Object
        Dim Value As Object = Nothing
        Item.TryGetValue(Key, Value)
        Return Value
    End Function

    Private Shared Function GetList(Item As Dictionary(Of String, Object), Key As String) As List(Of Object)
        Return TryCast(GetValue(Item, Key), List(Of Object))
    End Function

    Private Shared Function GetString(Item As Dictionary(Of String, Object), Key As String, DefaultValue As String) As String
        Dim Value = GetValue(Item, Key)
        If Value Is Nothing Then Return DefaultValue
        If TypeOf Value Is Double Then Return DirectCast(Value, Double).ToString(CultureInfo.InvariantCulture)
        Return Value.ToString()
    End Function

    Private Shared Function GetInteger(Item As Dictionary(Of String, Object), Key As String, DefaultValue As Integer) As Integer
        Dim Value = GetValue(Item, Key)
        If TypeOf Value Is Double Then Return CInt(DirectCast(Value, Double))
        If TypeOf Value Is String Then
            Dim Text = DirectCast(Value, String).Trim()
            Dim Number As Integer
            If Text.StartsWith("0x", StringComparison.OrdinalIgnoreCase) Then
                If Integer.TryParse(Text.Substring(2), NumberStyles.HexNumber, CultureInfo.InvariantCulture, Number) Then Return Number
            ElseIf Integer.TryParse(Text, NumberStyles.Integer, CultureInfo.InvariantCulture, Number) Then
                Return Number
            End If
        End If
        Return DefaultValue
    End Function

End Class

'A small JSON reader (.NET 4.0 Client has none): objects become Dictionary(Of String, Object) with keys in any case,
'lists List(Of Object), numbers Double, and true/false/null Boolean/Nothing
Friend Class Json

    Private ReadOnly Text As String
    Private Pos As Integer

    Private Sub New(Text As String)
        Me.Text = Text
    End Sub

    Public Shared Function Parse(Text As String) As Object
        Dim Reader As New Json(Text)
        Reader.SkipSpace()
        Dim Value = Reader.ReadValue()
        Reader.SkipSpace()
        If Reader.Pos < Text.Length Then Reader.Fail("unexpected text after the end")
        Return Value
    End Function

    Private Function ReadValue() As Object
        If Pos >= Text.Length Then Fail("the file ends too early")
        Select Case Text(Pos)
            Case "{"c : Return ReadObject()
            Case "["c : Return ReadList()
            Case """"c : Return ReadString()
            Case "t"c : ReadWord("true") : Return True
            Case "f"c : ReadWord("false") : Return False
            Case "n"c : ReadWord("null") : Return Nothing
            Case Else : Return ReadNumber()
        End Select
    End Function

    Private Function ReadObject() As Dictionary(Of String, Object)
        Dim Result As New Dictionary(Of String, Object)(StringComparer.OrdinalIgnoreCase)
        Pos += 1
        SkipSpace()
        If Peek() = "}"c Then
            Pos += 1
            Return Result
        End If
        Do
            SkipSpace()
            If Peek() <> """"c Then Fail("a name in quotes was expected")
            Dim Key = ReadString()
            SkipSpace()
            Expect(":"c)
            SkipSpace()
            Result(Key) = ReadValue()
            SkipSpace()
            If Peek() = ","c Then
                Pos += 1
            Else
                Expect("}"c)
                Return Result
            End If
        Loop
    End Function

    Private Function ReadList() As List(Of Object)
        Dim Result As New List(Of Object)
        Pos += 1
        SkipSpace()
        If Peek() = "]"c Then
            Pos += 1
            Return Result
        End If
        Do
            SkipSpace()
            Result.Add(ReadValue())
            SkipSpace()
            If Peek() = ","c Then
                Pos += 1
            Else
                Expect("]"c)
                Return Result
            End If
        Loop
    End Function

    Private Function ReadString() As String
        Dim Result As New StringBuilder
        Pos += 1
        Do
            If Pos >= Text.Length Then Fail("a text has no closing quote")
            Dim C = Text(Pos)
            Pos += 1
            If C = """"c Then Return Result.ToString()
            If C = "\"c Then
                If Pos >= Text.Length Then Fail("a text has no closing quote")
                Dim E = Text(Pos)
                Pos += 1
                Select Case E
                    Case "n"c : Result.Append(vbLf)
                    Case "r"c : Result.Append(vbCr)
                    Case "t"c : Result.Append(vbTab)
                    Case "b"c : Result.Append(ChrW(8))
                    Case "f"c : Result.Append(ChrW(12))
                    Case "u"c
                        If Pos + 4 > Text.Length Then Fail("\u needs four hex digits")
                        Result.Append(ChrW(Integer.Parse(Text.Substring(Pos, 4), NumberStyles.HexNumber, CultureInfo.InvariantCulture)))
                        Pos += 4
                    Case Else : Result.Append(E)
                End Select
            Else
                Result.Append(C)
            End If
        Loop
    End Function

    Private Function ReadNumber() As Double
        Dim Start = Pos
        While Pos < Text.Length AndAlso "+-0123456789.eE".IndexOf(Text(Pos)) >= 0
            Pos += 1
        End While
        Dim Number As Double
        If Pos = Start OrElse Not Double.TryParse(Text.Substring(Start, Pos - Start), NumberStyles.Float, CultureInfo.InvariantCulture, Number) Then
            Pos = Start
            Fail("a value was expected (text in quotes, a number, an object or a list)")
        End If
        Return Number
    End Function

    Private Sub ReadWord(Word As String)
        If String.CompareOrdinal(Text, Pos, Word, 0, Word.Length) <> 0 Then Fail("a value was expected")
        Pos += Word.Length
    End Sub

    Private Sub SkipSpace()
        While Pos < Text.Length AndAlso Char.IsWhiteSpace(Text(Pos))
            Pos += 1
        End While
    End Sub

    Private Function Peek() As Char
        If Pos >= Text.Length Then Fail("the file ends too early")
        Return Text(Pos)
    End Function

    Private Sub Expect(C As Char)
        If Peek() <> C Then Fail("'" & C & "' was expected")
        Pos += 1
    End Sub

    'Stop with the line and column, so the file can be corrected
    Private Sub Fail(Message As String)
        Dim Line = 1, Column = 1
        For Index = 0 To Math.Min(Pos, Text.Length) - 1
            If Text(Index) = vbLf Then
                Line += 1
                Column = 1
            Else
                Column += 1
            End If
        Next
        Throw New FormatException(Message & " at line " & Line & ", column " & Column)
    End Sub

End Class
