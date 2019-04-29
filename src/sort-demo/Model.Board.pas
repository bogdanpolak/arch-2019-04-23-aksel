{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Model.Board;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TMessageType = (mtSwap, mtDone);

  TBoard = class;

  TBoardMessage = record
    MessageType: TMessageType;
    Board: TBoard;
    SwapIndex1: integer;
    SwapIndex2: integer;
    constructor CreateMessageSwap(ABoard: TBoard; AIdx1, AIdx2: integer);
    constructor CreateMessageDone(ABoard: TBoard);
  end;

  TBoard = class
  const
    MaxValue = 200;
  private
    FData: TArray<integer>;
    function GetCount: integer;
    procedure DoWait;
  public
    FSwapCounter: Integer;
    constructor Create;
    procedure GenerateData(AItemsCount: integer);
    procedure Swap(AIdx1, AIdx2: integer);
    procedure SortBubble;
    procedure SortInsertion;
    procedure SortQuick;
    property Count: integer read GetCount;
    property Data: TArray<integer> read FData;
  end;

  EBoardException = class(Exception);

var
  { TODO: Nie powinno być globalne
    * Można przenieść do klasy TBoard (class var), ale to za mało
    * Trzeba przeanalizować zależności od FMessageQueue
    * Potrzebna lepsza nazwa }
  FMessageQueue: TThreadedQueue<TBoardMessage>;

implementation

uses
  Winapi.Windows;

constructor TBoard.Create;
begin
  inherited;
  if FMessageQueue = nil then
    // TODO: Brakuje usuwania Message Queue (trzeba to zrobić po zakończeniu wątku)
    FMessageQueue := TThreadedQueue<TBoardMessage>.Create;
end;

procedure TBoard.GenerateData(AItemsCount: integer);
var
  i: integer;
begin
  Randomize;
  if (AItemsCount <= 0) then
    raise EBoardException.Create('Zła liczba danych do generacji');
  SetLength(FData, AItemsCount);
  for i := 0 to Length(FData) - 1 do
    FData[i] := Random(MaxValue) + 1;
end;

function TBoard.GetCount: integer;
begin
  Result := Length(FData);
end;

procedure TBoard.Swap(AIdx1, AIdx2: integer);
var
  v: integer;
begin
  v := FData[AIdx1];
  FData[AIdx1] := FData[AIdx2];
  FData[AIdx2] := v;
  FMessageQueue.PushItem(TBoardMessage.CreateMessageSwap(Self, AIdx1, AIdx2));
  FSwapCounter := FSwapCounter + 1;
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
  WaitMilisecond(54.5);
end;

procedure TBoard.SortBubble;
var
  i: integer;
  j: integer;
begin
  for i := 0 to Count - 1 do
    for j := 0 to Count - 2 do begin
      if FData[j] > FData[j + 1] then
        Swap(j, j + 1);
      if TThread.Current.CheckTerminated then
        exit;
    end;
end;

procedure TBoard.SortInsertion;
var
  i: integer;
  j: integer;
  mini: integer;
  minv: integer;
begin
  for i := 0 to Length(Data) - 1 do
  begin
    mini := i;
    minv := Data[i];
    for j := i + 1 to Length(Data) - 1 do
    begin
      if Data[j] < minv then
      begin
        mini := j;
        minv := Data[j];
      end;
    end;
    if TThread.Current.CheckTerminated then
      exit;
    if mini <> i then
      Swap(i, mini);
  end;
end;

procedure TBoard.SortQuick;
  procedure qsort(idx1, idx2: integer);
  var
    i: integer;
    j: integer;
    mediana: integer;
  begin
    i := idx1;
    j := idx2;
    mediana := Data[(i + j) div 2];
    repeat
      while Data[i] < mediana do
        inc(i);
      while mediana < Data[j] do
        dec(j);
      if TThread.Current.CheckTerminated then
        exit;
      if i <= j then
      begin
        Swap(i, j);
        inc(i);
        dec(j);
      end;
    until i > j;
    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

begin
  qsort(0, Count - 1);
end;

{ TBoardMessage }

constructor TBoardMessage.CreateMessageDone(ABoard: TBoard);
begin
  MessageType := mtDone;
  Board := ABoard;
end;

constructor TBoardMessage.CreateMessageSwap(ABoard: TBoard;
  AIdx1, AIdx2: integer);
begin
  MessageType := mtSwap;
  Board := ABoard;
  SwapIndex1 := AIdx1;
  SwapIndex2 := AIdx2;
end;

end.
