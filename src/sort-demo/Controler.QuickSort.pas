unit Controler.QuickSort;

interface

uses
  System.Diagnostics, System.Classes,
  Vcl.ExtCtrls,
  Model.Board,
  Model.SortResults,
  View.Board,
  View.SortResults,
  Controler.Sort;

type

  TQuickSortControler = class(TSortControler)
  private
    procedure Sort;
    procedure DoAfterSort;
  public
    constructor CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox); override;
    procedure DoSort; override;
  end;

implementation

uses
  Winapi.Windows,
  Vcl.Forms, Thread.SortControler;

{ TControlerBubbleSort }

constructor TQuickSortControler.CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox);
begin
  inherited;
  FSortResult.Name := 'QuickSort';
end;

(*
procedure TForm1.InsertionSort(var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  mini: Integer;
  minv: Integer;
begin
  for i := 0 to Length(data) - 1 do
  begin
    mini := i;
    minv := data[i];
    for j := i + 1 to Length(data) - 1 do
    begin
      if data[j] < minv then
      begin
        mini := j;
        minv := data[j];
      end;
    end;
    if mini <> i then
      swap(i, mini, data);
    if not(EnableSorting) then
      break;
  end;
end;
*)
procedure TQuickSortControler.Sort;
  procedure qsort(idx1, idx2: Integer);
  var
    i: Integer;
    j: Integer;
    mediana: Integer;
  begin
    i := idx1;
    j := idx2;
    mediana := FBoard.Data[(i + j) div 2];
    repeat
      while FBoard.Data[i] < mediana do
        inc(i);
      while mediana < FBoard.Data[j] do
        dec(j);
      if i <= j then
      begin
        VisualSwap(i, j);
        inc(i);
        dec(j);
      end;
    until i > j;
    if FControlerThread.isTerminated then
      exit;
    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

begin
  qsort(0, FBoard.Count - 1);
end;

procedure TQuickSortControler.DoSort;
var
  itemCount: Integer;
begin
  itemCount := FBoardView.CountVisibleItems;
  FSortResult.DataSize := itemCount;
  FSwapCounter := 0;

  FBoard.GenerateData(itemCount);
  FBoardView.DrawBoard;
  FSWatch := TStopwatch.StartNew;
  FControlerThread := TSortControlerThread.CreateAndInit(Sort, DoAfterSort);
end;

procedure TQuickSortControler.DoAfterSort;
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
