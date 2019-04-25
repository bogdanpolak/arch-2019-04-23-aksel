unit Action.StartInsertion;

interface

uses
  Vcl.ActnList,
  Action.Sort;

type
  TStartInsertionAction = class (TSortAction)
  public
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan,
  System.Classes;

procedure TStartInsertionAction.DoWork;
begin
  TThread.CreateAnonymousThread(procedure
  begin
    Enabled := False;
    FController.InsertionSort;
    Enabled := True;
  end).Start;
end;

end.
