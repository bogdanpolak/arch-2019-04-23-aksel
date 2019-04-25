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

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

procedure TStartBubbleAction.DoWork;
var
  data: TArray<Integer>;
  PaintBox: TPaintBox;
  ItemCount: Integer;
  sw: TStopwatch;
  EnlapsedTime: TTimeSpan;
begin
  PaintBox := Form1.PaintBox1;
  Form1.PrepareSortDemo(PaintBox, data);
  ItemCount := CountVisibleItems(paintbox);
  Form1.GenerateData(data, ItemCount);
  Form1.SwapCounter := 0;
  Form1.DrawBoard(PaintBox, data);
  sw := TStopwatch.StartNew;
  Form1.BubbleSort(data);
  EnlapsedTime := sw.Elapsed;
  Form1.DrawResults(PaintBox, 'BubbleSort', ItemCount, EnlapsedTime, Form1.SwapCounter);
end;

end.
