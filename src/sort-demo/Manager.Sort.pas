{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Manager.Sort;

interface

uses
  System.Classes,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Model.Board, Model.SortResults, View.Vcl.Board, View.Vcl.SortResults,
  Controler.Sort;

type
  TSortManager = class(TComponent)
  private
    FBoard: TBoard;
    FSortResult: TSortResults;
    FBoardView: TBoardView;
    FSortResultView: TSortResultsView;
    FSortControler: TSortControler;
    FSortAlgorithm: TSortAlgorithm;
    function GetAlgorithmName: string;
  public
    constructor CreateAndInit(AOwner: TComponent;
      ASortAlgorithm: TSortAlgorithm; APaintBox: TPaintBox);
    procedure Execute;
    function DispatchSortMessage(m: TSortMessage): boolean;
  end;

implementation

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
