unit Controler.Sort;

interface

uses
  System.Diagnostics, System.Classes,
  Vcl.ExtCtrls,
  Model.Board,
  Model.SortResults,
  View.Board,
  View.SortResults,
  Thread.SortControler;

type
  TSortAlgorithm = (saBubbleSort, saQuickSort, saInsertionSort);

  TSortControler = class
  protected
    FBoard: TBoard;
    FSortResult: TSortResults;
    FBoardView: IBoardView;
    FSortResultView: ISortResultsView;
    FControlerThread: TSortControlerThread;
  public
    constructor Create(ABoard: TBoard; ASortResult: TSortResults;
      ABoardView: IBoardView; ASortResultView: ISortResultsView);
    destructor Destroy; override;
    procedure DoSort(SortAlgorithm: TSortAlgorithm);
  end;

implementation

uses
  System.SysUtils,
  Winapi.Windows;

constructor TSortControler.Create(ABoard: TBoard; ASortResult: TSortResults;
  ABoardView: IBoardView; ASortResultView: ISortResultsView);
begin
  inherited Create();
  FBoard := ABoard;
  FBoardView := ABoardView;
  FSortResult := ASortResult;
  FSortResultView := ASortResultView;
end;

destructor TSortControler.Destroy;
begin
  FBoard.Free;
  FSortResult.Free;
  if (FControlerThread <> nil) and FControlerThread.IsRunning then
    FControlerThread.Terminate;
  inherited;
end;

procedure TSortControler.DoSort(SortAlgorithm: TSortAlgorithm);
var
  StopWatch: TStopwatch;
  ASortResult: TSortResults;
begin
  StopWatch := TStopWatch.StartNew;
  ASortResult := FSortResult;
  FControlerThread := TSortControlerThread.CreateAndInit(
    procedure
    begin
      case SortAlgorithm of
        saBubbleSort:
          FBoard.SortBubble;
        saQuickSort:
          FBoard.SortQuick;
        saInsertionSort:
          FBoard.SortInsertion;
      else
        raise Exception.Create('Not supported');
      end;
    end,
    procedure
    begin
      ASortResult.ElapsedTime := StopWatch.Elapsed;
    end);
end;

end.
