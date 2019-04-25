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

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan;

procedure TStartBubbleAction.DoWork;
begin
  TThread.CreateAnonymousThread(procedure
  begin
    FController.BubbleSort;
  end).Start;
end;

end.
