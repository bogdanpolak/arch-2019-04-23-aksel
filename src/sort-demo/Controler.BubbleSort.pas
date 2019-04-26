unit Controler.BubbleSort;

interface

uses
  Vcl.ExtCtrls, System.Diagnostics, Model.Board, View.Board, View.SortResults,
  Model.SortResults, Controler.Basic, System.Classes;

type

  TControlerBubbleSort = class(TControlerBasicSort)
  private
    procedure BubbleSort;
    procedure DoAfterSort;
  public
    constructor CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox); override;
    procedure DoSort; override;
  end;

implementation

uses
  Winapi.Windows, Vcl.Forms, Controler.Thread;

{ TControlerBubbleSort }

constructor TControlerBubbleSort.CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox);
begin
  inherited;
  FSResult.Name := 'BubbleSort';
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
        TControlerThread.Synchronize(FControlerThread,
          procedure
          begin
            FBoardView.DrawItem(j);
            FBoardView.DrawItem(j + 1);
          end);
        inc(FSwapCounter);
        WaitMilisecond(4.5);
        if FControlerThread.IsTerminated then
          Exit;
      end;
end;

procedure TControlerBubbleSort.DoSort;
var
  itemCount: Integer;
begin
  itemCount := FBoardView.CountVisibleItems;
  FSResult.DataSize := itemCount;
  FSwapCounter := 0;

  FBoard.GenerateData(itemCount);
  FBoardView.DrawBoard;
  FSWatch := TStopwatch.StartNew;
  FControlerThread := TControlerThread.CreateAndInit(BubbleSort, DoAfterSort);
end;

procedure TControlerBubbleSort.DoAfterSort;
begin
  FSResult.ElapsedTime := FSWatch.Elapsed;
  FSResult.SwapCounter := FSwapCounter;
  TControlerThread.Synchronize(FControlerThread,
    procedure
    begin
      FSResultView.DrawResults;
    end);
end;

end.
