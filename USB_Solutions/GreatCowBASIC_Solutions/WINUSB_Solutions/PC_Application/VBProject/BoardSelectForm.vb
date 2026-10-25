'
' Asks which board type is in use: shown when the board file is new, or the saved board is not in it.
'
' User: Evan R. Venn
' Date: 2026

Public Class BoardSelectForm
    Inherits Form

    Private ReadOnly BoardList As New ListBox
    Private ReadOnly BoardDetails As New Label
    Private ReadOnly OkButton As New Button
    Private ReadOnly CancelButtonControl As New Button

    Public ReadOnly Property SelectedBoard As BoardType
        Get
            Return TryCast(BoardList.SelectedItem, BoardType)
        End Get
    End Property

    'Message: why the question is asked. Preselect: the board to select first (the connected one), or Nothing.
    Public Sub New(Boards As List(Of BoardType), Message As String, Preselect As BoardType)
        Text = "Board Type in use"
        FormBorderStyle = FormBorderStyle.FixedDialog
        MaximizeBox = False
        MinimizeBox = False
        ShowInTaskbar = True
        StartPosition = FormStartPosition.CenterScreen
        ClientSize = New Size(460, 330)
        Font = New Font("Microsoft Sans Serif", 8.25!)

        Dim Prompt As New Label With {
            .Text = Message,
            .Location = New Point(12, 10),
            .Size = New Size(436, 60)}

        BoardList.Location = New Point(12, 74)
        BoardList.Size = New Size(436, 144)
        BoardList.IntegralHeight = False
        'Show each board by its name only
        BoardList.FormattingEnabled = True
        AddHandler BoardList.Format, AddressOf BoardListFormat
        For Each Board In Boards
            BoardList.Items.Add(Board)
        Next
        AddHandler BoardList.SelectedIndexChanged, AddressOf BoardListSelectedIndexChanged
        AddHandler BoardList.DoubleClick, AddressOf BoardListDoubleClick

        BoardDetails.Location = New Point(12, 224)
        BoardDetails.Size = New Size(436, 62)
        BoardDetails.Font = New Font("Courier New", 7.5!)

        OkButton.Text = "OK"
        OkButton.Location = New Point(292, 294)
        OkButton.Size = New Size(75, 24)
        OkButton.DialogResult = DialogResult.OK

        CancelButtonControl.Text = "Cancel"
        CancelButtonControl.Location = New Point(373, 294)
        CancelButtonControl.Size = New Size(75, 24)
        CancelButtonControl.DialogResult = DialogResult.Cancel

        Controls.AddRange(New Control() {Prompt, BoardList, BoardDetails, OkButton, CancelButtonControl})
        AcceptButton = OkButton
        CancelButton = CancelButtonControl

        If Preselect IsNot Nothing AndAlso BoardList.Items.Contains(Preselect) Then
            BoardList.SelectedItem = Preselect
        ElseIf BoardList.Items.Count > 0 Then
            BoardList.SelectedIndex = 0
        End If
        OkButton.Enabled = BoardList.SelectedIndex >= 0
    End Sub

    Private Sub BoardListSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim Board = SelectedBoard
        OkButton.Enabled = Board IsNot Nothing
        If Board Is Nothing Then
            BoardDetails.Text = ""
            Return
        End If
        BoardDetails.Text = "Switches " & Board.Switches.Count & ", LEDs " & Board.Leds.Count & ", ADC " & Board.Adcs.Count & vbCrLf &
            "USB product name contains: " & String.Join(" or ", Board.ProductMatch.ToArray())
    End Sub

    Private Sub BoardListFormat(sender As Object, e As ListControlConvertEventArgs)
        Dim Board = TryCast(e.ListItem, BoardType)
        If Board IsNot Nothing Then e.Value = Board.Name
    End Sub

    Private Sub BoardListDoubleClick(sender As Object, e As EventArgs)
        If SelectedBoard IsNot Nothing Then
            DialogResult = DialogResult.OK
            Close()
        End If
    End Sub

End Class
