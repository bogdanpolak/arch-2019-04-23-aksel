unit Action.StartQuick;

interface

uses
  Vcl.ActnList,
  Action.Sort;


type
  TStartQuickAction = class (TSortAction)
  public
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan,
  System.Classes;

procedure TStartQuickAction.DoWork;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Enabled := False;
    FController.QuickSort;
    Enabled := True;
  end).Start;
end;

end.
