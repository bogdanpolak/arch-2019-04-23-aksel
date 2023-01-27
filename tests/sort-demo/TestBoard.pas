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
    // TBoard.Swap:
    procedure TestSwapZeroAndOne;
    procedure TestSwapTwoLastValues;
    procedure TestSwapNegativeIndexes;
    procedure TestSwapOutOfRangeIndex;
    // TBoard.SortBubble:
    procedure TestSortBubble_123;
    procedure TestSortBubble_312;
    procedure TestSortBubble_111;
    procedure TestSortBubble_EmptyData;
    procedure TestSortBubble_50Random_Range1ToMax;
    // TBoard.Sort... :
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
    - tylko w przypadku negatywnego wyniku wyświetlany jest komunikat msg
  *)

end;

procedure TestTBoard.TestGenerateZeroData;
begin
  // TODO: [TeamA] Zweryfikuj działanie generate dla 0
  // TODO: [TeamD]  j.w. = takie same zadanie
  (*
    Kroki:
    1. Generate(n), gdzie n>=1 - wypełnij dowolną liczbą danych
    2. Generate(0) - wypełnij zero elementów
    3. Zweryfikuj czy Count = 0
    4. Zweryfikuj czy Length(Data)=0
  *)
end;

procedure TestTBoard.TestGenerateNegativeNumberOfData;
begin
  // TODO: [TeamC] Wypełnij FBoard ujemną liczbą danych
  (*
    Użyj funkcji Self.StartExpectingException oraz Self.StopExpectingException
    Zobacz w źródłach: TestFramework.pas
  *)
end;

procedure TestTBoard.TestSwapZeroAndOne;
begin
  // TODO: [TeamA] Zweryfikować swap indeksów 0 i 1
  // Uwaga! Najpierw trzeba wypełnić dane
end;

procedure TestTBoard.TestSwapTwoLastValues;
begin
  // TODO: [TeamA] Zweryfikować swap dwóch ostatnich indeksów max-2 oraz max-1
  // Uwaga! Trzeba wypełnić dane przynajmniej 3 elementami
end;

procedure TestTBoard.TestSwapNegativeIndexes;
begin
  // TODO: [TeamC] Zweryfikować czy swap dwóch ujemnych indeksów rzuca wyjątkiem
end;

procedure TestTBoard.TestSwapOutOfRangeIndex;
begin
  // TODO: [TeamD] Zweryfikować czy swap dwóch indeksów dodatnich z poza zakresu
  //   rzuca wyjątkiem
end;

procedure TestTBoard.TestSortBubble_123;
begin
  //  TODO: [TeamA] wypełnij tablicę danymi [1, 2, 3] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
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
  //   zbioru danych. Weryfikacja ma sprawdzić czy nie pojawił się wyjątek
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
