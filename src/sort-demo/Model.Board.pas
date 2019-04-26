unit Model.Board;

interface

uses
  System.SysUtils;

type
  TBoard = class
  private
    FData: TArray<Integer>;
    function GetCount: Integer;
  public
    procedure GenerateData(AItemsCnt: Integer);
    procedure Swap(AIdx1, AIdx2: Integer);

    property Count: Integer read GetCount;
    property Data: TArray<Integer> read FData;
  end;

  EBoardException = class(Exception);

const
  MaxValue = 100;

implementation

uses Action.StartQuick;

procedure TBoard.GenerateData(AItemsCnt: Integer);
var
  i: Integer;
begin
  Randomize;
  if (AItemsCnt <= 0) then
    raise EBoardException.Create('Z³a liczba danych do generacji');
  SetLength(FData, AItemsCnt);
  for i := 0 to Length(FData) - 1 do
    FData[i] := Random(MaxValue) + 1;
end;

function TBoard.GetCount: Integer;
begin
  Result := Length(FData);
end;

procedure TBoard.Swap(AIdx1, AIdx2: Integer);
var
  v: Integer;
begin
  v := FData[AIdx1];
  FData[AIdx1] := FData[AIdx2];
  FData[AIdx2] := v;
end;

end.
