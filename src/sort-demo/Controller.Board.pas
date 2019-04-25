unit Controller.Board;

interface

uses
  Model.Board, View.Board, System.Classes,
  System.Diagnostics, System.TimeSpan, Winapi.Windows;

type
  TBoardController = class(TComponent)
  private
    FModel: TBoard;
    FView: TBoardView;
    FEnableSorting: Boolean;
    FSwapCounter: Integer;
    function GetItemsCount: Integer;
    procedure DoQuickSort(var data: TArray<Integer>);
    procedure DoBubbleSort(var data: TArray<Integer>);
    procedure DoInsertionSort(var data: TArray<Integer>);
    procedure Swap(i, j: Integer; var data: TArray<Integer>);
    procedure WaitMilisecond(timeMs: double);
    procedure DrawBoard;
    procedure DrawResult(const ATitle: string; AItemsCount: Integer;
      AElapsedTime: TTimeSpan);
  public
    constructor CreateAndInit(AOwner: TComponent; AModel: TBoard; AView: TBoardView);
    procedure QuickSort;
    procedure BubbleSort;
    procedure InsertionSort;
    property EnableSorting: Boolean read FEnableSorting write FEnableSorting;
  const
    MaxValue = 100;
  end;

implementation

{ TBoardController }

procedure TBoardController.DrawBoard;
begin
  TThread.Synchronize(nil,
  procedure
  begin
    FView.DrawBoard(FModel.FData);
  end);
end;

procedure TBoardController.BubbleSort;
var
  itemsCount: Integer;
  sw: TStopwatch;
  elapsedTime: TTimeSpan;
begin
  EnableSorting := True;
  FSwapCounter := 0;
  itemsCount := GetItemsCount;
  FModel.GenerateData(itemsCount);
  DrawBoard;
  sw := TStopwatch.StartNew;
  DoBubbleSort(FModel.FData);
  elapsedTime := sw.Elapsed;
  DrawResult('BubbleSort', itemsCount, elapsedTime);
end;

procedure TBoardController.DrawResult(const ATitle: string; AItemsCount: Integer; AElapsedTime: TTimeSpan);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    FView.DrawResults(ATitle, AItemsCount, AElapsedTime, FSwapCounter);
  end);
end;

constructor TBoardController.CreateAndInit(AOwner: TComponent; AModel: TBoard; AView: TBoardView);
begin
  inherited Create(AOwner);
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
  TThread.Synchronize(nil,
  procedure
  begin
    FView.Swap(i, j, FModel.FData);
  end);
  inc(FSwapCounter);
  WaitMilisecond(4.5);
end;

procedure TBoardController.DoBubbleSort(var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to Length(data) - 1 do
    for j := 0 to Length(data) - 2 do
      if data[j] > data[j + 1] then
      begin
        swap(j, j + 1, data);
        if not(EnableSorting) then
          break;
      end;
end;

procedure TBoardController.DoInsertionSort(var data: TArray<Integer>);
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

procedure TBoardController.InsertionSort;
var
  itemsCount: Integer;
  sw: TStopwatch;
  elapsedTime: TTimeSpan;
begin
  EnableSorting := True;
  FSwapCounter := 0;
  itemsCount := GetItemsCount;
  FModel.GenerateData(itemsCount);
  DrawBoard;
  sw := TStopwatch.StartNew;
  DoInsertionSort(FModel.FData);
  elapsedTime := sw.Elapsed;
  DrawResult('InsertionSort', itemsCount, elapsedTime);
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
  DrawBoard;
  sw := TStopwatch.StartNew;
  DoQuickSort(FModel.FData);
  elapsedTime := sw.Elapsed;
  DrawResult('QuickSort', itemsCount, elapsedTime);
end;

end.
