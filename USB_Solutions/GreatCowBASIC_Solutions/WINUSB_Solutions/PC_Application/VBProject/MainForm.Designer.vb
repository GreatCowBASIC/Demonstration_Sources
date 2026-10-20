'
' Created by SharpDevelop.
' User: admin
' Date: 01/06/2018
' Time: 20:17
' 
' To change this template use Tools | Options | Coding | Edit Standard Headers.
'
Partial Class MainForm
    Inherits System.Windows.Forms.Form

    ''' <summary>
    ''' Designer variable used to keep track of non-visual components.
    ''' </summary>
    Private components As System.ComponentModel.IContainer

    ''' <summary>
    ''' Disposes resources used by the form.
    ''' </summary>
    ''' <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If components IsNot Nothing Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    ''' <summary>
    ''' This method is required for Windows Forms designer support.
    ''' Do not change the method contents inside the source code editor. The Forms designer might
    ''' not be able to load this method if it was changed manually.
    ''' </summary>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MainForm))
        Me.groupBox1 = New System.Windows.Forms.GroupBox()
        Me.ConnectionStatus = New System.Windows.Forms.Label()
        Me.groupBox2 = New System.Windows.Forms.GroupBox()
        Me.PollValues = New System.Windows.Forms.Button()
        Me.IO4Value = New System.Windows.Forms.TextBox()
        Me.label4 = New System.Windows.Forms.Label()
        Me.IO3Value = New System.Windows.Forms.TextBox()
        Me.label3 = New System.Windows.Forms.Label()
        Me.IO2Value = New System.Windows.Forms.TextBox()
        Me.label2 = New System.Windows.Forms.Label()
        Me.IO1Value = New System.Windows.Forms.TextBox()
        Me.label1 = New System.Windows.Forms.Label()
        Me.groupBox3 = New System.Windows.Forms.GroupBox()
        Me.BlackLED3 = New System.Windows.Forms.PictureBox()
        Me.BlackLED2 = New System.Windows.Forms.PictureBox()
        Me.GreenLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus2 = New System.Windows.Forms.CheckBox()
        Me.YellowLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus1 = New System.Windows.Forms.CheckBox()
        Me.BlackLED1 = New System.Windows.Forms.PictureBox()
        Me.RedLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus3 = New System.Windows.Forms.CheckBox()
        Me.footerRightText = New System.Windows.Forms.Label()
        Me.textBox_1Switch = New System.Windows.Forms.TextBox()
        Me.VenPidText = New System.Windows.Forms.Label()
        Me.notifyIcon1 = New System.Windows.Forms.NotifyIcon(Me.components)
        Me.textBox_LEDs_1Switch = New System.Windows.Forms.TextBox()
        Me.textBox_Inputs_4Switches = New System.Windows.Forms.TextBox()
        Me.textBox_Inputs_1Switch = New System.Windows.Forms.TextBox()
        Me.textBox_4Switches = New System.Windows.Forms.TextBox()
        Me.textBox_LEDs_4Switches = New System.Windows.Forms.TextBox()
        Me.GroupBox_1Switch = New System.Windows.Forms.GroupBox()
        Me.GroupBox_4Switches = New System.Windows.Forms.GroupBox()
        Me.groupBox1.SuspendLayout()
        Me.groupBox2.SuspendLayout()
        Me.groupBox3.SuspendLayout()
        CType(Me.BlackLED3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GreenLED, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.YellowLED, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RedLED, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox_1Switch.SuspendLayout()
        Me.GroupBox_4Switches.SuspendLayout()
        Me.SuspendLayout()
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.ConnectionStatus)
        Me.groupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox1.Location = New System.Drawing.Point(12, 12)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(168, 67)
        Me.groupBox1.TabIndex = 6
        Me.groupBox1.TabStop = False
        Me.groupBox1.Text = "USB Connection Status"
        '
        'ConnectionStatus
        '
        Me.ConnectionStatus.BackColor = System.Drawing.Color.Red
        Me.ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ConnectionStatus.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ConnectionStatus.Location = New System.Drawing.Point(16, 24)
        Me.ConnectionStatus.Name = "ConnectionStatus"
        Me.ConnectionStatus.Size = New System.Drawing.Size(144, 26)
        Me.ConnectionStatus.TabIndex = 0
        Me.ConnectionStatus.Text = "USB device not connected"
        Me.ConnectionStatus.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'groupBox2
        '
        Me.groupBox2.Controls.Add(Me.PollValues)
        Me.groupBox2.Controls.Add(Me.IO4Value)
        Me.groupBox2.Controls.Add(Me.label4)
        Me.groupBox2.Controls.Add(Me.IO3Value)
        Me.groupBox2.Controls.Add(Me.label3)
        Me.groupBox2.Controls.Add(Me.IO2Value)
        Me.groupBox2.Controls.Add(Me.label2)
        Me.groupBox2.Controls.Add(Me.IO1Value)
        Me.groupBox2.Controls.Add(Me.label1)
        Me.groupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox2.Location = New System.Drawing.Point(12, 85)
        Me.groupBox2.Name = "groupBox2"
        Me.groupBox2.Size = New System.Drawing.Size(168, 163)
        Me.groupBox2.TabIndex = 7
        Me.groupBox2.TabStop = False
        Me.groupBox2.Text = "Input Port State"
        '
        'PollValues
        '
        Me.PollValues.Enabled = False
        Me.PollValues.Location = New System.Drawing.Point(22, 129)
        Me.PollValues.Name = "PollValues"
        Me.PollValues.Size = New System.Drawing.Size(128, 24)
        Me.PollValues.TabIndex = 9
        Me.PollValues.Text = "Read"
        Me.PollValues.UseVisualStyleBackColor = True
        '
        'IO4Value
        '
        Me.IO4Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO4Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO4Value.Location = New System.Drawing.Point(74, 105)
        Me.IO4Value.Name = "IO4Value"
        Me.IO4Value.ReadOnly = True
        Me.IO4Value.Size = New System.Drawing.Size(72, 13)
        Me.IO4Value.TabIndex = 7
        Me.IO4Value.Text = "0"
        Me.IO4Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.IO4Value.Visible = False
        '
        'label4
        '
        Me.label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label4.Location = New System.Drawing.Point(19, 105)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(100, 15)
        Me.label4.TabIndex = 6
        Me.label4.Text = "I/O 8"
        Me.label4.Visible = False
        '
        'IO3Value
        '
        Me.IO3Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO3Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO3Value.Location = New System.Drawing.Point(74, 79)
        Me.IO3Value.Name = "IO3Value"
        Me.IO3Value.ReadOnly = True
        Me.IO3Value.Size = New System.Drawing.Size(72, 13)
        Me.IO3Value.TabIndex = 5
        Me.IO3Value.Text = "0"
        Me.IO3Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.IO3Value.Visible = False
        '
        'label3
        '
        Me.label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label3.Location = New System.Drawing.Point(19, 79)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(100, 15)
        Me.label3.TabIndex = 4
        Me.label3.Text = "I/O 7"
        Me.label3.Visible = False
        '
        'IO2Value
        '
        Me.IO2Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO2Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO2Value.Location = New System.Drawing.Point(74, 54)
        Me.IO2Value.Name = "IO2Value"
        Me.IO2Value.ReadOnly = True
        Me.IO2Value.Size = New System.Drawing.Size(72, 13)
        Me.IO2Value.TabIndex = 3
        Me.IO2Value.Text = "0"
        Me.IO2Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label2
        '
        Me.label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label2.Location = New System.Drawing.Point(19, 54)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(100, 15)
        Me.label2.TabIndex = 2
        Me.label2.Text = "I/O 6"
        '
        'IO1Value
        '
        Me.IO1Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO1Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO1Value.Location = New System.Drawing.Point(74, 28)
        Me.IO1Value.Name = "IO1Value"
        Me.IO1Value.ReadOnly = True
        Me.IO1Value.Size = New System.Drawing.Size(72, 13)
        Me.IO1Value.TabIndex = 1
        Me.IO1Value.Text = "0"
        Me.IO1Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.IO1Value.Visible = False
        '
        'label1
        '
        Me.label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label1.Location = New System.Drawing.Point(19, 28)
        Me.label1.Margin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(100, 15)
        Me.label1.TabIndex = 0
        Me.label1.Text = "I/O 5"
        Me.label1.Visible = False
        '
        'groupBox3
        '
        Me.groupBox3.Controls.Add(Me.BlackLED3)
        Me.groupBox3.Controls.Add(Me.BlackLED2)
        Me.groupBox3.Controls.Add(Me.GreenLED)
        Me.groupBox3.Controls.Add(Me.SetLEDStatus2)
        Me.groupBox3.Controls.Add(Me.YellowLED)
        Me.groupBox3.Controls.Add(Me.SetLEDStatus1)
        Me.groupBox3.Controls.Add(Me.BlackLED1)
        Me.groupBox3.Controls.Add(Me.RedLED)
        Me.groupBox3.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.groupBox3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox3.Location = New System.Drawing.Point(18, 254)
        Me.groupBox3.Name = "groupBox3"
        Me.groupBox3.Size = New System.Drawing.Size(162, 171)
        Me.groupBox3.TabIndex = 8
        Me.groupBox3.TabStop = False
        Me.groupBox3.Text = "LED Status"
        '
        'BlackLED3
        '
        Me.BlackLED3.Image = CType(resources.GetObject("BlackLED3.Image"), System.Drawing.Image)
        Me.BlackLED3.Location = New System.Drawing.Point(11, 128)
        Me.BlackLED3.Name = "BlackLED3"
        Me.BlackLED3.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED3.TabIndex = 4
        Me.BlackLED3.TabStop = False
        '
        'BlackLED2
        '
        Me.BlackLED2.Image = CType(resources.GetObject("BlackLED2.Image"), System.Drawing.Image)
        Me.BlackLED2.Location = New System.Drawing.Point(11, 82)
        Me.BlackLED2.Name = "BlackLED2"
        Me.BlackLED2.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED2.TabIndex = 11
        Me.BlackLED2.TabStop = False
        '
        'GreenLED
        '
        Me.GreenLED.Image = CType(resources.GetObject("GreenLED.Image"), System.Drawing.Image)
        Me.GreenLED.Location = New System.Drawing.Point(11, 128)
        Me.GreenLED.Name = "GreenLED"
        Me.GreenLED.Size = New System.Drawing.Size(24, 22)
        Me.GreenLED.TabIndex = 6
        Me.GreenLED.TabStop = False
        '
        'SetLEDStatus2
        '
        Me.SetLEDStatus2.Enabled = False
        Me.SetLEDStatus2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus2.Location = New System.Drawing.Point(47, 82)
        Me.SetLEDStatus2.Name = "SetLEDStatus2"
        Me.SetLEDStatus2.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus2.TabIndex = 5
        Me.SetLEDStatus2.Text = "Set State"
        Me.SetLEDStatus2.UseVisualStyleBackColor = True
        '
        'YellowLED
        '
        Me.YellowLED.Image = CType(resources.GetObject("YellowLED.Image"), System.Drawing.Image)
        Me.YellowLED.Location = New System.Drawing.Point(11, 82)
        Me.YellowLED.Name = "YellowLED"
        Me.YellowLED.Size = New System.Drawing.Size(24, 22)
        Me.YellowLED.TabIndex = 4
        Me.YellowLED.TabStop = False
        '
        'SetLEDStatus1
        '
        Me.SetLEDStatus1.Enabled = False
        Me.SetLEDStatus1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus1.Location = New System.Drawing.Point(47, 35)
        Me.SetLEDStatus1.Name = "SetLEDStatus1"
        Me.SetLEDStatus1.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus1.TabIndex = 3
        Me.SetLEDStatus1.Text = "Set State"
        Me.SetLEDStatus1.UseVisualStyleBackColor = True
        '
        'BlackLED1
        '
        Me.BlackLED1.Image = CType(resources.GetObject("BlackLED1.Image"), System.Drawing.Image)
        Me.BlackLED1.Location = New System.Drawing.Point(11, 35)
        Me.BlackLED1.Name = "BlackLED1"
        Me.BlackLED1.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED1.TabIndex = 2
        Me.BlackLED1.TabStop = False
        '
        'RedLED
        '
        Me.RedLED.Image = CType(resources.GetObject("RedLED.Image"), System.Drawing.Image)
        Me.RedLED.Location = New System.Drawing.Point(11, 36)
        Me.RedLED.Name = "RedLED"
        Me.RedLED.Size = New System.Drawing.Size(24, 22)
        Me.RedLED.TabIndex = 1
        Me.RedLED.TabStop = False
        Me.RedLED.Visible = False
        '
        'SetLEDStatus3
        '
        Me.SetLEDStatus3.Enabled = False
        Me.SetLEDStatus3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus3.Location = New System.Drawing.Point(65, 382)
        Me.SetLEDStatus3.Name = "SetLEDStatus3"
        Me.SetLEDStatus3.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus3.TabIndex = 5
        Me.SetLEDStatus3.Text = "Set State"
        Me.SetLEDStatus3.UseVisualStyleBackColor = True
        '
        'footerRightText
        '
        Me.footerRightText.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.footerRightText.Location = New System.Drawing.Point(610, 451)
        Me.footerRightText.Name = "footerRightText"
        Me.footerRightText.Size = New System.Drawing.Size(72, 19)
        Me.footerRightText.TabIndex = 9
        Me.footerRightText.Text = "v2.1.0"
        Me.footerRightText.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'textBox_1Switch
        '
        Me.textBox_1Switch.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.textBox_1Switch.Location = New System.Drawing.Point(6, 16)
        Me.textBox_1Switch.Multiline = True
        Me.textBox_1Switch.Name = "textBox_1Switch"
        Me.textBox_1Switch.ReadOnly = True
        Me.textBox_1Switch.Size = New System.Drawing.Size(488, 425)
        Me.textBox_1Switch.TabIndex = 10
        Me.textBox_1Switch.Text = resources.GetString("textBox_1Switch.Text")
        '
        'VenPidText
        '
        Me.VenPidText.Location = New System.Drawing.Point(15, 451)
        Me.VenPidText.Name = "VenPidText"
        Me.VenPidText.Size = New System.Drawing.Size(274, 19)
        Me.VenPidText.TabIndex = 9
        Me.VenPidText.Text = "Initialising ..."
        Me.VenPidText.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'notifyIcon1
        '
        Me.notifyIcon1.Text = "notifyIcon1"
        Me.notifyIcon1.Visible = True
        '
        'textBox_LEDs_1Switch
        '
        Me.textBox_LEDs_1Switch.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_LEDs_1Switch.Font = New System.Drawing.Font("Courier New", 7.5!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.textBox_LEDs_1Switch.Location = New System.Drawing.Point(10, 300)
        Me.textBox_LEDs_1Switch.Multiline = True
        Me.textBox_LEDs_1Switch.Name = "textBox_LEDs_1Switch"
        Me.textBox_LEDs_1Switch.ReadOnly = True
        Me.textBox_LEDs_1Switch.Size = New System.Drawing.Size(213, 92)
        Me.textBox_LEDs_1Switch.TabIndex = 11
        Me.textBox_LEDs_1Switch.Text = "LEDs (14K50, 16F145x)" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  KEEPALIVELED  PORTC.0 = I/O 1" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  REDLED        PORTC.1 = I/O 2" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  YELLOWLED     PORTC.2 = I/O 3" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  GREENLED      PORTC.3 = I/O 4" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  Starter Kit 46J50: on its OLED"
        '
        'textBox_Inputs_4Switches
        '
        Me.textBox_Inputs_4Switches.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_Inputs_4Switches.Font = New System.Drawing.Font("Courier New", 7.5!)
        Me.textBox_Inputs_4Switches.Location = New System.Drawing.Point(246, 300)
        Me.textBox_Inputs_4Switches.Multiline = True
        Me.textBox_Inputs_4Switches.Name = "textBox_Inputs_4Switches"
        Me.textBox_Inputs_4Switches.ReadOnly = True
        Me.textBox_Inputs_4Switches.Size = New System.Drawing.Size(233, 92)
        Me.textBox_Inputs_4Switches.TabIndex = 12
        Me.textBox_Inputs_4Switches.Text = "Inputs (switches to 0V, pull-ups)" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  PORTB.4  = I/O 5" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  PORTB.5  = I/O 6" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  PORTB.6  = I/O 7" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  PORTB.7  = I/O 8"
        '
        'textBox_Inputs_1Switch
        '
        Me.textBox_Inputs_1Switch.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_Inputs_1Switch.Font = New System.Drawing.Font("Courier New", 7.5!)
        Me.textBox_Inputs_1Switch.Location = New System.Drawing.Point(246, 300)
        Me.textBox_Inputs_1Switch.Multiline = True
        Me.textBox_Inputs_1Switch.Name = "textBox_Inputs_1Switch"
        Me.textBox_Inputs_1Switch.ReadOnly = True
        Me.textBox_Inputs_1Switch.Size = New System.Drawing.Size(233, 92)
        Me.textBox_Inputs_1Switch.TabIndex = 13
        Me.textBox_Inputs_1Switch.Text = "Input (a switch to 0V, pull-up)" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "        14K50    16F145x  Kit" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  I/O 6 PORTA.3  PORTA.4  MENU"
        '
        'textBox_4Switches
        '
        Me.textBox_4Switches.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.textBox_4Switches.Location = New System.Drawing.Point(6, 16)
        Me.textBox_4Switches.Multiline = True
        Me.textBox_4Switches.Name = "textBox_4Switches"
        Me.textBox_4Switches.ReadOnly = True
        Me.textBox_4Switches.Size = New System.Drawing.Size(488, 425)
        Me.textBox_4Switches.TabIndex = 14
        Me.textBox_4Switches.Text = resources.GetString("textBox_4Switches.Text")
        '
        'textBox_LEDs_4Switches
        '
        Me.textBox_LEDs_4Switches.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_LEDs_4Switches.Font = New System.Drawing.Font("Courier New", 7.5!)
        Me.textBox_LEDs_4Switches.Location = New System.Drawing.Point(10, 300)
        Me.textBox_LEDs_4Switches.Multiline = True
        Me.textBox_LEDs_4Switches.Name = "textBox_LEDs_4Switches"
        Me.textBox_LEDs_4Switches.ReadOnly = True
        Me.textBox_LEDs_4Switches.Size = New System.Drawing.Size(213, 92)
        Me.textBox_LEDs_4Switches.TabIndex = 15
        Me.textBox_LEDs_4Switches.Text = "LEDs (45K50, 4550)" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  KEEPALIVELED  PORTA.4 = I/O 1" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  REDLED        PORTA.5 = I/O 2" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  YELLOWLED     PORTC.0 = I/O 3" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "  GREENLED      PORTC.1 = I/O 4"
        '
        'GroupBox_1Switch
        '
        Me.GroupBox_1Switch.Controls.Add(Me.textBox_LEDs_1Switch)
        Me.GroupBox_1Switch.Controls.Add(Me.textBox_Inputs_1Switch)
        Me.GroupBox_1Switch.Controls.Add(Me.textBox_1Switch)
        Me.GroupBox_1Switch.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox_1Switch.Location = New System.Drawing.Point(186, 4)
        Me.GroupBox_1Switch.Name = "GroupBox_1Switch"
        Me.GroupBox_1Switch.Size = New System.Drawing.Size(500, 447)
        Me.GroupBox_1Switch.TabIndex = 16
        Me.GroupBox_1Switch.TabStop = False
        Me.GroupBox_1Switch.Text = "1 switch"
        '
        'GroupBox_4Switches
        '
        Me.GroupBox_4Switches.Controls.Add(Me.textBox_LEDs_4Switches)
        Me.GroupBox_4Switches.Controls.Add(Me.textBox_Inputs_4Switches)
        Me.GroupBox_4Switches.Controls.Add(Me.textBox_4Switches)
        Me.GroupBox_4Switches.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox_4Switches.Location = New System.Drawing.Point(186, 4)
        Me.GroupBox_4Switches.Name = "GroupBox_4Switches"
        Me.GroupBox_4Switches.Size = New System.Drawing.Size(500, 447)
        Me.GroupBox_4Switches.TabIndex = 17
        Me.GroupBox_4Switches.TabStop = False
        Me.GroupBox_4Switches.Text = "4 switches"
        Me.GroupBox_4Switches.Visible = False
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(694, 472)
        Me.Controls.Add(Me.footerRightText)
        Me.Controls.Add(Me.SetLEDStatus3)
        Me.Controls.Add(Me.VenPidText)
        Me.Controls.Add(Me.groupBox3)
        Me.Controls.Add(Me.groupBox2)
        Me.Controls.Add(Me.groupBox1)
        Me.Controls.Add(Me.GroupBox_1Switch)
        Me.Controls.Add(Me.GroupBox_4Switches)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "MainForm"
        Me.Text = "GCBASIC WinUSB Demo Program - no driver"
        Me.groupBox1.ResumeLayout(False)
        Me.groupBox2.ResumeLayout(False)
        Me.groupBox2.PerformLayout()
        Me.groupBox3.ResumeLayout(False)
        CType(Me.BlackLED3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GreenLED, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.YellowLED, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RedLED, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox_1Switch.ResumeLayout(False)
        Me.GroupBox_1Switch.PerformLayout()
        Me.GroupBox_4Switches.ResumeLayout(False)
        Me.GroupBox_4Switches.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Private BlackLED1 As System.Windows.Forms.PictureBox
    Private RedLED As System.Windows.Forms.PictureBox
    Private notifyIcon1 As System.Windows.Forms.NotifyIcon
    Private VenPidText As System.Windows.Forms.Label
    Private textBox_1Switch As System.Windows.Forms.TextBox
    Private ConnectionStatus As System.Windows.Forms.Label
    Private footerRightText As System.Windows.Forms.Label
    Private groupBox3 As System.Windows.Forms.GroupBox
    Private label2 As System.Windows.Forms.Label
    Private IO2Value As System.Windows.Forms.TextBox
    Private label3 As System.Windows.Forms.Label
    Private IO3Value As System.Windows.Forms.TextBox
    Private label4 As System.Windows.Forms.Label
    Private IO4Value As System.Windows.Forms.TextBox
    Private label1 As System.Windows.Forms.Label
    Private IO1Value As System.Windows.Forms.TextBox
    Private groupBox2 As System.Windows.Forms.GroupBox
    Private groupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents PollValues As Button
    Private WithEvents SetLEDStatus1 As CheckBox
    Private WithEvents GreenLED As PictureBox
    Private WithEvents SetLEDStatus3 As CheckBox
    Private WithEvents BlackLED3 As PictureBox

    Sub FooterRightTextClick(sender As Object, e As EventArgs)

    End Sub

    Private WithEvents SetLEDStatus2 As CheckBox
    Private WithEvents YellowLED As PictureBox
    Private WithEvents BlackLED2 As PictureBox
    Private WithEvents textBox_LEDs_1Switch As TextBox
    Private WithEvents textBox_Inputs_4Switches As TextBox
    Private WithEvents textBox_Inputs_1Switch As TextBox
    Private WithEvents textBox_4Switches As TextBox
    Private WithEvents textBox_LEDs_4Switches As TextBox
    Private WithEvents GroupBox_1Switch As GroupBox
    Private WithEvents GroupBox_4Switches As GroupBox
End Class
