unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort, Model.Board, View.Board;

type
  TStartBubbleAction = class (TSortAction)
  private
    procedure BubbleSort(ABoard: TBoard; ABoardView: IBoardView);
    procedure WaitMilisecond(timeMs: double);
  public
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan, Vcl.Forms,
  Winapi.Windows;

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

procedure TStartBubbleAction.DoWork;
var
  data: TArray<Integer>;
  paintBox: TPaintBox;
  itemCount: Integer;
  sw: TStopwatch;
  enlapsedTime: TTimeSpan;
  board: TBoard;
  boardView: IBoardView;
begin
  paintBox := Form1.PaintBox1;
  Form1.PrepareSortDemo(paintBox, data);
  itemCount := CountVisibleItems(paintbox);
  board := TBoard.Create;
  try
    board.GenerateData(itemCount);
    data := board.Data;
    boardView := TBoardView.CreateAndInit(paintBox, board);
    Form1.SwapCounter := 0;
    boardView.DrawBoard;
    sw := TStopwatch.StartNew;
    BubbleSort(board, boardView);
    enlapsedTime := sw.Elapsed;
    Form1.DrawResults(paintBox, 'BubbleSort', itemCount, enlapsedTime, Form1.SwapCounter);
  finally
    board.Free;
    //exc
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

         //
        ABoardView.DrawItem(j);
        ABoardView.DrawItem(j + 1);
        Application.ProcessMessages;
        inc(Form1.SwapCounter);
        WaitMilisecond(4.5);

        if not (Form1.EnableSorting) then
          break;
      end;
end;

end.
