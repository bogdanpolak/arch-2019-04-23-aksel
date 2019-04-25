unit Model.Board;

interface

type
  TBoard = class   // (TObject / TComponent)
  private
    FMaxValue: Integer;
  public
    FData: TArray<Integer>;
    procedure GenerateData (items: Integer);
    procedure Swap(i, j: Integer);
    property MaxValue: Integer write FMaxValue;
  end;

implementation

uses Action.StartQuick;

procedure TBoard.GenerateData(items: Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(FData, items);
  for i := 0 to Length(FData) - 1 do
    FData[i] := random(FMaxValue) + 1;
end;

procedure TBoard.Swap(i, j: Integer);
var
  v: Integer;
begin
  v := FData[i];
  FData[i] := FData[j];
  FData[j] := v;
end;

end.
