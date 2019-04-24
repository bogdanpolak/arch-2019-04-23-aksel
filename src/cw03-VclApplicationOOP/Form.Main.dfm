object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 372
  ClientWidth = 233
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
    Width = 227
    Height = 144
    Align = alTop
    Caption = 'VCL+ TimerEvents Demo'
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 217
      Height = 26
      Align = alTop
      Caption = 
        'Review the OnCreate event to get the code for TEventOnFirstShow ' +
        'and  TEvenOnTimer'
      WordWrap = True
      ExplicitWidth = 215
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 5
      Top = 77
      Width = 217
      Height = 3
      Align = alTop
      ExplicitTop = 64
      ExplicitWidth = 223
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 50
      Width = 217
      Height = 21
      Align = alTop
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 153
    Width = 227
    Height = 64
    Align = alTop
    Caption = 'GroupBox2'
    TabOrder = 1
    object btnShowForm2: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 217
      Height = 25
      Align = alTop
      Caption = 'btnShowForm2'
      TabOrder = 0
      OnClick = btnShowForm2Click
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 223
    Width = 227
    Height = 66
    Align = alTop
    Caption = 'GroupBox3'
    TabOrder = 2
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 217
      Height = 25
      Align = alTop
      Caption = 'Button1'
      TabOrder = 0
    end
  end
end
