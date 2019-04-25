unit Model.Board;

interface

type
  TBoard = class(TObject)
  private
    FData: TArray<Integer>;
    FCount: Integer;
    FMaxValue: Integer;
  public
    constructor Create(AMaxValue: Integer);
    procedure GenerateData(AItemsCnt: Integer);
    procedure Swap(AIdx1, AIdx2: Integer);
    property Count: Integer read FCount write FCount;
  end;

implementation

uses Action.StartQuick;

constructor TBoard.Create(AMaxValue: Integer);
begin
  inherited Create;
  FMaxValue := AMaxValue;
end;

procedure TBoard.GenerateData(AItemsCnt: Integer);
var
  i: Integer;
begin
  Randomize;
  SetLength(FData, AItemsCnt);
  for i := 0 to Length(FData) - 1 do
    FData[i] := Random(FMaxValue) + 1;
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
