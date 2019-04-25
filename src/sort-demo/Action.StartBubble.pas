unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort;

type
  TStartBubbleAction = class (TSortAction)
  public
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan,
  System.Classes;

procedure TStartBubbleAction.DoWork;
begin
  TThread.CreateAnonymousThread(procedure
  begin
    Enabled := False;
    FController.BubbleSort;
    Enabled := True;
  end).Start;
end;

end.
