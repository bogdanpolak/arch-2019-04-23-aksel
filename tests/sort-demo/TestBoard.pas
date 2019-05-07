{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit TestBoard;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  TestFramework,
  Model.Board;

type
  TestTBoard = class(TTestCase)
  strict private
    FBoard: TBoard;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // TBoard.Generate
    procedure TestGenerate10Data;
    procedure TestGenerateZeroData;
    procedure TestGenerateNegativeNumberOfData;
    // TBorad.Swap:
    procedure TestSwapZeroAndOne;
    procedure TestSwapTwoLastValues;
    procedure TestSwapNegativeIndexes;
    procedure TestSwapOutOfRangeIndex;
    // TBorad.SortBubble:
    procedure TestSortBubble_123;
    procedure TestSortBubble_312;
    procedure TestSortBubble_111;
    procedure TestSortBubble_EmptyData;
    procedure TestSortBubble_50Random_Range1ToMax;
    // TBorad.Sort... :
    procedure TestSortInsertion_321;
    procedure TestSortQuick_321;
  end;

implementation

procedure TestTBoard.SetUp;
begin
  FBoard := TBoard.Create;
end;

procedure TestTBoard.TearDown;
begin
  FBoard.Free;
  FBoard := nil;
end;

procedure TestTBoard.TestGenerate10Data;
begin
  FBoard.GenerateData(10);
  CheckEquals(10, FBoard.Count, 'Nieodpowiednia liczba danych');
  (*
    Self.CheckEquals (expected, actual, msg)
    - sprawdza czy actual = expected i jeśli nie jest to zwraca negatywny
      wynik testu
    - tylko w przyapdku negatywnego wyniku wyświetalny jest komunikat msg
  *)

end;

procedure TestTBoard.TestGenerateZeroData;
begin
  // TODO: [TeamA] Zweyfikuj działanie grerate dla 0
  // TODO: [TeamD]  j.w. = takie same zadanie
  (*
    Kroki:
    1. Generate(n), gdzie n>=1 - wypełnij dowolną liczbą danych
    2. Gerate(0) - wypełniż zero elementów
    3. Zweryfikuj czy Count = 0
    4. Zweryfikuj czy Length(Data)=0
  *)
end;

procedure TestTBoard.TestGenerateNegativeNumberOfData;
begin
  // TODO: [TeamC] Wpełnić FBoard ujemną liczbą danych
  (*
    Użyj fukcji Self.StartExpectingException oraz Self.StopExpectingException
    Zobacz w żródłach: TestFramework.pas
  *)
end;

procedure TestTBoard.TestSwapZeroAndOne;
var
  temp0: Integer;
  temp1: Integer;
begin
  // TODO: [TeamA] Zweryfkować swap indeksów 0 i 1
  // Uwaga! Najpierw trzeba wypełnić dane

  FBoard.GenerateData(5);

  temp0 := FBoard.Data[0];
  temp1 := FBoard.Data[1];

  FBoard.Swap(0, 1);

  Check(temp0 = FBoard.Data[1], 'Wartości się nie zamieniły');
  Check(temp1 = FBoard.Data[0], 'Wartości się nie zamieniły');
end;

procedure TestTBoard.TestSwapTwoLastValues;
var
  tempM2: Integer;
  tempM1: Integer;
begin
  // TODO: [TeamA] Zweryfkować swap dwóch ostatnich indeksów max-2 oraz max-1
  // Uwaga! Trzeba wypełnić dane przynajmiej 3 elementami

  FBoard.GenerateData(10);

  tempM2 := FBoard.Data[FBoard.Count - 2];
  tempM1 := FBoard.Data[FBoard.Count - 1];

  FBoard.Swap(FBoard.Count - 2, FBoard.Count - 1);

  Check(tempM2 = FBoard.Data[FBoard.Count - 1], 'Wartości się nie zamieniły');
  Check(tempM1 = FBoard.Data[FBoard.Count - 2], 'Wartości się nie zamieniły');
end;

procedure TestTBoard.TestSwapNegativeIndexes;
begin
  // TODO: [TeamC] Zweryfkować czy swap dwóch ujemnych indeksów rzuca wyjątkiem
end;

procedure TestTBoard.TestSwapOutOfRangeIndex;
begin
  // TODO: [TeamD] Zweryfkować czy swap dwóch indeksów dodatkich z poza zakresu
  //   rzuca wyjątkiem
end;

procedure TestTBoard.TestSortBubble_123;
var
  myBoard: TBoard;
  myThread: TThread;
  myThreadStop: Boolean;
begin
  //  TODO: [TeamA] wypełnij tablicę danymi [1, 2, 3] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie

  myBoard := FBoard.Create;

  myBoard.GenerateData(3);
  myBoard.Data[0] := 1;
  myBoard.Data[1] := 2;
  myBoard.Data[2] := 3;

  myThreadStop := False;
  myThread := TThread.CreateAnonymousThread(procedure
  begin
    myBoard.SortBubble;
    myThreadStop := True;
  end);
  myThread.FreeOnTerminate := True;
  myThread.Start;

  while not myThreadStop do
    Sleep(25);

  CheckTrue(myBoard.Data[0] = 1, 'Tablica jest źle posortowana');
  CheckTrue(myBoard.Data[1] = 2, 'Tablica jest źle posortowana');
  CheckTrue(myBoard.Data[2] = 3, 'Tablica jest źle posortowana');
end;

procedure TestTBoard.TestSortBubble_312;
begin
  //  TODO: [TeamC] wypełnij tablicę danymi [1, 2, 3] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
end;

procedure TestTBoard.TestSortBubble_111;
begin
  //  TODO: [TeamD] wypełnij tablicę danymi [1, 1, 1] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
end;

procedure TestTBoard.TestSortBubble_EmptyData;
begin
  // [TeamC] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  //   zbioru danych. Weryfikacja ma sprawdzić czy nie poawił się wyjątek
end;

procedure TestTBoard.TestSortBubble_50Random_Range1ToMax;
begin
  // TODO: [TeamA] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  // TODO: [TeamD] j.w. = takie same zadanie
end;

procedure TestTBoard.TestSortInsertion_321;
begin
  // TODO: [TeamA] Sprawdzić sortowanie InsertionSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
end;

procedure TestTBoard.TestSortQuick_321;
begin
  // TODO: [TeamA] Sprawdzić sortowanie QuickSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
end;

initialization

RegisterTest(TestTBoard.Suite);

end.
