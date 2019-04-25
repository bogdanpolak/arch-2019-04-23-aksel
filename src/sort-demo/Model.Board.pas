unit Model.Board;

interface

type
  TBoard = class // (TObject / TComponent)
  private
    FCount: integer;
  public
  {TODO Property?}
    FData: TArray<Integer>;
    procedure GenerateData (AItems: Integer);
    procedure Swap (AIdx1, AIdx2: Integer);
    property Count: Integer read FCount write FCount;
  end;

implementation

uses Action.StartQuick, View.Board;

procedure TBoard.GenerateData(AItems: Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(FData, AItems);
  for i := 0 to Length(FData) - 1 do
    FData[i] := random(MaxValue) + 1;
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
