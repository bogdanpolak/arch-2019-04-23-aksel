object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 561
  ClientWidth = 617
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
  object Splitter1: TSplitter
    Left = 170
    Top = 0
    Width = 5
    Height = 561
    ExplicitLeft = 189
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 166
    Height = 555
    Margins.Right = 1
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    object chkBindAction1ToButton1: TCheckBox
      AlignWithMargins = True
      Left = 10
      Top = 18
      Width = 151
      Height = 17
      Margins.Left = 8
      Align = alTop
      Caption = 'chkBindAction1ToButton1'
      TabOrder = 0
      OnClick = chkBindAction1ToButton1Click
    end
    object chkBindAction2ToButton2: TCheckBox
      AlignWithMargins = True
      Left = 10
      Top = 41
      Width = 151
      Height = 17
      Margins.Left = 8
      Align = alTop
      Caption = 'chkBindAction2ToButton2'
      TabOrder = 1
      OnClick = chkBindAction2ToButton2Click
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 64
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button1'
      TabOrder = 2
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 5
      Top = 95
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button2'
      TabOrder = 3
    end
    object chkTimer1Enable: TCheckBox
      AlignWithMargins = True
      Left = 10
      Top = 126
      Width = 151
      Height = 17
      Margins.Left = 8
      Align = alTop
      Caption = 'chkTimer1Enable'
      TabOrder = 4
      OnClick = chkTimer1EnableClick
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 176
    Top = 3
    Width = 438
    Height = 555
    Margins.Left = 1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 62
    Top = 216
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 16458
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      OnExecute = Action2Execute
    end
    object actClearMemo: TAction
      Caption = 'actClearMemo'
      ShortCut = 16451
      OnExecute = actClearMemoExecute
    end
    object actMaximize: TAction
      Caption = 'actMaximize'
      ShortCut = 16461
      OnExecute = actMaximizeExecute
    end
    object actQuitApp: TAction
      Caption = 'actQuitApp'
      ShortCut = 16465
      OnExecute = actQuitAppExecute
    end
    object actCallApplicaionIdle: TAction
      Caption = 'actCallApplicaionIdle'
      ShortCut = 16457
      OnExecute = actCallApplicaionIdleExecute
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnActionExecute = ApplicationEvents1ActionExecute
    OnActionUpdate = ApplicationEvents1ActionUpdate
    OnIdle = ApplicationEvents1Idle
    Left = 64
    Top = 272
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 64
    Top = 328
  end
end
