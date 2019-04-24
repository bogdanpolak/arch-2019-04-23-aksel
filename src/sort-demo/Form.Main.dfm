object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 502
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 629
    Height = 175
    Align = alTop
  end
  object PaintBox2: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 239
    Width = 629
    Height = 175
    Align = alTop
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
  end
end
