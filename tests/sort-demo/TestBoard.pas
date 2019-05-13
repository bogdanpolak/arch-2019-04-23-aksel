{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit TestBoard;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes, System.JSON,
  TestFramework,
  Model.Board;

type
  TestTBoard = class(TTestCase)
  strict private
    FBoard: TBoard;
    function CreateJsonFromBoardData: TJSONArray;
  protected
    procedure FillBoard(arr: TArray<Integer>);
    function BoardToString: string;
    function BoardIsSorted: boolean;
    procedure CheckBoardData (const AExpected:string;
      const AFailedMessage: string = '');
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
    procedure TestSortBubble_13Random_Range1ToMax;
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

function TestTBoard.CreateJsonFromBoardData: TJSONArray;
var
  i: Integer;
begin
  Result := TJSONArray.Create;
  for i := 0 to FBoard.Count-1 do
    Result.Add(FBoard.Data[i])
end;

procedure TestTBoard.FillBoard (arr: TArray<Integer>);
var
  i: Integer;
begin
  // TODO: Zmienić na class-helper dla TBoard?
  FBoard.GenerateData(Length(arr));
  for i:=0 to Length(arr)-1 do
    FBoard.Data[i] := arr[i];
end;

function TestTBoard.BoardIsSorted: boolean;
var
  i: Integer;
begin
  // TODO: Zmienić na class-helper dla TBoard?
  for i := 1 to FBoard.Count-1 do
    if FBoard.Data[i-1]>FBoard.Data[i] then
    begin
      Result := False;
      exit;
    end;
  Result := True;
end;

function TestTBoard.BoardToString: string;
var
  jarr: TJSONArray;
begin
  jarr := CreateJsonFromBoardData;
  Result := jarr.ToString;
  jarr.Free;
end;


procedure TestTBoard.CheckBoardData(const AExpected, AFailedMessage: string);
var
  jarr: TJSONArray;
  ACurrent: string;
begin
  jarr := CreateJsonFromBoardData;
  ACurrent := jarr.ToString;
  jarr.Free;
  CheckEquals(AExpected, ACurrent, AFailedMessage);
end;


procedure TestTBoard.TestGenerate10Data;
begin
  FBoard.GenerateData(10);
  CheckEquals(10, FBoard.Count, 'Nieodpowiednia liczba danych');
end;

procedure TestTBoard.TestGenerateZeroData;
begin
  FBoard.GenerateData(0);
  CheckEquals(0,FBoard.Count);
end;

procedure TestTBoard.TestGenerateNegativeNumberOfData;
begin
  Self.ExpectedException := EBoardException;
  FBoard.GenerateData(-1);
  StopExpectingException();
end;

procedure TestTBoard.TestSwapZeroAndOne;
begin
  FillBoard([0,1]);
  FBoard.Swap(0,1);
  CheckBoardData('[1,0]');
end;

procedure TestTBoard.TestSwapTwoLastValues;
begin
  FillBoard([0,0,0,0,1]);
  FBoard.Swap(FBoard.Count-2,FBoard.Count-1);
  CheckBoardData('[0,0,0,1,0]');
end;

procedure TestTBoard.TestSwapNegativeIndexes;
begin
  FillBoard([1]);
  ExpectedException := EBoardException;
  FBoard.Swap(0,-1);
  StopExpectingException();
end;

procedure TestTBoard.TestSwapOutOfRangeIndex;
begin
  FillBoard([0,1]);
  ExpectedException := EBoardException;
  FBoard.Swap(1,2);
  StopExpectingException();
end;

procedure TestTBoard.TestSortBubble_123;
begin
  FillBoard([1,2,3]);
  FBoard.SortBubble;
  CheckBoardData('[1,2,3]');
end;

procedure TestTBoard.TestSortBubble_312;
begin
  FillBoard([3,2,1]);
  FBoard.SortBubble;
  CheckBoardData('[1,2,3]');
end;

procedure TestTBoard.TestSortBubble_111;
begin
  FillBoard([1,1,1]);
  FBoard.SortBubble;
  CheckBoardData('[1,1,1]');
end;

procedure TestTBoard.TestSortBubble_EmptyData;
begin
  FBoard.GenerateData(0);
  FBoard.SortBubble;
end;

procedure TestTBoard.TestSortBubble_13Random_Range1ToMax;
var
  ABefore: string;
  AAfter: string;
begin
  FBoard.GenerateData(13);
  ABefore := BoardToString;
  FBoard.SortBubble;
  AAfter := BoardToString;
  Check (BoardIsSorted,
    Format('Dla danych %s sortowanie działa źle. Wynik: %s',[ABefore,AAfter])
  );
end;

procedure TestTBoard.TestSortInsertion_321;
begin
  FillBoard([3,2,1]);
  FBoard.SortInsertion;
  CheckBoardData('[1,2,3]');
end;

procedure TestTBoard.TestSortQuick_321;
begin
  FillBoard([3,2,1]);
  FBoard.SortQuick;
  CheckBoardData('[1,2,3]');
end;

initialization

RegisterTest(TestTBoard.Suite);

end.
