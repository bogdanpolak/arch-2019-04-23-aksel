unit Controler.BubbleSort;

interface

uses
  Vcl.ExtCtrls, System.Diagnostics, Model.Board, View.Board, View.SortResults,
  Model.SortResults, Controler.Sort, System.Classes;

type

  TBubbleSortControler = class(TSortControler)
  private
    procedure BubbleSort;
    procedure DoAfterSort;
  public
    constructor CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox); override;
    procedure DoSort; override;
  end;

implementation

uses
  Winapi.Windows, Vcl.Forms, Thread.SortControler;

{ TControlerBubbleSort }

constructor TBubbleSortControler.CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox);
begin
  inherited;
  FSortResult.Name := 'BubbleSort';
end;

procedure TBubbleSortControler.BubbleSort;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to FBoard.Count - 1 do
    for j := 0 to FBoard.Count - 2 do
      if FBoard.Data[j] > FBoard.Data[j + 1] then
      begin
        VisualSwap(j, j+1);
        if FControlerThread.IsTerminated then
          Exit;
      end;
end;

procedure TBubbleSortControler.DoSort;
var
  itemCount: Integer;
begin
  itemCount := FBoardView.CountVisibleItems;
  FSortResult.DataSize := itemCount;
  FSwapCounter := 0;

  FBoard.GenerateData(itemCount);
  FBoardView.DrawBoard;
  FSWatch := TStopwatch.StartNew;
  FControlerThread := TSortControlerThread.CreateAndInit(BubbleSort, DoAfterSort);
end;

procedure TBubbleSortControler.DoAfterSort;
begin
  FSortResult.ElapsedTime := FSWatch.Elapsed;
  FSortResult.SwapCounter := FSwapCounter;
  TSortControlerThread.Synchronize(FControlerThread,
    procedure
    begin
      FSResultView.DrawResults;
    end);
end;

end.
