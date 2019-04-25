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

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan;

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

procedure TStartQuickAction.DoWork;
begin
  FController.QuickSort;
end;

end.
