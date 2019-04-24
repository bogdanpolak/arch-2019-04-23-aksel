unit Thread.Sort;

interface

uses
  System.Classes, Vcl.ExtCtrls;

type
  TSortKind = (skInsertionSort, skBubbleSort, skQuickSort);

  TSortThread = class(TThread)
  private
    FSortKind: TSortKind;
    procedure InsertionSort(var data: TArray<Integer>);
    procedure swap(i, j: Integer; var data: TArray<Integer>);
    procedure GenerateData(var data: TArray<Integer>; items: Integer);
    procedure BubbleSort(var data: TArray<Integer>);
    procedure QuickSort(var data: TArray<Integer>);
  public
    constructor Create(SortKind: TSortKind);
  protected
    procedure Execute; override;
  end;

procedure DrawItem(paintbox: TPaintBox; index, value: Integer);

const
  MaxValue = 100;

var
  SwapPaintBox: TPaintBox;
  SwapCounter: Integer;

implementation

uses
  System.Diagnostics, Vcl.Graphics, Colors.Hsl, Winapi.Windows;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure TSortThread.UpdateCaption;
  begin
  Form1.Caption := 'Updated in a thread';
  end;

  or

  Synchronize(
  procedure
  begin
  Form1.Caption := 'Updated in thread via an anonymous method'
  end
  )
  );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

function GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value * 256 / (MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

procedure DrawItem(paintbox: TPaintBox; index, value: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := paintbox.Height;
  j := round(value * maxhg / MaxValue);
  c := paintbox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := paintbox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(value);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

{ TSortThread }

constructor TSortThread.Create(SortKind: TSortKind);
begin
  inherited Create(False);
  FSortKind := SortKind;
end;

procedure WaitMilisecond(timeMs: double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TSortThread.swap(i, j: Integer; var data: TArray<Integer>);
var
  v: Integer;
  data2: TArray<Integer>;
begin
  v := data[i];
  data[i] := data[j];
  data[j] := v;
  data2 := data;
  Synchronize(
    procedure
    begin
      DrawItem(SwapPaintBox, i, data[i]);
      DrawItem(SwapPaintBox, j, data[j]);
    end);
  // Application.ProcessMessages;
  inc(SwapCounter);
  WaitMilisecond(4.5);
end;

procedure TSortThread.BubbleSort(var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data) - 1 do
    for j := 0 to Length(data) - 2 do
      if data[j] > data[j + 1] then
      begin
        swap(j, j + 1, data);
        if Self.Terminated then
          exit;
      end;
  // DrawResults(SwapPaintBox, 'BubleSort', Length(data), sw.Elapsed, SwapCounter);
end;

procedure TSortThread.QuickSort(var data: TArray<Integer>);
  procedure qsort(idx1, idx2: Integer);
  var
    i: Integer;
    j: Integer;
    mediana: Integer;
  begin
    i := idx1;
    j := idx2;
    mediana := data[(i + j) div 2];
    repeat
      while data[i] < mediana do
        inc(i);
      while mediana < data[j] do
        dec(j);
      if i <= j then
      begin
        swap(i, j, data);
        inc(i);
        dec(j);
      end;
    until i > j;
    if Self.Terminated then
      exit;

    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

var
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  qsort(0, Length(data) - 1);
  // DrawResults(SwapPaintBox, 'QuickSort', Length(data), sw.Elapsed, SwapCounter);
end;

procedure TSortThread.InsertionSort(var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
  mini: Integer;
  minv: Integer;
begin
  sw := System.Diagnostics.TStopwatch.StartNew;
  for i := 0 to Length(data) - 1 do
  begin
    mini := i;
    minv := data[i];
    for j := i + 1 to Length(data) - 1 do
    begin
      if data[j] < minv then
      begin
        mini := j;
        minv := data[j];
      end;
    end;
    if mini <> i then
      swap(i, mini, data);
    if Self.Terminated then
      exit;
  end;
  // DrawResults (SwapPaintBox, 'Insertion Sort', Length(data), sw.Elapsed, SwapCounter );
end;

procedure TSortThread.GenerateData(var data: TArray<Integer>; items: Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(data, items);
  for i := 0 to Length(data) - 1 do
    data[i] := random(MaxValue) + 1;
end;

procedure TSortThread.Execute;
var
  data: TArray<Integer>;
begin
  NameThreadForDebugging('SortThread');
  { Place thread code here }
  case FSortKind of
    skInsertionSort:
      begin
        GenerateData(data, 100);
        InsertionSort(data);
      end;
    skBubbleSort:
      begin
        GenerateData(data, 100);
        BubbleSort(data);
      end;
    skQuickSort:
      begin
        GenerateData(data, 100);
        QuickSort(data);
      end;
  end;
end;

end.
