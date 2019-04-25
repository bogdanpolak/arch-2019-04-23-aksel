unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort, View.Board, Model.Board, Model.SortResults;

type
  TStartBubbleAction = class(TSortAction)
  private
    FBoard: TBoard;
    FSortResults: TSortResults;
  public
    constructor CreateAndInit (Button:TButton; const Caption: String); virtual;
    destructor Destroy;

    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan;

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

constructor TStartBubbleAction.CreateAndInit(Button: TButton; const Caption: String);
begin
  inherited;
  FBoard := TBoard.Create(Form.Main.MaxValue);
  FSortResults := TSortResults.Create;
end;

destructor TStartBubbleAction.Destroy;
begin
  FBoard.Free;
  FSortResults.Free;
  inherited;
end;

procedure TStartBubbleAction.DoWork;
var
  paintBox: TPaintBox;
  itemCount: Integer;
  sw: TStopwatch;
  enlapsedTime: TTimeSpan;
  sr: TSortResults;
begin
  paintBox := Form1.PaintBox1;
  itemCount := CountVisibleItems(paintbox);
  FBoard.GenerateData(ItemCount);
  Form1.PrepareSortDemo(PaintBox, FBoard.FData);
  Form1.SwapCounter := 0;
  Form1.DrawBoard(PaintBox, FBoard.FData);
  sw := TStopwatch.StartNew;
  Form1.BubbleSort(FBoard.FData);
  EnlapsedTime := sw.Elapsed;
  Form1.DrawResults(PaintBox, 'BubbleSort', ItemCount, EnlapsedTime, Form1.SwapCounter);
end;

end.
