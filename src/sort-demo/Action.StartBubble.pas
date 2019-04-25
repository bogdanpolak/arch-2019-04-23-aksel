unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort, Model.Board, View.Board;

type
  TStartBubbleAction = class (TSortAction)
  private
    FSwapCounter: Integer;
    procedure BubbleSort(ABoard: TBoard; ABoardView: IBoardView);
    procedure WaitMilisecond(timeMs: double);
  public
    procedure DoWork; override;
  end;

implementation

uses Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan, Vcl.Forms,
  Winapi.Windows, Model.SortResults, View.SortResults, Form.Main;

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

procedure TStartBubbleAction.DoWork;
var
  paintBox: TPaintBox;
  itemCount: Integer;
  sw: TStopwatch;
  board: TBoard;
  boardView: IBoardView;
  sResult: TSortResults;
  vResult: TSortResultsView;
begin
  paintBox := Form1.PaintBox1;  //
  itemCount := CountVisibleItems(paintbox);
  board := TBoard.Create;
  sResult := TSortResults.Create;
  with sResult do
  begin
    Name := 'BubbleSort';
    DataSize := itemCount;
  end;
  try
    FSwapCounter := 0;
    board.GenerateData(itemCount);
    boardView := TBoardView.CreateAndInit(paintBox, board);
    boardView.DrawBoard;
    sw := TStopwatch.StartNew;
    BubbleSort(board, boardView);
    sResult.ElapsedTime := sw.Elapsed;
    sResult.SwapCounter := FSwapCounter;
    vResult := TSortResultsView.CreateAndInit(paintBox, sResult);
    vResult.DrawResults;
  finally
    board.Free;
    sResult.Free;
  end;
end;

procedure TStartBubbleAction.WaitMilisecond(timeMs: double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TStartBubbleAction.BubbleSort(ABoard: TBoard; ABoardView: IBoardView);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to ABoard.Count - 1 do
    for j := 0 to ABoard.Count - 2 do
      if ABoard.Data[j] > ABoard.Data[j + 1] then
      begin
        ABoard.Swap(j, j + 1);
        ABoardView.DrawItem(j);
        ABoardView.DrawItem(j + 1);
        Application.ProcessMessages;
        inc(FSwapCounter);
        WaitMilisecond(4.5);
//        if not (Form1.EnableSorting) then
//          break;
      end;
end;

end.
