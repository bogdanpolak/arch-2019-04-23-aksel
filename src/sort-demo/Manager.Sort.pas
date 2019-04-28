{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Manager.Sort;

interface

uses
  System.Classes,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Model.Board,
  View.Board,
  Controler.Sort;

type
  TSortManager = class(TComponent)
  private
    FSortAlgorithm: TSortAlgorithm;
    FBoard: TBoard;
    FSortControler: TSortControler;
    FBoardView: IBoardView;
  public
    constructor CreateAndInit(AOwner: TComponent;
      ASortAlgorithm: TSortAlgorithm; APaintBox: TPaintBox);
    destructor Destroy; override;
    property Controler: TSortControler read FSortControler;
  end;

implementation

uses
  View.Vcl.Board;

constructor TSortManager.CreateAndInit(AOwner: TComponent;
  ASortAlgorithm: TSortAlgorithm; APaintBox: TPaintBox);
begin
  inherited Create(AOwner);
  FSortAlgorithm := ASortAlgorithm;
  FBoard := TBoard.Create;
  FBoardView := TVclBoardView.CreateAndInit(APaintBox, FBoard);
  FSortControler := TSortControler.Create(FBoard, FBoardView);
  FSortControler.SortAlgorithm := ASortAlgorithm;
end;

destructor TSortManager.Destroy;
begin
  FSortControler.Free;
  FBoard.Free;
  inherited;
end;

end.
