{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit TestSortControler;

interface

uses
  TestFramework,
  System.Diagnostics, System.TimeSpan, System.Classes,
  Model.Board,
  Controler.Sort;

type
  // Test methods for class TSortControler

  TestTSortControler = class(TTestCase)
  strict private
    FBoard: TBoard;
    FSortControler: TSortControler;
  private
    procedure WaitForSortThread(timeoutMs: integer);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestTerminateThread;
    procedure TestDispatchBoardMessage;
  end;

implementation

uses
  View.Board,
  System.SysUtils;

type
  TBoardViewMock = class(TInterfacedObject, IBoardView)
  const
    DataItemsCount = 11;
  public
    class var DrawCount: integer;
    procedure DrawBoard;
    procedure DrawItem(AIndex: integer);
    procedure DrawResults(const AAlgoritmName: string; AElapsedTime: TTimeSpan);
    function CountVisibleItems: integer;
  end;

procedure TestTSortControler.SetUp;
var
  FBoradView: IBoardView;
begin
  FBoard := TBoard.Create;
  FSortControler := TSortControler.Create(FBoard, TBoardViewMock.Create);
end;

procedure TestTSortControler.TearDown;
begin
  FSortControler.Free;
  FSortControler := nil;
  FBoard.Free;
  FBoard := nil;
end;

procedure TestTSortControler.WaitForSortThread(timeoutMs: integer);
var
  sw: TStopwatch;
  enlapsed: Int64;
begin
  sw := TStopwatch.StartNew;
  enlapsed := sw.ElapsedMilliseconds;
  while FSortControler.IsBusy and (enlapsed < timeoutMs) do
  begin
    Sleep(10);
    enlapsed := sw.ElapsedMilliseconds;
  end;
  Check(enlapsed < timeoutMs,
    Format('Waiting too log for sort thread to finish (timeout=%d ms)',
    [timeoutMs]));
end;

procedure TestTSortControler.TestExecute;
begin
  FSortControler.SortAlgorithm := saBubbleSort;
  FSortControler.Execute;
  WaitForSortThread(1000); // timeout in miliseconds
  CheckEquals(TBoardViewMock.DataItemsCount, FBoard.Count);
end;

procedure TestTSortControler.TestTerminateThread;
var
  IsBusy: Boolean;
begin
  FSortControler.SortAlgorithm := saBubbleSort;
  FSortControler.Execute;
  Sleep(5);
  Check(FSortControler.IsBusy = True, '[CP1] FSortControler.IsBusy');
  FSortControler.TerminateThread;
  Sleep(10);
  Check(FSortControler.IsBusy = False, '[CP2] FSortControler.IsBusy');
end;

procedure TestTSortControler.TestDispatchBoardMessage;
var
  ReturnValue: Boolean;
  m: TBoardMessage;
begin
  while FMessageQueue.QueueSize > 0 do
    FMessageQueue.PopItem;
  TBoardViewMock.DrawCount := 0;
  FMessageQueue.PushItem(TBoardMessage.CreateMessageSwap(FBoard, 1, 0));
  FMessageQueue.PushItem(TBoardMessage.CreateMessageSwap(nil, 2, 0));
  FMessageQueue.PushItem(TBoardMessage.CreateMessageSwap(FBoard, 3, 0));
  m := FMessageQueue.PopItem;
  Check(FSortControler.DispatchBoardMessage(m) = True,
    '[CP1] .DispatchBoardMessage');
  m := FMessageQueue.PopItem;
  Check(FSortControler.DispatchBoardMessage(m) = False,
    '[CP2] .DispatchBoardMessage');
  m := FMessageQueue.PopItem;
  Check(FSortControler.DispatchBoardMessage(m) = True,
    '[CP3] .DispatchBoardMessage');
  CheckEquals(4, TBoardViewMock.DrawCount, '[CP4] TBoardViewMock.DrawCount');
end;

{ TBoardViewMock }

function TBoardViewMock.CountVisibleItems: integer;
begin
  Result := DataItemsCount;
end;

procedure TBoardViewMock.DrawBoard;
begin

end;

procedure TBoardViewMock.DrawItem(AIndex: integer);
begin
  inc(TBoardViewMock.DrawCount);
end;

procedure TBoardViewMock.DrawResults(const AAlgoritmName: string;
  AElapsedTime: TTimeSpan);
begin

end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTSortControler.Suite);

end.
