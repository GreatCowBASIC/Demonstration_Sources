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
    ''' The containers only: their switches, LEDs, ADC values and texts come from BoardTypes.json (BuildBoardUI).
    ''' </summary>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MainForm))
        Me.groupBox1 = New System.Windows.Forms.GroupBox()
        Me.ConnectionStatus = New System.Windows.Forms.Label()
        Me.groupBoxBoard = New System.Windows.Forms.GroupBox()
        Me.BoardSelect = New System.Windows.Forms.ComboBox()
        Me.ReloadBoards = New System.Windows.Forms.Button()
        Me.EditBoards = New System.Windows.Forms.Button()
        Me.groupBox2 = New System.Windows.Forms.GroupBox()
        Me.PollValues = New System.Windows.Forms.Button()
        Me.PollToggle = New System.Windows.Forms.Button()
        Me.groupBox3 = New System.Windows.Forms.GroupBox()
        Me.GroupBox_Board = New System.Windows.Forms.GroupBox()
        Me.textBox_Body = New System.Windows.Forms.TextBox()
        Me.textBox_LEDs = New System.Windows.Forms.TextBox()
        Me.textBox_Inputs = New System.Windows.Forms.TextBox()
        Me.footerRightText = New System.Windows.Forms.Label()
        Me.VenPidText = New System.Windows.Forms.Label()
        Me.notifyIcon1 = New System.Windows.Forms.NotifyIcon(Me.components)
        Me.groupBox1.SuspendLayout()
        Me.groupBoxBoard.SuspendLayout()
        Me.groupBox2.SuspendLayout()
        Me.GroupBox_Board.SuspendLayout()
        Me.SuspendLayout()
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.ConnectionStatus)
        Me.groupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox1.Location = New System.Drawing.Point(12, 12)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(250, 62)
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
        Me.ConnectionStatus.Size = New System.Drawing.Size(218, 26)
        Me.ConnectionStatus.TabIndex = 0
        Me.ConnectionStatus.Text = "USB device not connected"
        Me.ConnectionStatus.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'groupBoxBoard
        '
        Me.groupBoxBoard.Controls.Add(Me.BoardSelect)
        Me.groupBoxBoard.Controls.Add(Me.ReloadBoards)
        Me.groupBoxBoard.Controls.Add(Me.EditBoards)
        Me.groupBoxBoard.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBoxBoard.Location = New System.Drawing.Point(12, 80)
        Me.groupBoxBoard.Name = "groupBoxBoard"
        Me.groupBoxBoard.Size = New System.Drawing.Size(250, 82)
        Me.groupBoxBoard.TabIndex = 10
        Me.groupBoxBoard.TabStop = False
        Me.groupBoxBoard.Text = "Board Type in use"
        '
        'BoardSelect
        '
        Me.BoardSelect.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.BoardSelect.DropDownWidth = 320
        Me.BoardSelect.FormattingEnabled = True
        Me.BoardSelect.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BoardSelect.Location = New System.Drawing.Point(10, 20)
        Me.BoardSelect.Name = "BoardSelect"
        Me.BoardSelect.Size = New System.Drawing.Size(230, 21)
        Me.BoardSelect.TabIndex = 0
        '
        'ReloadBoards
        '
        Me.ReloadBoards.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ReloadBoards.Location = New System.Drawing.Point(10, 48)
        Me.ReloadBoards.Name = "ReloadBoards"
        Me.ReloadBoards.Size = New System.Drawing.Size(110, 24)
        Me.ReloadBoards.TabIndex = 1
        Me.ReloadBoards.Text = "Reload file"
        Me.ReloadBoards.UseVisualStyleBackColor = True
        '
        'EditBoards
        '
        Me.EditBoards.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.EditBoards.Location = New System.Drawing.Point(130, 48)
        Me.EditBoards.Name = "EditBoards"
        Me.EditBoards.Size = New System.Drawing.Size(110, 24)
        Me.EditBoards.TabIndex = 2
        Me.EditBoards.Text = "Edit file"
        Me.EditBoards.UseVisualStyleBackColor = True
        '
        'groupBox2
        '
        Me.groupBox2.Controls.Add(Me.PollValues)
        Me.groupBox2.Controls.Add(Me.PollToggle)
        Me.groupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox2.Location = New System.Drawing.Point(12, 168)
        Me.groupBox2.Name = "groupBox2"
        Me.groupBox2.Size = New System.Drawing.Size(250, 163)
        Me.groupBox2.TabIndex = 7
        Me.groupBox2.TabStop = False
        Me.groupBox2.Text = "Input Port State"
        '
        'PollValues
        '
        Me.PollValues.Enabled = False
        Me.PollValues.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.PollValues.Location = New System.Drawing.Point(61, 129)
        Me.PollValues.Name = "PollValues"
        Me.PollValues.Size = New System.Drawing.Size(128, 24)
        Me.PollValues.TabIndex = 9
        Me.PollValues.Text = "Read"
        Me.PollValues.UseVisualStyleBackColor = True
        '
        'PollToggle
        '
        Me.PollToggle.Enabled = False
        Me.PollToggle.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.PollToggle.Location = New System.Drawing.Point(130, 129)
        Me.PollToggle.Name = "PollToggle"
        Me.PollToggle.Size = New System.Drawing.Size(105, 24)
        Me.PollToggle.TabIndex = 10
        Me.PollToggle.Text = "Start Poll"
        Me.PollToggle.UseVisualStyleBackColor = True
        '
        'groupBox3
        '
        Me.groupBox3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox3.Location = New System.Drawing.Point(12, 337)
        Me.groupBox3.Name = "groupBox3"
        Me.groupBox3.Size = New System.Drawing.Size(250, 110)
        Me.groupBox3.TabIndex = 8
        Me.groupBox3.TabStop = False
        Me.groupBox3.Text = "LED Status"
        '
        'GroupBox_Board
        '
        Me.GroupBox_Board.Controls.Add(Me.textBox_Body)
        Me.GroupBox_Board.Controls.Add(Me.textBox_LEDs)
        Me.GroupBox_Board.Controls.Add(Me.textBox_Inputs)
        Me.GroupBox_Board.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox_Board.Location = New System.Drawing.Point(270, 4)
        Me.GroupBox_Board.Name = "GroupBox_Board"
        Me.GroupBox_Board.Size = New System.Drawing.Size(500, 447)
        Me.GroupBox_Board.TabIndex = 16
        Me.GroupBox_Board.TabStop = False
        Me.GroupBox_Board.Text = "No board selected"
        '
        'textBox_Body
        '
        Me.textBox_Body.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.textBox_Body.Location = New System.Drawing.Point(6, 16)
        Me.textBox_Body.Multiline = True
        Me.textBox_Body.Name = "textBox_Body"
        Me.textBox_Body.ReadOnly = True
        Me.textBox_Body.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.textBox_Body.Size = New System.Drawing.Size(488, 280)
        Me.textBox_Body.TabIndex = 10
        '
        'textBox_LEDs
        '
        Me.textBox_LEDs.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_LEDs.Font = New System.Drawing.Font("Courier New", 7.5!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.textBox_LEDs.Location = New System.Drawing.Point(10, 300)
        Me.textBox_LEDs.Multiline = True
        Me.textBox_LEDs.Name = "textBox_LEDs"
        Me.textBox_LEDs.ReadOnly = True
        Me.textBox_LEDs.Size = New System.Drawing.Size(480, 70)
        Me.textBox_LEDs.TabIndex = 11
        Me.textBox_LEDs.WordWrap = False
        '
        'textBox_Inputs
        '
        Me.textBox_Inputs.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.textBox_Inputs.Font = New System.Drawing.Font("Courier New", 7.5!)
        Me.textBox_Inputs.Location = New System.Drawing.Point(10, 372)
        Me.textBox_Inputs.Multiline = True
        Me.textBox_Inputs.Name = "textBox_Inputs"
        Me.textBox_Inputs.ReadOnly = True
        Me.textBox_Inputs.Size = New System.Drawing.Size(480, 70)
        Me.textBox_Inputs.TabIndex = 12
        Me.textBox_Inputs.WordWrap = False
        '
        'footerRightText
        '
        Me.footerRightText.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.footerRightText.Location = New System.Drawing.Point(694, 451)
        Me.footerRightText.Name = "footerRightText"
        Me.footerRightText.Size = New System.Drawing.Size(100, 19)
        Me.footerRightText.TabIndex = 9
        Me.footerRightText.Text = "v3.0.0"
        Me.footerRightText.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'VenPidText
        '
        Me.VenPidText.Location = New System.Drawing.Point(15, 451)
        Me.VenPidText.Name = "VenPidText"
        Me.VenPidText.Size = New System.Drawing.Size(520, 19)
        Me.VenPidText.TabIndex = 9
        Me.VenPidText.Text = "Initialising ..."
        Me.VenPidText.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'notifyIcon1
        '
        Me.notifyIcon1.Text = "notifyIcon1"
        Me.notifyIcon1.Visible = True
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(778, 472)
        Me.Controls.Add(Me.footerRightText)
        Me.Controls.Add(Me.VenPidText)
        Me.Controls.Add(Me.groupBox3)
        Me.Controls.Add(Me.groupBox2)
        Me.Controls.Add(Me.groupBoxBoard)
        Me.Controls.Add(Me.groupBox1)
        Me.Controls.Add(Me.GroupBox_Board)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.KeyPreview = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "MainForm"
        Me.Text = "GCBASIC WinUSB Demo Program - no driver"
        Me.groupBox1.ResumeLayout(False)
        Me.groupBoxBoard.ResumeLayout(False)
        Me.groupBox2.ResumeLayout(False)
        Me.GroupBox_Board.ResumeLayout(False)
        Me.GroupBox_Board.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Private notifyIcon1 As System.Windows.Forms.NotifyIcon
    Private VenPidText As System.Windows.Forms.Label
    Private ConnectionStatus As System.Windows.Forms.Label
    Private footerRightText As System.Windows.Forms.Label
    Private groupBox1 As System.Windows.Forms.GroupBox
    Private groupBox2 As System.Windows.Forms.GroupBox
    Private groupBox3 As System.Windows.Forms.GroupBox
    Private WithEvents PollValues As Button
    Private WithEvents PollToggle As Button
    Private groupBoxBoard As GroupBox
    Private WithEvents BoardSelect As ComboBox
    Private WithEvents ReloadBoards As Button
    Private WithEvents EditBoards As Button
    Private GroupBox_Board As GroupBox
    Private textBox_Body As TextBox
    Private textBox_LEDs As TextBox
    Private textBox_Inputs As TextBox
End Class
