object FirstFrame: TFirstFrame
  Left = 0
  Top = 0
  Width = 324
  Height = 160
  TabOrder = 0
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 318
    Height = 48
    Align = alTop
    Alignment = taCenter
    Caption = 'Frame.First'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    ExplicitWidth = 198
  end
  object tmrReady: TTimer
    Interval = 1
    OnTimer = tmrReadyTimer
    Left = 24
    Top = 72
  end
end
