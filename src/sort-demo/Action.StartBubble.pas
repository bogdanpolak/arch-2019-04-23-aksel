unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort, Model.Board, Model.SortResults, View.Board, View.SortResults;

type
  TStartBubbleAction = class (TSortAction)
  private
    FBoardV: TBoardView;
    FBoardM: TBoard;
    FSortResultsV: TSortResultsView;
    FSortResultsM: TSortResults;

    procedure BubbleSort(var data: TArray<Integer>);
  public
    procedure InitVariables; override;
    procedure FreeVariables;
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Vcl.ExtCtrls, System.Diagnostics, System.TimeSpan;

function CountVisibleItems (paintbox: TPaintBox): integer;
begin
  Result := round(paintbox.Width / 6) - 1;
end;

procedure TStartBubbleAction.InitVariables;
begin
  inherited;
  FBoardV := TBoardView.Create;
  FBoardM := TBoard.Create;
  FSortResultsV := TSortResultsView.Create;
  FSortResultsM := TSortResults.Create;

  FBoardV.MaxValue := 100;
  FBoardM.MaxValue := 100;
  FSortResultsM.Name := 'Bubble Sort';
  FBoardM.Count := 0;
end;

procedure TStartBubbleAction.FreeVariables;
begin
  FBoardV.Free;
  FBoardM.Free;
  FSortResultsV.Free;
  FSortResultsM.Free;
end;

procedure TStartBubbleAction.DoWork;
var
  data: TArray<Integer>;
  sw: TStopwatch;
  EnlapsedTime: TTimeSpan;
begin
  FBoardM.PaintBox := Form1.PaintBox1;
//  Form1.PrepareSortDemo(PaintBox, data);
  FSortResultsM.DataSize := CountVisibleItems(FBoardM.PaintBox);
  FBoardM.GenerateData(FSortResultsM.DataSize);
  FBoardV.DrawBoard(FBoardM.PaintBox, FBoardM.FData);
  sw := TStopwatch.StartNew;
  BubbleSort(FBoardM.FData);
  FSortResultsM.Enlapsed := sw.Elapsed;
  Form1.DrawResults(FBoardM.PaintBox, 'BubbleSort', FSortResultsM.DataSize, FSortResultsM.Enlapsed, FBoardM.Count);

  FreeVariables;
end;

procedure TStartBubbleAction.BubbleSort(var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to Length(data) - 1 do
    for j := 0 to Length(data) - 2 do
      if data[j] > data[j + 1] then
      begin
        FBoardM.Swap(j, j + 1);
        FBoardV.DrawItem(FBoardM.PaintBox, j, data[j]);
        FBoardV.DrawItem(FBoardM.PaintBox, j + 1, data[j + 1]);
//        if Self. then
//          break;
      end;
end;

end.
