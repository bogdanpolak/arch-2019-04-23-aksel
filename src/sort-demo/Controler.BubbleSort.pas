unit Controler.BubbleSort;

interface

uses
  Vcl.ExtCtrls, System.Diagnostics, Model.Board, View.Board, View.SortResults,
  Model.SortResults;

type

  TControlerBubbleSort = class
  private
    FPaintBox: TPaintBox;
    FStopwatch: TStopwatch;
    FBoard: TBoard;
    FBoardView: IBoardView;
    FSResult: TSortResults;
    FSResultView: ISortResultsView;
    FSwapCounter: Integer;
    procedure BubbleSort;
    procedure WaitMilisecond(timeMs: double);
  public
    constructor CreateAndInit(APaintBox: TPaintBox);
    destructor Destroy; override;
    procedure DoSort;
  end;

implementation

uses
  Winapi.Windows, Vcl.Forms;

{ TControlerBubbleSort }

constructor TControlerBubbleSort.CreateAndInit(APaintBox: TPaintBox);
begin
  inherited Create;
  FPaintBox := APaintBox;
  FBoard := TBoard.Create;
  FBoardView := TBoardView.CreateAndInit(FPaintBox, FBoard);
  FSResult := TSortResults.Create;
  FSResult.Name := 'BubbleSort';
  FSResultView := TSortResultsView.CreateAndInit(FPaintBox, FSResult);
end;

destructor TControlerBubbleSort.Destroy;
begin
  FBoard.Free;
  FSResult.Free;
  inherited;
end;

procedure TControlerBubbleSort.WaitMilisecond(timeMs: double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TControlerBubbleSort.BubbleSort;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to FBoard.Count - 1 do
    for j := 0 to FBoard.Count - 2 do
      if FBoard.Data[j] > FBoard.Data[j + 1] then
      begin
        FBoard.Swap(j, j + 1);
        FBoardView.DrawItem(j);
        FBoardView.DrawItem(j + 1);
        Application.ProcessMessages;
        inc(FSwapCounter);
        WaitMilisecond(4.5);
//        if not (Form1.EnableSorting) then
//          break;
      end;
end;

procedure TControlerBubbleSort.DoSort;
var
  itemCount: Integer;
  sw: TStopwatch;
begin
  itemCount := FBoardView.CountVisibleItems;
  FSResult.DataSize := itemCount;
  FSwapCounter := 0;
  FBoard.GenerateData(itemCount);
  FBoardView.DrawBoard;
  sw := TStopwatch.StartNew;
  BubbleSort;
  FSResult.ElapsedTime := sw.Elapsed;
  FSResult.SwapCounter := FSwapCounter;
  FSResultView.DrawResults;
end;

end.
