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
    function CreateMyBoard(IIdx1, IIdx2, IIdx3: Integer): TBoard;
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

function TestTBoard.CreateMyBoard(IIdx1, IIdx2, IIdx3: Integer): TBoard;
begin
  Result := TBoard.Create;

  Result.GenerateData(3);
  Result.Data[0] := IIdx1;
  Result.Data[1] := IIdx2;
  Result.Data[2] := IIdx3;
end;

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

  Self.StartExpectingException(EBoardException);
  FBoard.GenerateData(0);
  Self.StopExpectingException('Wymagany błąd: "Zła liczba danych do generacji"');

  Check(FBoard.Count = 0, 'Wartość Count różna od 0');
  Check(Length(FBoard.Data) = 0, 'Wartość Length różna od 0');
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

  myBoard := CreateMyBoard(1, 2, 3);

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
var
  myBoard: TBoard;
  myThread: TThread;
  myThreadStop: Boolean;
  idx: Integer;
begin
  // TODO: [TeamA] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  // TODO: [TeamD] j.w. = takie same zadanie
  myBoard := TBoard.Create;

  myBoard.GenerateData(50);

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

  for idx := 0 to myBoard.Count - 2 do
    CheckTrue(myBoard.Data[idx] < myBoard.Data[idx + 1], 'Tablica jest źle posortowana');
end;

procedure TestTBoard.TestSortInsertion_321;
var
  myBoard: TBoard;
  myThread: TThread;
  myThreadStop: Boolean;
begin
  // TODO: [TeamA] Sprawdzić sortowanie InsertionSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.

  myBoard := CreateMyBoard(3, 2, 1);

  myThreadStop := False;
  myThread := TThread.CreateAnonymousThread(procedure
  begin
    myBoard.SortInsertion;
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

procedure TestTBoard.TestSortQuick_321;
var
  myBoard: TBoard;
  myThread: TThread;
  myThreadStop: Boolean;
begin
  // TODO: [TeamA] Sprawdzić sortowanie QuickSort na danych [3, 2, 1]
  // TODO: [TeamC] j.w.
  // TODO: [TeamD] j.w.

  myBoard := CreateMyBoard(3, 2, 1);

  myThreadStop := False;
  myThread := TThread.CreateAnonymousThread(procedure
  begin
    myBoard.SortQuick;
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

initialization

RegisterTest(TestTBoard.Suite);

end.
