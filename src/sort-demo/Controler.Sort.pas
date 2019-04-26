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
  TSortControler = class
  protected
    FStopwatch: TStopwatch;

    FBoard: TBoard;
    FSortResult: TSortResults;

    FBoardView: IBoardView;
    FSResultView: ISortResultsView;

    FSwapCounter: Integer;
    FSWatch: TStopwatch;
    FControlerThread: TSortControlerThread;
    procedure VisualSwap(AIdx1: Integer; AIdx2: Integer);
    procedure WaitMilisecond(ATimeMs: Double);
  public
    constructor CreateAndInit(); virtual;
    destructor Destroy; override;
    procedure DoSort; virtual; abstract;
  end;

implementation

uses
  Winapi.Windows;

{ TControlerBasicSort }

constructor TSortControler.CreateAndInit(AOwner: TComponent; APaintBox: TPaintBox);
begin
  inherited Create(AOwner);
  FPaintBox := APaintBox;
  FBoard := TBoard.Create;
  FBoardView := TBoardView.CreateAndInit(FPaintBox, FBoard);
  FSortResult := TSortResults.Create;
  FSResultView := TSortResultsView.CreateAndInit(FPaintBox, FSortResult);
end;

destructor TSortControler.Destroy;
begin
  FBoard.Free;
  FSortResult.Free;
  if (FControlerThread<>nil) and FControlerThread.IsRunning then
    FControlerThread.Terminate;
  inherited;
end;

procedure TSortControler.WaitMilisecond(ATimeMs: Double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < ATimeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TSortControler.VisualSwap(AIdx1: Integer; AIdx2: Integer);
begin
  FBoard.Swap(AIdx1, AIdx2);
  TSortControlerThread.Synchronize(FControlerThread, procedure
  begin
            FBoardView.DrawItem(AIdx1);
            FBoardView.DrawItem(AIdx2);
          end);
  inc(FSwapCounter);
  WaitMilisecond(4.5);
end;

end.
