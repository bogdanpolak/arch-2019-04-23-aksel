unit View.Board;

interface

uses
  Vcl.ExtCtrls;

type
  TBoardView = class
  private
    FPaintBox: TPaintBox;
    function GetItemsCount: Integer;
  public
    constructor CreateAndInit(APaintBox: TPaintBox);

    property ItemsCount: Integer read GetItemsCount;
  end;

implementation

{ TBoardView }

constructor TBoardView.CreateAndInit(APaintBox: TPaintBox);
begin
  FPaintBox := APaintBox;
end;

function TBoardView.GetItemsCount: Integer;
begin
  Result := round(FPaintBox.Width / 6) - 1;
end;

end.
