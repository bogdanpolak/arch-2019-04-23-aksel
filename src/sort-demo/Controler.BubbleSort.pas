unit Controler.BubbleSort;

interface

uses
  Vcl.ExtCtrls, System.Diagnostics, Model.Board, View.Board, View.SortResults,
  Model.SortResults, Controler.Basic;

type

  TControlerBubbleSort = class(TControlerBasicSort)
  private
    procedure BubbleSort;
  public
    constructor CreateAndInit(APaintBox: TPaintBox); override;
    procedure DoSort; override;
  end;

implementation

uses
  Winapi.Windows, Vcl.Forms;

{ TControlerBubbleSort }

constructor TControlerBubbleSort.CreateAndInit(APaintBox: TPaintBox);
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
