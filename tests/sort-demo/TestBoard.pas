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
    function CreateLocalBoard321: TBoard;
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

function TestTBoard.CreateLocalBoard321: TBoard;
begin
  Result := TBoard.Create;
  Result.GenerateData(3);
  Result.Data[0] := 3;
  Result.Data[1] := 2;
  Result.Data[2] := 1;
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
end;

procedure TestTBoard.TestGenerateNegativeNumberOfData;
begin
  (*
    Użyj fukcji Self.StartExpectingException oraz Self.StopExpectingException
    Zobacz w żródłach: TestFramework.pas
  *)
  { [TeamC] Wpełnić FBoard ujemną liczbą danych }
  Self.StartExpectingException(EBoardException);
  FBoard.GenerateData(-10);
  Self.StopExpectingException('Powinien wyskoczyć raise: "Zła liczba danych do generacji"');
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
  { [TeamC] Zweryfkować czy swap dwóch ujemnych indeksów rzuca wyjątkiem }
  FBoard.GenerateData(20);
  Self.StartExpectingException(EBoardException);
  FBoard.Swap(-5, -7);   {todo: trzeba pooprawić funkcje}
  Self.StopExpectingException('Swap - dwa ujemne indesky powinny dać wyjątek');
end;

procedure TestTBoard.TestSwapOutOfRangeIndex;
begin
  // TODO: [TeamD] Zweryfkować czy swap dwóch indeksów dodatkich z poza zakresu
  //   rzuca wyjątkiem
end;

procedure TestTBoard.TestSortBubble_123;
begin
  //  TODO: [TeamA] wypełnij tablicę danymi [1, 2, 3] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
end;

procedure TestTBoard.TestSortBubble_312;
var
  localThread: TThread;
  localBoard: TBoard;
  stopped: Boolean;
begin
  { [TeamC] wypełnij tablicę danymi [3, 2, 1] uruchom sortowanie
      bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie }
  localBoard := CreateLocalBoard321;
  stopped := False;
  localThread := TThread.CreateAnonymousThread(procedure
  begin
    localBoard.SortBubble;
    stopped := True;
  end);
  localThread.FreeOnTerminate := True;
  localThread.Start;

  while not stopped do
    sleep(10);

  CheckTrue(localBoard.Data[0] = 1, 'Źle posortowana tabela bubble sort (idx: 0 -> should be 1 but is localBoard.Data[0])');
  CheckTrue(localBoard.Data[1] = 2, 'Źle posortowana tabela bubble sort (idx: 1 -> should be 2 but is localBoard.Data[1])');
  CheckTrue(localBoard.Data[2] = 3, 'Źle posortowana tabela bubble sort (idx: 2 -> should be 3 but is localBoard.Data[2])');

  localBoard.Free;
end;

procedure TestTBoard.TestSortBubble_111;
begin
  //  TODO: [TeamD] wypełnij tablicę danymi [1, 1, 1] uruchom sortowanie
  //    bąbelkowe oraz zweryfikuj czy dane wynikowe są posortowanie
end;

procedure TestTBoard.TestSortBubble_EmptyData;
var
  localThread: TThread;
  localBoard: TBoard;
  stopped: Boolean;
  exception: Boolean;
begin
  { [TeamC] Sprawdź czy sortowanie zadziała poprawnie dla pustego
     zbioru danych. Weryfikacja ma sprawdzić czy nie poawił się wyjątek }
  localBoard := TBoard.Create;
  stopped := False;
  localThread := TThread.CreateAnonymousThread(procedure
  begin
    exception := False;
    try
      localBoard.SortBubble;
    except
      exception := True;
    end;
    stopped := True;
  end);
  localThread.FreeOnTerminate := True;
  localThread.Start;
  while not stopped do
    sleep(10);
  CheckFalse(exception, 'Pojawił się wyjątek - sortowaniu babelkowym - pusta tablica, a nie powinien');
  localBoard.Free;
end;

procedure TestTBoard.TestSortBubble_50Random_Range1ToMax;
begin
  // TODO: [TeamA] Sprawdź czy sortowanie zadziała poprawnie dla pustego
  // TODO: [TeamD] j.w. = takie same zadanie
end;

procedure TestTBoard.TestSortInsertion_321;
var
  localThread: TThread;
  localBoard: TBoard;
  stopped: Boolean;
begin
  // TODO: [TeamA] Sprawdzić sortowanie InsertionSort na danych [3, 2, 1]
  { [TeamC] j.w. }
  // TODO: [TeamD] j.w.
  localBoard := CreateLocalBoard321;
  stopped := False;
  localThread := TThread.CreateAnonymousThread(procedure
  begin
    localBoard.SortInsertion;
    stopped := True;
  end);
  localThread.FreeOnTerminate := True;
  localThread.Start;

  while not stopped do
    sleep(10);

  CheckTrue(localBoard.Data[0] = 1, 'Źle posortowana tabela insertion sort (idx: 0 -> should be 1 but is localBoard.Data[0])');
  CheckTrue(localBoard.Data[1] = 2, 'Źle posortowana tabela insertion sort (idx: 1 -> should be 2 but is localBoard.Data[1])');
  CheckTrue(localBoard.Data[2] = 3, 'Źle posortowana tabela insertion sort (idx: 2 -> should be 3 but is localBoard.Data[2])');

  localBoard.Free;
end;

procedure TestTBoard.TestSortQuick_321;
var
  localThread: TThread;
  localBoard: TBoard;
  stopped: Boolean;
begin
  // TODO: [TeamA] Sprawdzić sortowanie QuickSort na danych [3, 2, 1]
  { [TeamC] j.w. }
  // TODO: [TeamD] j.w.
  localBoard := CreateLocalBoard321;
  stopped := False;
  localThread := TThread.CreateAnonymousThread(procedure
  begin
    localBoard.SortQuick;
    stopped := True;
  end);
  localThread.FreeOnTerminate := True;
  localThread.Start;

  while not stopped do
    sleep(10);

  CheckTrue(localBoard.Data[0] = 1, 'Źle posortowana tabela quick sort (idx: 0 -> should be 1 but is localBoard.Data[0])');
  CheckTrue(localBoard.Data[1] = 2, 'Źle posortowana tabela quick sort (idx: 1 -> should be 2 but is localBoard.Data[1])');
  CheckTrue(localBoard.Data[2] = 3, 'Źle posortowana tabela quick sort (idx: 2 -> should be 3 but is localBoard.Data[2])');

  localBoard.Free;
end;

initialization

RegisterTest(TestTBoard.Suite);

end.
