﻿{ * ------------------------------------------------------------------------
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
  FBoard.GenerateData(15);
  FBoard.GenerateData(0);
  CheckEquals(0, FBoard.Count, 'Nieodpowiednia liczba danych');
  CheckEquals(0, Length(FBoard.Data), 'Nieodpowiednia długość danych');
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
  myExcept: Boolean;
begin
  myExcept := False;
  FBoard.GenerateData(5);
  try
    FBoard.Swap(6,7);
  except
    on E: EBoardException do
      myExcept := True;
  end;
  Check(myExcept, 'Brak wyjątku podczas swap poza zakresem')
  // TODO: [TeamD] Zweryfkować czy swap dwóch indeksów dodatkich z poza zakresu
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
var
  thread: TThread;
  board: TBoard;
  ended: Boolean;
begin
  board := TBoard.Create;
  board.GenerateData(3);
  board.Data[0] := 1;
  board.Data[1] := 1;
  board.Data[2] := 1;
  ended := False;

  thread := TThread.CreateAnonymousThread(procedure
  begin
    board.SortBubble;
    ended := True;
  end);
  thread.FreeOnTerminate := True;
  thread.Start;

  while not ended do
    sleep(1);

  CheckEquals(1, board.Data[0], 'Pierwsza dana niepoprawna');
  CheckEquals(1, board.Data[1], 'Druga dana niepoprawna');
  CheckEquals(1, board.Data[2], 'Trzecia dana niepoprawna');
  //  TODO: [TeamD] wypełnij tablicę danymi [1, 1, 1] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
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
  //Patrząc na nazwę procedury mam tu sprawdzić czy 50 losowych licz jest z zakresu od 1 do max
  FBoard.GenerateData(50);
  for idx := 0 to FBoard.Count - 1 do
    if not((FBoard.Data[idx] >= 1) and (FBoard.Data[idx] <= FBoard.MaxValue)) then
      CheckTrue(False, Format('Niepoprawna liczba jest %d powinna być z zakresu od 1 do %d', [FBoard.Data[idx], FBoard.MaxValue]));
  // TODO: [TeamA] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  // TODO: [TeamD] j.w. = takie same zadanie
end;

procedure TestTBoard.TestSortInsertion_321;
var
  thread: TThread;
  board: TBoard;
  ended: Boolean;
begin
  board := TBoard.Create;
  board.GenerateData(3);
  board.Data[0] := 3;
  board.Data[1] := 2;
  board.Data[2] := 1;
  ended := False;

  thread := TThread.CreateAnonymousThread(procedure
  begin
    board.SortInsertion;
    ended := True;
  end);
  thread.FreeOnTerminate := True;
  thread.Start;

  while not ended do
    sleep(1);

  CheckEquals(1, board.Data[0], 'Pierwsza dana niepoprawna');
  CheckEquals(2, board.Data[1], 'Druga dana niepoprawna');
  CheckEquals(3, board.Data[2], 'Trzecia dana niepoprawna');
  // TODO: [TeamA] Sprawdzić sortowanie InsertionSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
end;

procedure TestTBoard.TestSortQuick_321;
var
  thread: TThread;
  board: TBoard;
  ended: Boolean;
begin
  board := TBoard.Create;
  board.GenerateData(3);
  board.Data[0] := 3;
  board.Data[1] := 2;
  board.Data[2] := 1;
  ended := False;

  thread := TThread.CreateAnonymousThread(procedure
  begin
    board.SortQuick;
    ended := True;
  end);
  thread.FreeOnTerminate := True;
  thread.Start;

  while not ended do
    sleep(1);

  CheckEquals(1, board.Data[0], 'Pierwsza dana niepoprawna');
  CheckEquals(2, board.Data[1], 'Druga dana niepoprawna');
  CheckEquals(3, board.Data[2], 'Trzecia dana niepoprawna');
  // TODO: [TeamA] Sprawdzić sortowanie QuickSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.
end;

initialization

RegisterTest(TestTBoard.Suite);

end.
