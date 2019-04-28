{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Manager.Sort;

interface

uses
  System.Classes,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Model.Board, Model.SortResults, View.Board, View.SortResults,
  Controler.Sort;

type
  TSortManager = class(TComponent)
  private
    FSortAlgorithm: TSortAlgorithm;
    FBoard: TBoard;
    FSortResult: TSortResults;
    FSortControler: TSortControler;
    FBoardView: IBoardView;
    FSortResultView: ISortResultsView;
    function GetAlgorithmName: string;
  public
    constructor CreateAndInit(AOwner: TComponent;
      ASortAlgorithm: TSortAlgorithm; APaintBox: TPaintBox);
    destructor Destroy; override;
    procedure Execute;
    function DispatchSortMessage(m: TSortMessage): boolean;
  end;

implementation

uses
  View.Vcl.Board, View.Vcl.SortResults;

constructor TSortManager.CreateAndInit(AOwner: TComponent;
  ASortAlgorithm: TSortAlgorithm; APaintBox: TPaintBox);
begin
  inherited Create(AOwner);
  FSortAlgorithm := ASortAlgorithm;
  FBoard := TBoard.Create;
  FSortResult := TSortResults.Create;
  FBoardView := TBoardView.CreateAndInit(APaintBox, FBoard);
  FSortResult.Name := GetAlgorithmName;
  FSortResultView := TSortResultsView.CreateAndInit(APaintBox, FSortResult);
  FSortControler := TSortControler.Create(FBoard, FSortResult, FBoardView,
    FSortResultView);
end;

destructor TSortManager.Destroy;
begin
  FSortControler.Free;
  FSortResult.Free;
  FBoard.Free;
  inherited;
end;

function TSortManager.DispatchSortMessage(m: TSortMessage): boolean;
begin
  Result := (FBoard = m.Board);
  if Result then
    case m.MessageType of
      mtSwap:
        begin
          FBoardView.DrawItem(m.SwapIndex1);
          FBoardView.DrawItem(m.SwapIndex2);
        end;
      mtDone:
        FSortResultView.DrawResults;
    end;
end;

procedure TSortManager.Execute;
begin
  FBoard.GenerateData(FBoardView.CountVisibleItems);
  FBoardView.DrawBoard;
  FSortControler.DoSort(FSortAlgorithm);
end;

function TSortManager.GetAlgorithmName: string;
begin
  case FSortAlgorithm of
    saBubbleSort:
      Result := 'Bubble Sort';
    saQuickSort:
      Result := 'Quick Sort';
    saInsertionSort:
      Result := 'Insertion Sort';
  end;
end;

end.
