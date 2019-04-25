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
var
  data: TArray<Integer>;
  PaintBox: TPaintBox;
  ItemCount: Integer;
  sw: TStopwatch;
  EnlapsedTime: TTimeSpan;
begin
  PaintBox := Form1.PaintBox2;
  Form1.PrepareSortDemo(PaintBox, data);
  ItemCount := CountVisibleItems(paintbox);
  Form1.GenerateData(data, ItemCount);
  Form1.SwapCounter := 0;
  Form1.DrawBoard(PaintBox, data);
  sw := TStopwatch.StartNew;
  Form1.QuickSort(data);
  EnlapsedTime := sw.Elapsed;
  Form1.DrawResults(PaintBox, 'QuickSort', ItemCount, EnlapsedTime, Form1.SwapCounter);
end;

end.
