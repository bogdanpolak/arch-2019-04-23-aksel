object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 563
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 629
    Height = 159
    Align = alTop
  end
  object PaintBox2: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 223
    Width = 629
    Height = 159
    Align = alTop
  end
  object PaintBox3: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 388
    Width = 629
    Height = 159
    Align = alTop
    ExplicitLeft = 192
    ExplicitTop = 440
    ExplicitWidth = 105
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 49
    Align = alTop
    Caption = 'GroupBox1'
    Padding.Bottom = 1
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 116
      Height = 25
      Align = alLeft
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 127
      Top = 18
      Width = 116
      Height = 25
      Align = alLeft
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 249
      Top = 18
      Width = 120
      Height = 25
      Align = alLeft
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object Timer1: TTimer
    Interval = 20
    OnTimer = Timer1Timer
    Left = 168
    Top = 136
  end
end
