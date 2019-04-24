object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 336
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 185
    Height = 330
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 194
    Top = 3
    Width = 255
    Height = 330
    Align = alLeft
    Caption = 'GroupBox2'
    TabOrder = 1
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 245
      Height = 307
      Align = alClient
      ColCount = 3
      DefaultColWidth = 24
      DefaultRowHeight = 22
      RowCount = 2
      TabOrder = 0
    end
  end
  object tmrReady: TTimer
    Interval = 1
    OnTimer = tmrReadyTimer
    Left = 72
    Top = 128
  end
end
