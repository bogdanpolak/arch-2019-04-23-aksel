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
    function GenerateData: TArray<Integer>;
    function GetItemsCount: Integer;
  end;

implementation

{ TBoardController }

constructor TBoardController.CreateAndInit(AModel: TBoard; AView: TBoardView);
begin
  FModel := AModel;
  FView := AView;
end;

function TBoardController.GenerateData: TArray<Integer>;
begin
  FModel.GenerateData(GetItemsCount);
  Result := FModel.FData;
end;

function TBoardController.GetItemsCount: Integer;
begin
  Result := FView.ItemsCount;
end;

end.
