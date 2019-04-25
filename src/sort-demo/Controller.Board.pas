unit Controller.Board;

interface

uses
  Model.Board, View.Board;

type
  TBoardController = class
  private
    FModel: TBoard;
    FView: TBoardView;
  public
    constructor CreateAndInit(AModel: TBoard; AView: TBoardView);
    function GetItemsCount: Integer;
  end;

implementation

{ TBoardController }

constructor TBoardController.CreateAndInit(AModel: TBoard; AView: TBoardView);
begin
  FModel := AModel;
  FView := AView;
end;

function TBoardController.GetItemsCount: Integer;
begin
  Result := FView.ItemsCount;
end;

end.
