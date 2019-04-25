unit Model.Board;

interface

type
  TBoard = class // (TObject / TComponent)
  private
    FData: TArray<Integer>;
  public
    procedure GenerateData (items: Integer);
    procedure Swap (i,j: Integer);

    const
      MaxValue = 100;
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
    FData[i] := random(MaxValue) + 1;
end;

procedure TBoard.Swap(i, j: Integer);
begin

end;

end.
