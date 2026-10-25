'
' Created by SharpDevelop.
' User: Evan R. Venn
' Date: 2020

'''
''' The application is a shell for BoardTypes.json (next to the program): each board type in it gives
''' its switches (up to four), LEDs and ADC channels, with their ports and USB request codes, and its help text.
''' The Input Port State and LED Status groups, and the pin tables and help text on the right, are built from
''' the board type in use. To add a board, add it to BoardTypes.json: no change to this program is needed.
'''
''' When there is no BoardTypes.json the program writes the template (the boards of the demonstration programs
''' in this folder) and asks for the board type in use. The choice is remembered.
'''

Imports LibUsbDotNet
Imports LibUsbDotNet.Main
Imports LibUsbDotNet.DeviceNotify
Imports System.Timers



Partial Public Class MainForm


    'Constants - do not changed
    Public Const DEVICEBITON = 1
    Public Const DEVICEBITOFF = 0

    'The USB ID of the WinUSB solution (WINUSB_<chip>_Demonstration.gcb): 04D8:0052, bcdDevice 0x0100.
    'The device has the Microsoft OS descriptors, so Windows loads WinUSB for it: no driver to install.
    '(The LibK/WinUSB solution with the driver was 1209:2006, bcdDevice 0.)
    Public Const USB_VID = &H4D8
    Public Const USB_PID = &H52
    'bcdDevice 0x0100 (the program's USB_REV). LibUsbDotNet reads the revision from Windows' hardware ID
    '("REV_0100") as the decimal number 100, so the finder needs 100, not &H100 (tested: &H100 finds nothing).
    Public Const USB_REV = 100


    'Application Support- DO NOT CHANGE
    Public Const CONSTDEVICEKEEPALIVE = 255

    'Set up USB change event to handle disconnections etc
    Public Shared UsbDeviceNotifier As IDeviceNotifier = DeviceNotifier.OpenDeviceNotifier()

    'Set up objects and variables we need - do not change
    Public Device As UsbDevice
    Private _timer As Timer
    Shared KeepAliveCounter As Integer
    Shared KeepAliveError As Boolean
    Shared GetStatusfromDeviceUponInit As Boolean
    Shared tempvalue As Byte

    'Set up a variable used to track the user interface
    Shared orginalfooterRightText As String

    'The board types (BoardTypes.json) and the one in use
    Private Boards As BoardConfig
    Private Board As BoardType

    'The controls built for the board in use (BuildBoardUI)
    Private ReadOnly SwitchValues As New List(Of TextBox)
    Private ReadOnly SwitchLamps As New List(Of LedLamp)
    Private ReadOnly AdcValues As New List(Of TextBox)
    Private ReadOnly LedLamps As New List(Of LedLamp)
    Private ReadOnly LedChecks As New List(Of CheckBox)
    Private ReadOnly InputTips As New ToolTip
    'Polls the switches after Start Poll (PollToggle): on the UI thread, like the Read button
    Private WithEvents SwitchPoll As New System.Windows.Forms.Timer

    'True while the LED boxes are set from the device, so setting them does not send a command back
    Private UpdatingLeds As Boolean
    'True while the board list is filled, so filling it does not select a board
    Private FillingBoardList As Boolean

    'The layout of the built groups: the left column is at least MinLeftWidth, wider for a long board name
    Private Const MinLeftWidth = 250
    Private LeftWidth As Integer = MinLeftWidth
    Private Const RowTop = 22
    Private Const InputRowHeight = 24
    Private Const LedRowHeight = 28
    Private Const GroupGap = 6
    Private Const FooterHeight = 24


    Delegate Sub InvokeDelegate()

    Public Sub New()
        ' The Me.InitializeComponent call is required for Windows Forms designer support.
        Me.InitializeComponent()
        ConnectionStatus.Select()

        'Store the orignal UI value - we update later
        orginalfooterRightText = footerRightText.Text

        'Flag to track status of reading the status of the LED when init/reinit of applicatiom
        GetStatusfromDeviceUponInit = True

        'Find USB device: when one is connected, the board question selects it first
        FindUSBDevice()

        ' Hook the device notifier event - do not remove
        AddHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised

    End Sub

    Private Sub MainForm_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        'Where the window was when the program closed (EnsureOnScreen, in BuildBoardUI, keeps it all visible)
        RestoreWindowLocation()

        'The board types, and the board in use
        LoadBoards(False)

        'init the timer - this one 1s manages the KeepAlive - do not remove/touch!
        'Started here, when the form exists, as it updates the form
        _timer = New System.Timers.Timer()
        _timer.Interval = 1000
        AddHandler _timer.Elapsed, AddressOf OneSecondTimerHandler
        ' Have the timer fire repeated events (true is the default)
        _timer.AutoReset = True
        _timer.Enabled = True
        KeepAliveCounter = 0
        'end of the KeepAlive handler

    End Sub



    'Window position

    'Put the window where it was last time: "x,y" in the WindowLocation setting
    Sub RestoreWindowLocation()
        Dim Parts = If(My.Settings.WindowLocation, "").Split(","c)
        Dim X, Y As Integer
        If Parts.Length = 2 AndAlso Integer.TryParse(Parts(0), X) AndAlso Integer.TryParse(Parts(1), Y) Then
            StartPosition = FormStartPosition.Manual
            Location = New Point(X, Y)
        End If
    End Sub

    'Move the window so all of it is on one screen: the screen it is mostly on, or the nearest one
    '(a monitor that has been removed, or a window that grew when another board was selected)
    Sub EnsureOnScreen()
        Dim Area = Screen.FromRectangle(Bounds).WorkingArea
        Dim X = Math.Max(Area.Left, Math.Min(Left, Area.Right - Width))
        Dim Y = Math.Max(Area.Top, Math.Min(Top, Area.Bottom - Height))
        If X <> Left OrElse Y <> Top Then Location = New Point(X, Y)
    End Sub

    'Ctrl+G: write the firmware header of the board in use
    Private Sub MainForm_KeyDown(sender As Object, e As KeyEventArgs) Handles MyBase.KeyDown
        If e.Control AndAlso e.KeyCode = Keys.G Then
            e.Handled = True
            e.SuppressKeyPress = True
            GenerateHeader()
        End If
    End Sub

    'Write the board's USBCONTROL... names, pins and request codes as a GCBASIC header, for the demonstration
    'program to include. It asks where, starting with the board's headerFile next to the program.
    Sub GenerateHeader()
        If Board Is Nothing Then
            MessageBox.Show(Me, "Select a board type first.", Text, MessageBoxButtons.OK, MessageBoxIcon.Information)
            Return
        End If
        Dim Result = FirmwareHeader.Generate(Board, Boards.FilePath)

        Using Dialog As New SaveFileDialog With {
            .Title = "Generate the firmware header for " & Board.Name,
            .Filter = "GCBASIC header (*.h)|*.h|All files (*.*)|*.*",
            .InitialDirectory = Application.StartupPath,
            .FileName = Board.HeaderFile,
            .OverwritePrompt = True}
            If Dialog.ShowDialog(Me) <> DialogResult.OK Then Return
            Try
                IO.File.WriteAllText(Dialog.FileName, Result.Text, System.Text.Encoding.Default)
            Catch ex As Exception
                MessageBox.Show(Me, "Cannot write " & Dialog.FileName & ": " & ex.Message, Text, MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return
            End Try

            Dim Message = "Written " & Dialog.FileName
            If Result.Warnings.Count > 0 Then
                Message &= vbCrLf & vbCrLf & "Check the board file:" & vbCrLf & String.Join(vbCrLf, Result.Warnings.ToArray())
            End If
            MessageBox.Show(Me, Message, Text, MessageBoxButtons.OK, If(Result.Warnings.Count > 0, MessageBoxIcon.Warning, MessageBoxIcon.Information))
        End Using
    End Sub

    Private Sub MainForm_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing
        'The normal position, also when the window is minimised
        Dim Position = If(WindowState = FormWindowState.Normal, Location, RestoreBounds.Location)
        My.Settings.WindowLocation = Position.X & "," & Position.Y
        My.Settings.Save()
    End Sub



    'Board types

    'Read BoardTypes.json (written from the template when there is none) and select the board in use:
    'the saved one, or ask. AskAlways: ask even when the saved board is in the file.
    Sub LoadBoards(AskAlways As Boolean)
        Dim Config As BoardConfig = Nothing
        Do
            Try
                Config = BoardConfig.Load(BoardConfig.DefaultPath())
            Catch ex As Exception
                Dim Answer = MessageBox.Show(Me,
                    BoardConfig.DefaultPath() & " cannot be used:" & vbCrLf & vbCrLf & ex.Message & vbCrLf & vbCrLf &
                    "Correct the file and select Retry, or select Cancel to use the built-in boards.",
                    Text, MessageBoxButtons.RetryCancel, MessageBoxIcon.Warning)
                If Answer = DialogResult.Cancel Then Config = BoardConfig.FromTemplate()
            End Try
        Loop While Config Is Nothing
        Boards = Config

        If Boards.Warnings.Count > 0 Then
            MessageBox.Show(Me, Boards.FilePath & ":" & vbCrLf & vbCrLf & String.Join(vbCrLf, Boards.Warnings.ToArray()),
                            Text, MessageBoxButtons.OK, MessageBoxIcon.Information)
        End If

        'The list of boards
        FillingBoardList = True
        BoardSelect.Items.Clear()
        For Each Item In Boards.Boards
            BoardSelect.Items.Add(Item)
        Next
        FillingBoardList = False
        SizeLeftColumn()

        If Boards.Boards.Count = 0 Then
            MessageBox.Show(Me, Boards.FilePath & " has no boards. Add a board to it and select Reload file.",
                            Text, MessageBoxButtons.OK, MessageBoxIcon.Warning)
            SelectBoard(Nothing)
            Return
        End If

        'The board in use: the one in use before a reload, else the saved one
        Dim Selected As BoardType = Nothing
        If Board IsNot Nothing Then Selected = Boards.FindBoard(Board.Id)
        If Selected Is Nothing Then Selected = Boards.FindBoard(My.Settings.SelectedBoard)

        If Boards.Created OrElse Selected Is Nothing OrElse AskAlways Then
            Dim Message As String
            If Boards.Created Then
                Message = "There was no board file, so the template was written to" & vbCrLf & Boards.FilePath & vbCrLf & "Select the board type in use."
            Else
                Message = "Select the board type in use. The boards are in" & vbCrLf & Boards.FilePath
            End If
            'Select the connected board first, when there is one
            Dim Preselect As BoardType = Selected
            If Not Device Is Nothing Then
                Dim Connected = Boards.FindBoardForProduct(Device.Info.ProductString)
                If Connected IsNot Nothing Then Preselect = Connected
            End If
            Using Dialog As New BoardSelectForm(Boards.Boards, Message, Preselect)
                If Dialog.ShowDialog(Me) = DialogResult.OK AndAlso Dialog.SelectedBoard IsNot Nothing Then
                    Selected = Dialog.SelectedBoard
                ElseIf Selected Is Nothing Then
                    Selected = If(Preselect, Boards.Boards(0))
                End If
            End Using
        End If

        SelectBoard(Selected)
    End Sub

    'Use this board: remember it, build its controls, and read its LEDs from the device
    Sub SelectBoard(NewBoard As BoardType)
        Board = NewBoard
        FillingBoardList = True
        BoardSelect.SelectedItem = NewBoard
        FillingBoardList = False

        If Board IsNot Nothing Then
            My.Settings.SelectedBoard = Board.Id
            My.Settings.Save()
        End If

        BuildBoardUI()
        GetStatusfromDeviceUponInit = True
        UpdateFormWithLatestData_UserSolution()
    End Sub

    'Show each board by its name only
    Private Sub BoardSelect_Format(sender As Object, e As ListControlConvertEventArgs) Handles BoardSelect.Format
        Dim Item = TryCast(e.ListItem, BoardType)
        If Item IsNot Nothing Then e.Value = Item.Name
    End Sub

    'Make the left column wide enough for the longest board name in the file (at least MinLeftWidth),
    'and move the right side and the footer to fit. BuildBoardUI lays the rows out in LeftWidth.
    Sub SizeLeftColumn()
        Dim Widest = 0
        For Each Item In Boards.Boards
            Widest = Math.Max(Widest, TextRenderer.MeasureText(Item.Name, BoardSelect.Font).Width)
        Next
        'The text, the drop-down arrow and the box's own margins
        Dim ComboWidth = Math.Max(MinLeftWidth - 20, Widest + SystemInformation.VerticalScrollBarWidth + 12)
        LeftWidth = ComboWidth + 20

        For Each Group In New GroupBox() {groupBox1, groupBoxBoard, groupBox2, groupBox3}
            Group.Width = LeftWidth
        Next
        ConnectionStatus.Width = LeftWidth - 32
        BoardSelect.Width = ComboWidth
        BoardSelect.DropDownWidth = ComboWidth
        Dim ButtonWidth = (ComboWidth - 10) \ 2
        ReloadBoards.Width = ButtonWidth
        EditBoards.Left = ReloadBoards.Right + 10
        EditBoards.Width = ComboWidth - ButtonWidth - 10

        GroupBox_Board.Left = groupBox1.Right + 8
        ClientSize = New Size(GroupBox_Board.Right + 8, ClientSize.Height)
        footerRightText.Left = ClientSize.Width - footerRightText.Width - 12
    End Sub

    Private Sub BoardSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles BoardSelect.SelectedIndexChanged
        If FillingBoardList Then Return
        Dim Selected = TryCast(BoardSelect.SelectedItem, BoardType)
        If Selected IsNot Nothing AndAlso Not Selected Is Board Then SelectBoard(Selected)
    End Sub

    Private Sub ReloadBoards_Click(sender As Object, e As EventArgs) Handles ReloadBoards.Click
        LoadBoards(False)
    End Sub

    Private Sub EditBoards_Click(sender As Object, e As EventArgs) Handles EditBoards.Click
        Try
            If Not IO.File.Exists(BoardConfig.DefaultPath()) Then BoardConfig.Load(BoardConfig.DefaultPath())
            Process.Start("notepad.exe", """" & BoardConfig.DefaultPath() & """")
        Catch ex As Exception
            MessageBox.Show(Me, "Cannot open " & BoardConfig.DefaultPath() & ": " & ex.Message, Text, MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End Try
    End Sub

    'Build the Input Port State and LED Status groups, the pin tables and the help text for the board in use,
    'and size the form to them
    Sub BuildBoardUI()
        SuspendLayout()

        'Remove the controls of the last board
        For Each Group In New GroupBox() {groupBox2, groupBox3}
            For Index = Group.Controls.Count - 1 To 0 Step -1
                Dim Item = Group.Controls(Index)
                If Not Item Is PollValues AndAlso Not Item Is PollToggle Then
                    Group.Controls.RemoveAt(Index)
                    Item.Dispose()
                End If
            Next
        Next
        InputTips.RemoveAll()
        SwitchValues.Clear()
        SwitchLamps.Clear()
        AdcValues.Clear()
        LedLamps.Clear()
        LedChecks.Clear()

        Dim RowFont As New Font("Microsoft Sans Serif", 8.25!, FontStyle.Regular)
        Dim Switches = If(Board Is Nothing, New List(Of BoardSwitch), Board.Switches)
        Dim Leds = If(Board Is Nothing, New List(Of BoardLed), Board.Leds)
        Dim Adcs = If(Board Is Nothing, New List(Of BoardAdc), Board.Adcs)

        'Input Port State: a row for each switch, then each ADC channel, then Read
        Dim Y = RowTop
        For Each Switch In Switches
            AddInputRow(Y, Describe(Switch.Name, Switch.IO), Switch.Port & ", request " & Switch.UsbCode & " byte " & Switch.ReplyByte & ", on at " & Switch.OnValue, RowFont, SwitchValues, SwitchLamps)
            Y += InputRowHeight
        Next
        For Each Adc In Adcs
            AddInputRow(Y, Describe(Adc.Name, Adc.Channel), Adc.Port & " " & Adc.Channel & ", 0-" & Adc.RangeMax & ", request " & Adc.UsbCode & " byte " & Adc.ReplyByte, RowFont, AdcValues)
            Y += InputRowHeight
        Next
        If Switches.Count + Adcs.Count = 0 Then
            groupBox2.Controls.Add(New Label With {.Text = "No inputs on this board", .Font = RowFont, .Location = New Point(19, Y), .Size = New Size(LeftWidth - 30, 15)})
            Y += InputRowHeight
        End If
        'Read, and Start Poll / End Poll beside it
        Dim ButtonWidth = (LeftWidth - 40) \ 2
        PollValues.SetBounds(15, Y + 4, ButtonWidth, 24)
        PollToggle.SetBounds(PollValues.Right + 10, Y + 4, ButtonWidth, 24)
        groupBox2.Height = PollValues.Bottom + 10

        'LED Status: a lamp and a Set State box for each LED
        Y = RowTop
        For Index = 0 To Leds.Count - 1
            Dim Led = Leds(Index)
            Dim Lamp As New LedLamp With {.LampColour = LedLamp.ColourFromName(Led.Colour), .Location = New Point(14, Y + 2)}
            Dim Check As New CheckBox With {
                .Text = "Set " & Describe(Led.Name, Led.IO),
                .Font = RowFont,
                .Location = New Point(44, Y),
                .Size = New Size(LeftWidth - 50, 24),
                .Enabled = False,
                .Tag = Index,
                .UseVisualStyleBackColor = True}
            AddHandler Check.CheckedChanged, AddressOf SetDeviceStatusCheckedChangedHighOn_UserSolution
            groupBox3.Controls.Add(Lamp)
            groupBox3.Controls.Add(Check)
            LedLamps.Add(Lamp)
            LedChecks.Add(Check)
            Y += LedRowHeight
        Next
        If Leds.Count = 0 Then
            groupBox3.Controls.Add(New Label With {.Text = "No LEDs on this board", .Font = RowFont, .Location = New Point(19, Y), .Size = New Size(LeftWidth - 30, 15)})
            Y += LedRowHeight
        End If
        groupBox3.Height = Y + 6

        groupBox2.Top = groupBoxBoard.Bottom + GroupGap
        groupBox3.Top = groupBox2.Bottom + GroupGap

        'The right side: the board's name, its help text, and its pin tables
        If Board Is Nothing Then
            GroupBox_Board.Text = "No board selected"
            textBox_Body.Text = "Select the board type in use, or add one to " & BoardConfig.DefaultPath() & " and select Reload file."
            textBox_LEDs.Text = ""
            textBox_Inputs.Text = ""
        Else
            GroupBox_Board.Text = Board.Name
            textBox_Body.Text = Board.BodyText
            textBox_LEDs.Text = LedTable()
            textBox_Inputs.Text = InputTable()
        End If

        Dim LineHeight = TextRenderer.MeasureText("X", textBox_LEDs.Font).Height
        textBox_LEDs.Height = LineCount(textBox_LEDs.Text) * LineHeight + 4
        textBox_Inputs.Height = LineCount(textBox_Inputs.Text) * LineHeight + 4

        'The help text gets the room the tables leave, at least 200 high; the form fits the taller side
        Dim LeftBottom = groupBox3.Bottom
        Dim TablesHeight = textBox_LEDs.Height + 6 + textBox_Inputs.Height
        Dim BoxHeight = Math.Max(LeftBottom - GroupBox_Board.Top, 447)
        Dim BodyHeight = BoxHeight - 16 - TablesHeight - 18
        If BodyHeight < 200 Then
            BodyHeight = 200
            BoxHeight = 16 + BodyHeight + TablesHeight + 18
        End If
        textBox_Body.Height = BodyHeight
        textBox_LEDs.Top = textBox_Body.Bottom + 6
        textBox_Inputs.Top = textBox_LEDs.Bottom + 6
        GroupBox_Board.Height = BoxHeight

        Dim FooterTop = Math.Max(LeftBottom, GroupBox_Board.Bottom)
        VenPidText.Top = FooterTop
        footerRightText.Top = FooterTop
        ClientSize = New Size(ClientSize.Width, FooterTop + FooterHeight)

        ResumeLayout()
        EnsureOnScreen()
        StopSwitchPoll()
    End Sub

    'A label and a value box in the Input Port State group; a switch also gets a lamp (white = 1, black ring = 0)
    Private Sub AddInputRow(Y As Integer, Caption As String, Tip As String, RowFont As Font, Values As List(Of TextBox), Optional Lamps As List(Of LedLamp) = Nothing)
        Dim LabelLeft = 19
        If Lamps IsNot Nothing Then
            Dim Lamp As New LedLamp With {.LampColour = Color.White, .HollowWhenOff = True, .Size = New Size(16, 16), .Location = New Point(17, Y - 2)}
            InputTips.SetToolTip(Lamp, Tip)
            groupBox2.Controls.Add(Lamp)
            Lamps.Add(Lamp)
            LabelLeft = 40
        End If
        Dim Name As New Label With {.Text = Caption, .Font = RowFont, .Location = New Point(LabelLeft, Y), .Size = New Size(LeftWidth - 71 - LabelLeft, 15)}
        Dim Value As New TextBox With {
            .Text = "-",
            .Font = RowFont,
            .BorderStyle = BorderStyle.None,
            .ReadOnly = True,
            .TextAlign = HorizontalAlignment.Right,
            .Location = New Point(LeftWidth - 70, Y),
            .Size = New Size(56, 13)}
        InputTips.SetToolTip(Name, Tip)
        InputTips.SetToolTip(Value, Tip)
        groupBox2.Controls.Add(Name)
        groupBox2.Controls.Add(Value)
        Values.Add(Value)
    End Sub

    '"Switch 1 (I/O 5)", or just the name when there is no I/O
    Private Shared Function Describe(Name As String, IO As String) As String
        If String.IsNullOrEmpty(IO) OrElse String.Equals(Name, IO, StringComparison.OrdinalIgnoreCase) Then Return Name
        Return Name & " (" & IO & ")"
    End Function

    Private Shared Function LineCount(Text As String) As Integer
        If Text = "" Then Return 0
        Return Text.Split(New String() {vbCrLf}, StringSplitOptions.None).Length
    End Function

    'The pin table of the LEDs, with their request codes
    Private Function LedTable() As String
        Dim Table As New System.Text.StringBuilder
        Table.AppendLine("LEDs")
        Table.AppendLine()
        Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3}", "Name", "Port", "I/O", "Requests read/on/off"))
        If Board.KeepAlive IsNot Nothing Then
            Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3}", Board.KeepAlive.Name, Board.KeepAlive.Port, Board.KeepAlive.IO, CONSTDEVICEKEEPALIVE & " (toggles)"))
        End If
        For Each Led In Board.Leds
            Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3}/{4}/{5}", Led.Name, Led.Port, Led.IO, Led.UsbCodeRead, Led.UsbCodeOn, Led.UsbCodeOff))
        Next
        If Board.Leds.Count = 0 Then Table.AppendLine("  (none)")
        Return Table.ToString().TrimEnd()
    End Function

    'The pin table of the switches and the ADC channels, with their request codes
    Private Function InputTable() As String
        Dim Table As New System.Text.StringBuilder
        Table.AppendLine("Inputs (the lamp is on when the switch reads its On value)")
        Table.AppendLine()
        Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3,-15}{4}", "Name", "Port", "I/O", "Request, byte", "On"))
        For Each Switch In Board.Switches
            Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3,-15}{4}", Switch.Name, Switch.Port, Switch.IO, Switch.UsbCode & ", " & Switch.ReplyByte, Switch.OnValue))
        Next
        If Board.Switches.Count = 0 Then Table.AppendLine("  (none)")
        If Board.Adcs.Count > 0 Then
            Table.AppendLine()
            Table.AppendLine("ADC")
            Table.AppendLine()
            Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3,-10}{4}", "Name", "Port", "Channel", "Range", "Request, byte"))
            For Each Adc In Board.Adcs
                Table.AppendLine(String.Format("  {0,-14}{1,-10}{2,-8}{3,-10}{4}, {5}", Adc.Name, Adc.Port, Adc.Channel, "0-" & Adc.RangeMax, Adc.UsbCode, Adc.ReplyByte))
            Next
        End If
        Return Table.ToString().TrimEnd()
    End Function



    'User Interaceface methods


    Public Sub UpdateFormWithLatestData_UserSolution()

        Try
            'Update  application
            If Not Device Is Nothing Then
                ConnectionStatus.Text = "USB device connected"

                'Update the UI
                ConnectionStatus.BackColor = System.Drawing.Color.LimeGreen
                ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.None

                'If we are init or reinit USB channel so get the LED state from the USB
                If GetStatusfromDeviceUponInit = True Then
                    'We need the removed board to be settled. 1s should be enough.
                    Delay(1)
                    ReadLedStates()
                    'And the switches, so their state shows without Read
                    PollValuesClick_UserSolution(Me, EventArgs.Empty)
                    GetStatusfromDeviceUponInit = False
                End If

                'Update some text: the board's program names its chip in the product string ("GCBASIC WinUSB 18F4550")
                Dim Product = Device.Info.ProductString
                If Board Is Nothing OrElse Board.Matches(Product) Then
                    VenPidText.Text = Product
                    VenPidText.ForeColor = SystemColors.ControlText
                Else
                    VenPidText.Text = Product & " - not the board type in use (" & Board.Id & ")"
                    VenPidText.ForeColor = Color.Firebrick
                End If
                'Update the timeout string
                footerRightText.Text = StrDup(KeepAliveCounter, ".") + orginalfooterRightText
                'Enable the UI
                PollValues.Enabled = SwitchValues.Count + AdcValues.Count > 0
                PollToggle.Enabled = CanPoll()
                For Each Check In LedChecks
                    Check.Enabled = True
                Next

            Else

                ConnectionStatus.Text = "USB device not connected"
                'Paint Red
                If ConnectionStatus.BackColor <> System.Drawing.Color.Red Then
                    ConnectionStatus.BackColor = System.Drawing.Color.Red
                Else
                    ConnectionStatus.BackColor = Me.BackColor
                End If
                ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
                VenPidText.Text = ""
                'Only when the focus is on a control that is disabled below: every second, it would take the focus
                'from the board list (and close it), so the board could not be changed while disconnected
                Dim Focused = ActiveControl
                If Focused Is PollValues OrElse Focused Is PollToggle OrElse TypeOf Focused Is CheckBox Then ConnectionStatus.Select()

                'Disable the UI
                PollValues.Enabled = False
                'The board has gone: the poll stops, Start Poll starts it again
                If SwitchPoll.Enabled Then StopSwitchPoll()
                PollToggle.Enabled = False
                For Each Check In LedChecks
                    Check.Enabled = False
                Next
            End If
        Catch
            'exit gracefully
        End Try

        'Anyway we have updated the form!!!

    End Sub 'UpdateFormWithLatestData

    'Read the state of each LED of the board, and show it
    Sub ReadLedStates()
        If Board Is Nothing Then Return
        UpdatingLeds = True
        Try
            For Index = 0 To Math.Min(Board.Leds.Count, LedChecks.Count) - 1
                Dim IsOn = ReadDeviceBitStatus_UserSolution(Board.Leds(Index).UsbCodeRead)
                LedChecks(Index).Checked = IsOn
                LedLamps(Index).IsOn = IsOn
            Next
        Finally
            UpdatingLeds = False
        End Try
    End Sub

    'Read button was clicked: read the switches and the ADC channels.
    'Each request is sent once, for all the switches or channels that use it.
    Sub PollValuesClick_UserSolution(sender As Object, e As EventArgs) Handles PollValues.Click
        If Board Is Nothing Then Return
        Dim Replies As New Dictionary(Of Byte, Byte())

        ReadSwitches(Replies)

        For Index = 0 To Math.Min(Board.Adcs.Count, AdcValues.Count) - 1
            Dim Adc = Board.Adcs(Index)
            Dim Reply = RequestOnce(Replies, Adc.UsbCode)
            If Reply.Length >= Adc.ReplyByte + Adc.ReplyBytes Then
                Dim Value As Integer = Reply(Adc.ReplyByte)
                If Adc.ReplyBytes = 2 Then Value += 256 * Reply(Adc.ReplyByte + 1)
                AdcValues(Index).Text = Value.ToString
            Else
                AdcValues(Index).Text = "-"
            End If
        Next
    End Sub

    'Read the switches and show them: the value, and the lamp on when the value is the switch's OnValue
    Sub ReadSwitches(Replies As Dictionary(Of Byte, Byte()))
        For Index = 0 To Math.Min(Board.Switches.Count, SwitchValues.Count) - 1
            Dim Switch = Board.Switches(Index)
            Dim Reply = RequestOnce(Replies, Switch.UsbCode)
            If Reply.Length > Switch.ReplyByte Then
                SwitchValues(Index).Text = Reply(Switch.ReplyByte).ToString
                SwitchLamps(Index).IsOn = Reply(Switch.ReplyByte) = Switch.OnValue
            Else
                SwitchValues(Index).Text = "-"
                SwitchLamps(Index).IsOn = False
            End If
        Next
    End Sub

    'Poll the switches every SwitchPollSeconds (from the board file) while the board is connected.
    'The poll is not a keep-alive: the keep-alive count is kept, so the keep-alive still runs every 10 s.
    Private Sub SwitchPoll_Tick(sender As Object, e As EventArgs) Handles SwitchPoll.Tick
        If Board Is Nothing OrElse Device Is Nothing Then Return
        Dim SavedCount = KeepAliveCounter
        ReadSwitches(New Dictionary(Of Byte, Byte()))
        KeepAliveCounter = SavedCount
    End Sub

    'The board in use has switches and a poll period (switchPollSeconds in the board file)
    Function CanPoll() As Boolean
        Return Board IsNot Nothing AndAlso Board.SwitchPollSeconds > 0 AndAlso SwitchValues.Count > 0
    End Function

    'Start Poll / End Poll was clicked. The poll never starts by itself.
    Private Sub PollToggle_Click(sender As Object, e As EventArgs) Handles PollToggle.Click
        If SwitchPoll.Enabled Then
            StopSwitchPoll()
        ElseIf CanPoll() Then
            SwitchPoll.Interval = Board.SwitchPollSeconds * 1000
            SwitchPoll.Start()
            PollToggle.Text = "End Poll"
            groupBox2.Text = "Input Port State (poll " & Board.SwitchPollSeconds & " s)"
            'Read now, then every period
            SwitchPoll_Tick(Me, EventArgs.Empty)
        End If
    End Sub

    'Stop the switch poll (a board was selected, the board has gone, or End Poll)
    Sub StopSwitchPoll()
        SwitchPoll.Stop()
        PollToggle.Text = If(CanPoll(), "Start Poll (" & Board.SwitchPollSeconds & " s)", "Start Poll")
        groupBox2.Text = "Input Port State"
    End Sub

    'The largest reply a request may have: the full-speed control endpoint size
    Private Const MaxReplySize As Short = 64

    'The reply to a request, sent once per Read. It asks for up to MaxReplySize bytes, not only the bytes the board file
    'uses: the firmware sends all its bytes (four for request 140), and a transfer asking for fewer fails.
    Private Function RequestOnce(Replies As Dictionary(Of Byte, Byte()), UsbCode As Byte) As Byte()
        Dim Reply As Byte() = Nothing
        If Replies.TryGetValue(UsbCode, Reply) Then Return Reply

        Reply = ReadReplyData(UsbCode, MaxReplySize)
        If Reply Is Nothing Then Reply = New Byte() {}
        Replies(UsbCode) = Reply
        Return Reply
    End Function



    'Status of the check changed, send commands to turn bits on the PIC on or off
    Sub SetDeviceStatusCheckedChangedHighOn_UserSolution(sender As Object, e As EventArgs)
        If UpdatingLeds OrElse Board Is Nothing Then Return
        Dim Check = DirectCast(sender, CheckBox)
        Dim Index = CInt(Check.Tag)
        If Index >= Board.Leds.Count Then Return
        Dim Led = Board.Leds(Index)

        If Check.Checked Then
            'To turn on, PIC expects request
            SendCommand(Led.UsbCodeOn, DEVICEBITON)
        Else
            'To turn off, PIC expects request
            SendCommand(Led.UsbCodeOff, DEVICEBITOFF)
        End If
        LedLamps(Index).IsOn = Check.Checked
    End Sub

    'Read the status of a Bit and return the value
    Function ReadDeviceBitStatus_UserSolution(USBDeviceRequestID As Byte) As Boolean

        Dim Reply As Byte()

        'Send USBDeviceRequestID. Read 1 byte back.
        Reply = ReadReplyData(USBDeviceRequestID, 1)
        If Not Reply Is Nothing AndAlso Reply.Length > 0 Then
            'If there is a reply
            If Reply(0) = 1 Then

                Return True

            End If
        End If

        Return False

    End Function

    'Everything after this should not be changed.

    'Utility functions

    'Find the USB device - do not change
    Function FindUSBDevice() As Boolean

        'Find device
        Dim Finder As New UsbDeviceFinder(USB_VID, USB_PID, USB_REV)

        Try
            Device = UsbDevice.OpenUsbDevice(Finder)
        Catch
            Device = Nothing
        End Try

        If Not Device Is Nothing Then
            GetStatusfromDeviceUponInit = True
        End If

        Return Not Device Is Nothing
    End Function

    'Send a command (control transfer) to the device, no reply expected - do not change
    Sub SendCommand(Request As Byte, Param As Short)

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Exit Sub

        Try
            'Create setup packet
            'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
            '66 means:
            '          Data direction is host to device
            '          Request type is vendor defined (ie, by us)
            '          Packet is sent to the whole device, not a specific endpoint
            'This should be suitable for any cases when data is being sent to the PIC.
            Dim SetupPacket As New UsbSetupPacket(66, Request, Param, 0, 0)
            'Dummy variables for data to send (none in this case)
            Dim InBuffer(1024) As Byte
            Dim inCount As Integer = 0
            'Send command
            Device.ControlTransfer(SetupPacket, InBuffer, 1000, inCount)
        Catch
            'The device has gone: close it, the 1s timer finds it again when it is back
            CloseDevice()
        End Try

        KeepAliveCounter = 0
        _timer.Interval = 1000
        _timer.Enabled = True

    End Sub

    'Send a control transfer and get data from device - returns the bytes received (none when it fails)
    Function ReadReplyData(Request As Byte, ReplySize As Short) As Byte()

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Return Nothing

        'Create setup packet
        'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
        '194 means:
        '          Data direction is device to host
        '          Request type is vendor defined (ie, by us)
        '          Packet is sent to the whole device, not a specific endpoint
        'This should be suitable for any cases when data is being read from the PIC.
        'Last parameter is the number of bytes to request back - device may ignore.
        Dim SetupPacket As New UsbSetupPacket(194, Request, 0, 0, ReplySize)
        'Prepare buffers for incoming data
        Dim InBuffer(1024) As Byte
        Dim copyLoc As Integer
        Dim inCount As Integer

        Try
            'Start control transfer
            Device.ControlTransfer(SetupPacket, InBuffer, ReplySize, inCount)
        Catch
            'The device has gone: close it, the 1s timer finds it again when it is back
            inCount = 0
            CloseDevice()
        End Try
        'Create an output array of the bytes received, fill with the data
        Dim OutBuffer(inCount - 1) As Byte
        For copyLoc = 0 To inCount - 1
            OutBuffer(copyLoc) = InBuffer(copyLoc)
        Next

        KeepAliveCounter = 0
        'Set the 1s timer
        _timer.Interval = 1000
        _timer.Enabled = True

        Return OutBuffer
    End Function


    'KeepAlive Check Send the constant 'CONSTDEVICEKEEPALIVE' and expect 'CONSTDEVICEKEEPALIVE' back - do not change
    Sub PollKeepAlive()
        Dim Reply As Byte()
        KeepAliveError = False
        'Send request CONSTDEVICEKEEPALIVE, which means KEEPALIVE. Read 1 byte back.
        Reply = ReadReplyData(CONSTDEVICEKEEPALIVE, 1)

        'No reply, or not the keep-alive: close the device, the 1s timer finds it again
        If Reply Is Nothing OrElse Reply.Length = 0 OrElse Reply(0) <> CONSTDEVICEKEEPALIVE Then
            KeepAliveError = True
            CloseDevice()
        Else
            tempvalue = Reply(0)
        End If
    End Sub

    'Close the device after an error or a failed keep-alive (recovery: the 1s timer opens it again when it answers)
    Sub CloseDevice()
        Try
            If Not Device Is Nothing Then Device.Close()
        Catch
            'exit gracefully
        End Try
        Device = Nothing
        GetStatusfromDeviceUponInit = True
    End Sub


    'On close of main form, close USB device - do not change
    Sub MainFormFormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        'Close USB device if one was opened
        If Not Device Is Nothing Then
            Device.Close()
        End If

        Try
            ' Disable the device notifier
            UsbDeviceNotifier.Enabled = False
            ' Unhook the device notifier event
            RemoveHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised
        Catch
            'exit gracefully
        End Try

    End Sub

    'Event methods
    ' USB event - do not change
    Sub OnUSBDeviceEventRaised(sender As Object, e As DeviceNotifyEventArgs)
        ' A Device system-level event has occured

        Try
            If (e.Device.IdProduct = USB_PID) And (e.Device.IdVendor = USB_VID) Then

                If (e.EventType = &H8004) Then

                    If Not Device Is Nothing Then
                        Device.Close()
                        Device = Nothing
                    End If
                    ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))

                End If
            End If
        Catch
            'exit gracefully
        End Try

    End Sub

    'Timer functions  - do not change

    Public Sub OneSecondTimerHandler(ByVal sender As Object, ByVal e As ElapsedEventArgs)


        Try
            _timer.Enabled = False

            ' If the Device has gone off line the device is nothing
            If Device Is Nothing Then
                'Find USB device
                FindUSBDevice()
                'If the Device has been located then.. poll it, if the poll fails then Device will be set to Nothing, so, dont set the keep alive as need it to keep retrying
                If Not Device Is Nothing Then
                    PollKeepAlive()
                    If Not Device Is Nothing Then
                        'time out the keepalive
                        KeepAliveCounter = 9
                    End If
                End If

            End If

            If Not Device Is Nothing Then
                'every 10 seconds poll the device
                If KeepAliveCounter = 9 Then
                    PollKeepAlive()
                    KeepAliveCounter = 0
                Else
                    KeepAliveCounter = KeepAliveCounter + 1
                End If
            Else
                'Will keep re-trying keep alive, only if, the USB is active.
                KeepAliveCounter = 9
            End If

            _timer.Interval = 1000
            _timer.Enabled = True
            ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))
        Finally
            'exit gracefully
        End Try

    End Sub


    Private Sub Delay(ByVal DelayInSeconds As Integer)
        Dim ts As TimeSpan
        Dim targetTime As DateTime = DateTime.Now.AddSeconds(DelayInSeconds)
        Do
            ts = targetTime.Subtract(DateTime.Now)
            'Application.DoEvents() ' keep app responsive
            System.Threading.Thread.Sleep(50) ' reduce CPU usage
        Loop While ts.TotalSeconds > 0
    End Sub

End Class

