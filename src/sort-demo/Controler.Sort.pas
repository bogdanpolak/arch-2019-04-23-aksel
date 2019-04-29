{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Controler.Sort;

interface

uses
  System.Diagnostics, System.Classes, System.TimeSpan,
  Vcl.ExtCtrls,
  Model.Board,
  View.Board,
  Thread.Sort;

type
  TSortAlgorithm = (saBubbleSort, saQuickSort, saInsertionSort);

  TSortControler = class
  private
    function GetAlgorithmName: string;
  protected
    FElapsedTime: TTimeSpan;
    FSortAlgorithm: TSortAlgorithm;
    FBoard: TBoard;
    FBoardView: IBoardView;
    FControlerThread: TSortThread;
    procedure DoSort(ASortAlgorithm: TSortAlgorithm);
  public
    constructor Create(ABoard: TBoard;  ABoardView: IBoardView);
    destructor Destroy; override;
    procedure Execute;
    function DispatchBoardMessage(m: TBoardMessage): boolean;
    property SortAlgorithm: TSortAlgorithm read FSortAlgorithm 
      write FSortAlgorithm;
  end;

implementation

uses
  System.SysUtils,
  Winapi.Windows;

constructor TSortControler.Create(ABoard: TBoard;  ABoardView: IBoardView);
begin
  inherited Create();
  FBoard := ABoard;
  FBoardView := ABoardView;
end;

destructor TSortControler.Destroy;
begin
  if (FControlerThread <> nil) and FControlerThread.IsRunning then begin
    FControlerThread.Terminate;
  end;
  inherited;
end;

function TSortControler.GetAlgorithmName: string;
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


procedure TSortControler.DoSort(ASortAlgorithm: TSortAlgorithm);
var
  StopWatch: TStopwatch;
  AName: string;
begin
  FSortAlgorithm := ASortAlgorithm;
  StopWatch := TStopwatch.StartNew;
  AName := GetAlgorithmName();
  FControlerThread := TSortThread.CreateAndInit( AName,
    procedure
    begin
      case ASortAlgorithm of
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
      FElapsedTime := StopWatch.Elapsed;
      FMessageQueue.PushItem(TBoardMessage.CreateMessageDone(FBoard));
    end);
end;

procedure TSortControler.Execute;
begin
  FBoard.GenerateData(FBoardView.CountVisibleItems);
  FBoardView.DrawBoard;
  DoSort(FSortAlgorithm);
end;

function TSortControler.DispatchBoardMessage(m: TBoardMessage): boolean;
var
  AName: String;
begin
  Result := (FBoard = m.Board);
  if Result then begin
    AName := GetAlgorithmName();
    case m.MessageType of
      mtSwap:
        begin
          FBoardView.DrawItem(m.SwapIndex1);
          FBoardView.DrawItem(m.SwapIndex2);
        end;
      mtDone:
        FBoardView.DrawResults (AName, FElapsedTime);
    end;
  end;
end;


end.
