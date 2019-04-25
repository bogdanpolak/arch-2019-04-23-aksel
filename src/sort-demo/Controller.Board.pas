unit Controller.Board;

interface

uses
  Model.Board, View.Board;

type
  TBoardController = class
  private
    FModel: TBoard;
    FView: TBoardView;
    FEnableSorting: Boolean;
    FSwapCounter: Integer;
    function GetItemsCount: Integer;
    procedure DoQuickSort(var data: TArray<Integer>);
    procedure Swap(i, j: Integer; var data: TArray<Integer>);
    procedure WaitMilisecond(timeMs: double);
  public
    constructor CreateAndInit(AModel: TBoard; AView: TBoardView);
    procedure QuickSort;
    property EnableSorting: Boolean read FEnableSorting write FEnableSorting;
  const
    MaxValue = 100;
  end;

implementation

uses
  System.Diagnostics, System.TimeSpan, Winapi.Windows;

{ TBoardController }

constructor TBoardController.CreateAndInit(AModel: TBoard; AView: TBoardView);
begin
  FModel := AModel;
  FView := AView;
  FModel.MaxValue := MaxValue;
  FView.MaxValue := MaxValue;
end;

procedure TBoardController.WaitMilisecond(timeMs: double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TBoardController.Swap(i, j: Integer; var data: TArray<Integer>);
begin
  FModel.Swap(i, j);
  FView.Swap(i, j, FModel.FData);
  inc(FSwapCounter);
  WaitMilisecond(4.5);
end;

procedure TBoardController.DoQuickSort(var data: TArray<Integer>);
  procedure qsort(idx1, idx2: Integer);
  var
    i: Integer;
    j: Integer;
    mediana: Integer;
  begin
    i := idx1;
    j := idx2;
    mediana := data[(i + j) div 2];
    repeat
      while data[i] < mediana do
        inc(i);
      while mediana < data[j] do
        dec(j);
      if i <= j then
      begin
        swap(i, j, data);
        inc(i);
        dec(j);
      end;
    until i > j;
    if FEnableSorting then
    begin
      if idx1 < j then
        qsort(idx1, j);
      if i < idx2 then
        qsort(i, idx2);
    end;
  end;

begin
  qsort(0, Length(data) - 1);
end;

function TBoardController.GetItemsCount: Integer;
begin
  Result := FView.ItemsCount;
end;

procedure TBoardController.QuickSort;
var
  itemsCount: Integer;
  sw: TStopwatch;
  elapsedTime: TTimeSpan;
begin
  EnableSorting := True;
  FSwapCounter := 0;
  itemsCount := GetItemsCount;
  FModel.GenerateData(itemsCount);
  FView.DrawBoard(FModel.FData);
  sw := TStopwatch.StartNew;
  DoQuickSort(FModel.FData);
  elapsedTime := sw.Elapsed;
  FView.DrawResults('QuickSort', itemsCount, elapsedTime, FSwapCounter);
end;

end.
