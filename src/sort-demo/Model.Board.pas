{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Model.Board;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TMessageType = (mtSwap, mtDone);

  TBoard = class;

  TSortMessage = record
    MessageType: TMessageType;
    Board: TBoard;
    SwapIndex1: integer;
    SwapIndex2: integer;
    constructor CreateMessageSwap (ABoard: TBoard; AIdx1, AIdx2: Integer);
    constructor CreateMessageDone (ABoard: TBoard);
  end;

  TBoard = class
  private
    FData: TArray<Integer>;
    function GetCount: Integer;
    procedure DoWait;
  public
    constructor Create;
    procedure GenerateData(AItemsCnt: Integer);
    procedure Swap(AIdx1, AIdx2: Integer);
    procedure SortBubble;
    procedure SortInsertion;
    procedure SortQuick;
    property Count: Integer read GetCount;
    property Data: TArray<Integer> read FData;
  end;

  EBoardException = class(Exception);

var
  { TODO: Nie powinno być globalne
    * Można przenieść do klasy TBoard (class var), ale to za mało
    * Trzeba przeanalizować zależności od FMessageQueue
    * Potrzebna lepsza nazwa }
  FMessageQueue: TThreadedQueue <TSortMessage>;

implementation

uses
  Winapi.Windows;

const
  MaxValue = 200;


constructor TBoard.Create;
begin
  inherited;
  if FMessageQueue = nil then
    // TODO: Brakuje usuwania Message Queue (trzeba to zrobić po zakończeniu wątku)
    FMessageQueue := TThreadedQueue<TSortMessage>.Create;
end;

procedure TBoard.GenerateData(AItemsCnt: Integer);
var
  i: Integer;
begin
  Randomize;
  if (AItemsCnt <= 0) then
    raise EBoardException.Create('Zła liczba danych do generacji');
  SetLength(FData, AItemsCnt);
  for i := 0 to Length(FData) - 1 do
    FData[i] := Random(MaxValue) + 1;
end;

function TBoard.GetCount: Integer;
begin
  Result := Length(FData);
end;

procedure TBoard.Swap(AIdx1, AIdx2: Integer);
var
  v: Integer;
begin
  v := FData[AIdx1];
  FData[AIdx1] := FData[AIdx2];
  FData[AIdx2] := v;
  FMessageQueue.PushItem(
    TSortMessage.CreateMessageSwap(Self, AIdx1, AIdx2)
  );
  DoWait;
end;

procedure WaitMilisecond(ATimeMs: Double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < ATimeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TBoard.DoWait;
begin
  WaitMilisecond(4.5);
end;

procedure TBoard.SortBubble;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to Count - 1 do
    for j := 0 to Count - 2 do
      if FData[j] > FData[j + 1] then
        Swap (j, j+1);
  FMessageQueue.PushItem(
  TSortMessage.CreateMessageDone(Self));
end;


procedure TBoard.SortInsertion;
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
      swap(i, mini);
    // TODO: Brakuje sprawdzenia czy przy przerwać algorytm
    // (np. po Thread.Terminate)
  end;
  FMessageQueue.PushItem(
  TSortMessage.CreateMessageDone(Self));
end;


procedure TBoard.SortQuick;
  procedure qsort(idx1, idx2: Integer);
  var
    i: Integer;
    j: Integer;
    mediana: Integer;
  begin
    i := idx1;
    j := idx2;
    mediana := Data[(i + j) div 2];
    repeat
      while Data[i] < mediana do
        inc(i);
      while mediana < Data[j] do
        dec(j);
      if i <= j then
      begin
        Swap(i, j);
        inc(i);
        dec(j);
      end;
    until i > j;
    // TODO: Brakuje sprawdzenia czy przy przerwać algorytm
    // (np. po Thread.Terminate)
    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

begin
  qsort(0, Count - 1);
  FMessageQueue.PushItem(
  TSortMessage.CreateMessageDone(Self));
end;


{ TSortMessage }

constructor TSortMessage.CreateMessageDone (ABoard: TBoard);
begin
  MessageType := mtDone;
  Board := ABoard;
end;

constructor TSortMessage.CreateMessageSwap(ABoard: TBoard; AIdx1, AIdx2: Integer);
begin
  MessageType := mtSwap;
  Board := ABoard;
  SwapIndex1 := AIdx1;
  SwapIndex2 := AIdx2;
end;

end.
