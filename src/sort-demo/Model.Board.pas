unit Model.Board;

interface

type
  TBoard = class // (TObject / TComponent)
  private
    data: TArray<Integer>;
    FCount: integer;
  public
    procedure GenerateData (items: Integer);
    procedure Swap (i,j: Integer);
    property Count: Integer read FCount write FCount;
  end;

implementation

uses Action.StartQuick;

procedure TBoard.GenerateData(items: Integer);
begin

end;

procedure TBoard.Swap(i, j: Integer);
begin

end;

end.
