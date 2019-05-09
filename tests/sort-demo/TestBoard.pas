{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit TestBoard;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes, System.SyncObjs,
  TestFramework,
  Model.Board;

type
  TestTBoard = class(TTestCase)
  strict private
    FBoard: TBoard;
    FEvent: TEvent;
  private
    procedure GenerateData(AItemsCount: Integer; AItems: TArray<Integer> = []);
    procedure CreateAndStartSortThread(AProc: TProc);
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
  FEvent := TEvent.Create;
end;

procedure TestTBoard.TearDown;
begin
  FBoard.Free;
  FBoard := nil;
  FEvent.Free;
  FEvent := nil;
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

procedure TestTBoard.GenerateData(AItemsCount: Integer; AItems: TArray<Integer> = []);
var
  idx: Integer;
begin
  FBoard.GenerateData(AItemsCount);
  if Length(AItems) <= FBoard.Count then
    for idx := 0 to Length(AItems) - 1 do
      FBoard.Data[idx] := AItems[idx];
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
  GenerateData(100);
  GenerateData(0);
  CheckEquals(0, FBoard.Count, 'Nieodpowiednia ilość danych - count');
  CheckEquals(0, Length(FBoard.Data), 'Nieodpowiednia ilość danych - length');
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
begin
  // TODO: [TeamA] Zweryfkować swap indeksów 0 i 1
  // Uwaga! Najpierw trzeba wypełnić dane
end;

procedure TestTBoard.TestSwapTwoLastValues;
begin
  // TODO: [TeamA] Zweryfkować swap dwóch ostatnich indeksów max-2 oraz max-1
  // Uwaga! Trzeba wypełnić dane przynajmiej 3 elementami
end;

procedure TestTBoard.TestSwapNegativeIndexes;
begin
  // TODO: [TeamC] Zweryfkować czy swap dwóch ujemnych indeksów rzuca wyjątkiem
end;

procedure TestTBoard.TestSwapOutOfRangeIndex;
var
  wasException: Boolean;
begin
  // TODO: [TeamD] Zweryfkować czy swap dwóch indeksów dodatkich z poza zakresu
  //   rzuca wyjątkiem
  wasException := False;
  GenerateData(10);
  try
    FBoard.Swap(56, 47);
  except
    on E: EArgumentOutOfRangeException do
      wasException := True;
  end;
  CheckTrue(wasException, 'Swap elementów poza rozmiarem tablicy nie wygenerował wyjątku');
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
  GenerateData(3, [1,1,1]);
  CreateAndStartSortThread(FBoard.SortBubble);
  CheckTrue(FEvent.WaitFor(100) = wrSignaled);
  CheckEquals(0, FBoard.FSwapCounter, 'Wykonano conajmniej jedną zmianę tych samych elementów');
end;

procedure TestTBoard.TestSortBubble_EmptyData;
begin
  // [TeamC] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  //   zbioru danych. Weryfikacja ma sprawdzić czy nie poawił się wyjątek
end;

procedure TestTBoard.TestSortBubble_50Random_Range1ToMax;
var
  idx: Integer;
begin
  // TODO: [TeamA] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  // TODO: [TeamD] j.w. = takie same zadanie

  GenerateData(50);
  for idx := 0 to FBoard.Count - 1 do
    CheckTrue((FBoard.Data[idx] >= 1) and (FBoard.Data[idx] <= FBoard.MaxValue), Format('Wygenerowano dane przekraczające wyznaczony zakres 1 - %d (wygenerowano: %d)', [FBoard.MaxValue, FBoard.Data[idx]]));
end;

procedure TestTBoard.CreateAndStartSortThread(AProc: TProc);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      AProc;
      FEvent.SetEvent;
    end).Start;
end;

procedure TestTBoard.TestSortInsertion_321;
begin
  // TODO: [TeamA] Sprawdzić sortowanie InsertionSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
  GenerateData(3, [3, 2, 1]);
  CreateAndStartSortThread(FBoard.SortInsertion);

  CheckTrue(FEvent.WaitFor(100) = wrSignaled);
  CheckEquals(1, FBoard.FSwapCounter, 'Niepoprawna ilość swapów');
  CheckEquals(1, FBoard.Data[0], 'Pierwszy element jest błędny');
  CheckEquals(2, FBoard.Data[1], 'Drugi element jest błędny');
  CheckEquals(3, FBoard.Data[2], 'Trzeci element jest błędny');
end;

procedure TestTBoard.TestSortQuick_321;
begin
  // TODO: [TeamA] Sprawdzić sortowanie QuickSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
  GenerateData(3, [3, 2, 1]);
  CreateAndStartSortThread(FBoard.SortQuick);

  CheckTrue(FEvent.WaitFor(100) = wrSignaled);
  CheckEquals(2, FBoard.FSwapCounter, 'Niepoprawna ilość swapów');
  CheckEquals(1, FBoard.Data[0], 'Pierwszy element jest błędny');
  CheckEquals(2, FBoard.Data[1], 'Drugi element jest błędny');
  CheckEquals(3, FBoard.Data[2], 'Trzeci element jest błędny');
end;

initialization

RegisterTest(TestTBoard.Suite);

end.
