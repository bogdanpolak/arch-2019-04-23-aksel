object Form1: TForm1
  AlignWithMargins = True
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 331
  ClientWidth = 527
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
    Left = 0
    Top = 0
    Width = 527
    Height = 49
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 100
      Height = 26
      Align = alLeft
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 111
      Top = 18
      Width = 106
      Height = 26
      Align = alLeft
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 424
      Top = 18
      Width = 98
      Height = 26
      Align = alRight
      Caption = 'Close Tab'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 52
    Width = 521
    Height = 276
    Align = alClient
    TabOrder = 1
  end
end
