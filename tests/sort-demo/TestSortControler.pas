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
  View.Board,
  Mock.BoardView;

procedure TestTSortControler.SetUp;
begin
  FBoard := TBoard.Create;
  // TODO: Stworzyć FSortControler
  //   w tym celu potrzebny jest obiekt, który implementuje inteface IBoardView
  //   Proszę stworzyć tzw. zaślepkęm, czyki Mock, kótrzy prawie
  //   W mocku potrzebne będzie zwracanie liczby widocznych danych
  //   Mock prosze zdefinować w unit: Mock.BoardView.pas
  (*
  FSortControler := TSortControler.Create(FBoard, TBoardViewMock.Create);
  *)
end;

procedure TestTSortControler.TearDown;
begin
  (*
  FSortControler.Free;
  FSortControler := nil;
  *)
  FBoard.Free;
  FBoard := nil;
end;

procedure TestTSortControler.TestExecute;
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
end;

procedure TestTSortControler.TestTerminateThread;
begin
  // TODO: Sprawdzić działąnie metody TSortControler.TerminateThread
  (*
    Uwaga!!! Zadanie dla ambitnych :-)
    -----
    Test powinien urachamiać wątek roboczy (metoda: TSortControler.Execute), a
    po odczekaniu krótkiego czasu (15ms) powinen przerywać działanie wątku
    roboczego (metoda: TSortControler.TerminateThread.
  *)
end;

procedure TestTSortControler.TestDispatchBoardMessage;
begin
  // TODO: Sprawdzić czy po dodanu do kolejki FMessageQueue (w Model.Board.pas)
  // kilku komunikatów Swap zostaną oe poprawnie obsłużone przez metodę
  // DispatchBoardMessage
end;

initialization

RegisterTest(TestTSortControler.Suite);

end.
