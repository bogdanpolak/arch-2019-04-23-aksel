{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit TestSortControler;

interface

uses
  System.SysUtils, System.Classes, System.Diagnostics, System.TimeSpan,
  TestFramework,
  Model.Board,
  Controler.Sort;

type
  // Test methods for class TSortControler

  TestTSortControler = class(TTestCase)
  strict private
    FBoard: TBoard;
    FSortControler: TSortControler;
    function TicksBetweenNow(AStartTicks: Cardinal): Cardinal;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestTerminateThread;
    procedure TestDispatchBoardMessage;
  end;

implementation

uses
  Winapi.Windows,
  View.Board,
  Mock.BoardView;

procedure TestTSortControler.SetUp;
begin
  FBoard := TBoard.Create;

  // TODO: Stworzyć FSortControler
  // w tym celu potrzebny jest obiekt, który implementuje inteface IBoardView
  // Proszę stworzyć tzw. zaślepkęm, czyki Mock, kótrzy prawie
  // W mocku potrzebne będzie zwracanie liczby widocznych danych
  // Mock prosze zdefinować w unit: Mock.BoardView.pas

  FSortControler := TSortControler.Create(FBoard, TBoardViewMock.Create);

  HaveResult := False;
  DrawItemCnt := 0;
end;

procedure TestTSortControler.TearDown;
begin
  FSortControler.Free;
  FSortControler := nil;

  FBoard.Free;
  FBoard := nil;
end;

procedure TestTSortControler.TestExecute;
var
  stamp: Cardinal;
  messPopedCnt: Integer;
  boardMess: TBoardMessage;
  done: Boolean;
begin
  // TODO: Sprawdzić metodę TSortControler.Execute
  (*
    Uwaga!
    ------
    Metoda Execute generuje dane i uruchamia nowy wątek roboczy w którym
    wykonywane jest sortowanie, czyli nie można od razy skończyć tego testu.
    Prosze wymyśleć jak można czekać na zakończenie wątku roboczego.

    Uwaga!
    ------
    Uruchomienie testu spowoduje zawieszenie się wątku roboczego, czyli nie
    można czekać w nieskończoność na jego zakończenie. Proszę ustawić timeout
    w czekaniu (np. 1 sekunda)

    TBorad nie jest w pełni wielowątkowy (tzw. thread-safe), ponieważ korzysta
    ze wspólnej pamięci, bez dodawania sekcji bezpiecznych. Proszę zlokalizować
    tą "czarną owcę" w TBoard. Prosze tutaj poniżej niapisać co to jest.
    Proszę nie poprawiać błędów w TBoard.
  *)

  FSortControler.Execute;

  stamp := GetTickCount;
  done := False;

  while (not done) and (TicksBetweenNow(stamp) div 1000 < 1) do
  begin
    Sleep(10);
    messPopedCnt := 0;
    while FMessageQueue.QueueSize > 0 do
    begin
      boardMess := FMessageQueue.PopItem;
      if boardMess.MessageType = mtDone then
      begin
        done := True;
        Break;
      end;
      Inc(messPopedCnt);
      if messPopedCnt >= 0 then
        Break;
    end;
  end;

  CheckTrue(done, 'Sortowanie nie zostało zakończone, timeout');
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

procedure TestTSortControler.TestTerminateThread;
var
  stamp: Cardinal;
  done: Boolean;
  boardMess: TBoardMessage;
begin
  // TODO: Sprawdzić działąnie metody TSortControler.TerminateThread
  (*
    Uwaga!!! Zadanie dla ambitnych :-)
    -----
    Test powinien urachamiać wątek roboczy (metoda: TSortControler.Execute), a
    po odczekaniu krótkiego czasu (15ms) powinen przerywać działanie wątku
    roboczego (metoda: TSortControler.TerminateThread.
  *)

  FMessageQueue.Grow(1000);

  FSortControler.Execute;

  WaitMilisecond(15);

  FSortControler.TerminateThread;

  stamp := GetTickCount;
  while (TicksBetweenNow(stamp) < 1000) do
    Sleep(10);

  done := False;
  while FMessageQueue.QueueSize > 0 do
  begin
    boardMess := FMessageQueue.PopItem;
    if boardMess.MessageType = mtDone then
    begin
      done := True;
      Break;
    end;
  end;

  CheckFalse(done, 'Nie powinno być MessageType = mtDone');
end;

function TestTSortControler.TicksBetweenNow(AStartTicks: Cardinal): Cardinal;
var
  stopTicks: Cardinal;
begin
  stopTicks := GetTickCount;
  if stopTicks >= AStartTicks then
    Result := stopTicks - AStartTicks
  else
    Result := High(Cardinal) - AStartTicks + stopTicks + 1;
end;

procedure TestTSortControler.TestDispatchBoardMessage;
var
  boardMess: TBoardMessage;
  stamp: Cardinal;
  done: Boolean;
  messPopedCnt: Integer;
begin
  // TODO: Sprawdzić czy po dodanu do kolejki FMessageQueue (w Model.Board.pas)
  // kilku komunikatów Swap zostaną oe poprawnie obsłużone przez metodę
  // DispatchBoardMessage

  FSortControler.Execute;

  stamp := GetTickCount;
  done := False;

  while (not done) and (TicksBetweenNow(stamp) div 1000 < 1) do
  begin
    Sleep(10);
    messPopedCnt := 0;
    while FMessageQueue.QueueSize > 0 do
    begin
      boardMess := FMessageQueue.PopItem;
      FSortControler.DispatchBoardMessage(boardMess);
      if boardMess.MessageType = mtDone then
      begin
        done := True;
        Break;
      end;
      Inc(messPopedCnt);
      if messPopedCnt >= 0 then
        Break;
    end;
  end;

  CheckTrue(HaveResult, 'Nie było DrawResult');
  CheckEquals(FBoard.FSwapCounter, DrawItemCnt / 2, 'Nieprawidłowa liczba wywołań DrawItem');
end;

initialization

RegisterTest(TestTSortControler.Suite);

end.
