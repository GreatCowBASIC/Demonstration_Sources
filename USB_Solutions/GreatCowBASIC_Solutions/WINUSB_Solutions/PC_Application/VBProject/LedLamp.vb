'
' An LED drawn in any colour: lit when IsOn, a dark lamp with a coloured rim when off.
' It replaces the pairs of coloured and black pictures that were shown and hidden.
'
' User: Evan R. Venn
' Date: 2026

Imports System.Drawing.Drawing2D

Public Class LedLamp
    Inherits Control

    Private _lampColour As Color = Color.LimeGreen
    Private _isOn As Boolean
    Private _hollowWhenOff As Boolean

    Public Sub New()
        SetStyle(ControlStyles.AllPaintingInWmPaint Or ControlStyles.OptimizedDoubleBuffer Or ControlStyles.ResizeRedraw Or ControlStyles.UserPaint Or ControlStyles.SupportsTransparentBackColor, True)
        BackColor = Color.Transparent
        Size = New Size(20, 20)
    End Sub

    Public Property LampColour As Color
        Get
            Return _lampColour
        End Get
        Set(value As Color)
            _lampColour = value
            Invalidate()
        End Set
    End Property

    Public Property IsOn As Boolean
        Get
            Return _isOn
        End Get
        Set(value As Boolean)
            If _isOn <> value Then
                _isOn = value
                Invalidate()
            End If
        End Set
    End Property

    'Off: only a black ring (the switch inputs), instead of a dark lamp
    Public Property HollowWhenOff As Boolean
        Get
            Return _hollowWhenOff
        End Get
        Set(value As Boolean)
            _hollowWhenOff = value
            Invalidate()
        End Set
    End Property

    'A colour from the board file: a .NET colour name ("Red", "Gold") or "#RRGGBB". Anything else: lime green.
    Public Shared Function ColourFromName(Name As String) As Color
        If String.IsNullOrEmpty(Name) Then Return Color.LimeGreen
        Try
            If Name.StartsWith("#") Then Return ColorTranslator.FromHtml(Name)
        Catch
            Return Color.LimeGreen
        End Try
        Dim Named = Color.FromName(Name.Trim())
        If Named.IsKnownColor Then Return Named
        Return Color.LimeGreen
    End Function

    Protected Overrides Sub OnPaint(e As PaintEventArgs)
        MyBase.OnPaint(e)
        e.Graphics.SmoothingMode = SmoothingMode.AntiAlias
        Dim Lamp As New Rectangle(1, 1, Width - 3, Height - 3)

        If _isOn Then
            Using Body As New SolidBrush(_lampColour)
                e.Graphics.FillEllipse(Body, Lamp)
            End Using
            'A highlight at the top left
            Dim Shine As New Rectangle(Lamp.X + Lamp.Width \ 5, Lamp.Y + Lamp.Height \ 6, Lamp.Width \ 3, Lamp.Height \ 4)
            Using Highlight As New SolidBrush(Color.FromArgb(150, Color.White))
                e.Graphics.FillEllipse(Highlight, Shine)
            End Using
        ElseIf _hollowWhenOff Then
            Using Rim As New Pen(Color.Black, 2)
                e.Graphics.DrawEllipse(Rim, Lamp)
            End Using
            Return
        Else
            Using Body As New SolidBrush(Color.FromArgb(70, 70, 70))
                e.Graphics.FillEllipse(Body, Lamp)
            End Using
        End If

        'A light lamp (white) gets a grey rim, so it shows on the grey form
        Dim RimColour = If(_lampColour.GetBrightness() > 0.85, Color.Gray, ControlPaint.Dark(_lampColour))
        Using Rim As New Pen(RimColour, 2)
            e.Graphics.DrawEllipse(Rim, Lamp)
        End Using
    End Sub

End Class
