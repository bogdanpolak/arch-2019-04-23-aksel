unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  System.TimeSpan,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    EnableSorting: Boolean;
    SwapCounter: Integer;
    procedure PrepareSortDemo (paintbox: TPaintBox;
      var data: TArray<Integer>);
    procedure swap (i, j: Integer; var data: TArray<Integer>);
    procedure QuickSort(var data: TArray<Integer>);
    procedure InsertionSort(var data: TArray<Integer>);
    procedure BubbleSort(var data: TArray<Integer>);
    procedure DrawBoard(paintbox: TPaintBox; const data: TArray<Integer>);
    procedure DrawItem(paintbox: TPaintBox; index, value: integer);
    procedure GenerateData(var data: TArray<Integer>; items: Integer);
    procedure DrawResults (paintbox: TPaintBox; const name: string;
      dataSize: Integer; enlapsed: TTimeSpan; swaps: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.Diagnostics, System.Math, Colors.Hsl;

const
  MaxValue = 100;

procedure TForm1.Button1Click(Sender: TObject);
var
  data: TArray<Integer>;
begin
  PrepareSortDemo (Paintbox1, data);
  BubbleSort (data);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  data: TArray<Integer>;
begin
  PrepareSortDemo (Paintbox2, data);
  QuickSort (data);
end;

var
  SwapPaintBox: TPaintBox;

procedure WaitMilisecond( timeMs: double );
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TForm1.swap (i, j: Integer; var data: TArray<Integer>);
var
  v: Integer;
begin
  v := data[i];
  data[i] := data [j];
  data[j] := v;
  DrawItem (SwapPaintBox, i, data[i]);
  DrawItem (SwapPaintBox, j, data[j]);
  Application.ProcessMessages;
  inc(SwapCounter);
  WaitMilisecond (4.5);
end;

procedure TForm1.BubbleSort (var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data)-1 do
    for j := 0 to Length(data)-2 do
      if data[j] > data [j+1] then begin
        swap( j, j+1, data );
        if not(EnableSorting) then
          break;
      end;
  DrawResults (SwapPaintBox, 'BubleSort', Length(data), sw.Elapsed, SwapCounter );
end;

procedure TForm1.InsertionSort  (var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
  mini: Integer;
  minv: Integer;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data)-1 do begin
    mini := i;  minv := data[i];
    for j := i+1 to Length(data)-1 do begin
      if data[j] < minv then begin
        mini := j;  minv := data[j];
      end;
    end;
    if mini<>i then
      swap( i, mini, data );
    if not(EnableSorting) then
      break;
  end;
  DrawResults (SwapPaintBox, Length(data), sw.Elapsed, SwapCounter );
end;

procedure TForm1.QuickSort (var data: TArray<Integer>);
  procedure qsort (idx1, idx2: integer);
  var
    i: Integer;
    j: Integer;
    mediana: Integer;
  begin
    i:=idx1;
    j:=idx2;
    mediana:=data[(i+j) div 2];
    repeat
      while data[i]<mediana do inc(i);
      while mediana<data[j] do dec(j);
      if i<=j then
      begin
        swap (i,j, data);
        inc(i);
        dec(j);
      end;
    until i>j;
    if EnableSorting then begin
      if idx1<j then qsort(idx1,j);
      if i<idx2 then qsort(i,idx2);
    end;
  end;
var
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  qsort(0, Length(data)-1);
  DrawResults (SwapPaintBox, 'QuickSort', Length(data), sw.Elapsed, SwapCounter);
end;

function GetColor (value: integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value*256/(MaxValue+1));
  col := HSLtoRGB (Hue, 220, 120);
  Result := RGB (col.r, col.g, col.b);
end;

procedure TForm1.DrawItem (paintbox: TPaintBox; index, value: integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := paintbox.Height;
  j := round( value * maxhg / MaxValue);
  c := paintbox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := paintbox.Color;
  c.Rectangle( x, 0, x+5, maxhg-(j)+1 );
  c.Brush.Color := GetColor(value);
  c.Rectangle( x, maxhg-(j), x+5, maxhg );
end;

procedure TForm1.DrawBoard (paintbox: TPaintBox; const data: TArray<Integer>);
var
  i: Integer;
begin
  paintbox.Canvas.Brush.Color := paintbox.Color;
  paintbox.Canvas.FillRect( Rect(0,0,paintbox.Width,paintbox.Height) );
  for i := 0 to Length(data)-1 do
    DrawItem(paintbox, i, data[i]);
end;

procedure TForm1.DrawResults (paintbox: TPaintBox; const name: string;
  dataSize: Integer; enlapsed: TTimeSpan; swaps: Integer);
begin
  paintbox.Canvas.Brush.Style := bsClear;
  paintbox.Canvas.Font.Height := 18;
  paintbox.Canvas.Font.Style := [fsBold];
  paintbox.Canvas.TextOut( 10,5, name );
  paintbox.Canvas.Font.Style := [];
  paintbox.Canvas.TextOut( 10,25, Format('items: %d',[dataSize]) );
  paintbox.Canvas.TextOut( 10,45, Format('time: %.3f',[enlapsed.TotalSeconds]) );
  paintbox.Canvas.TextOut( 10,65, Format('swaps: %d',[swaps]) );
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  EnableSorting := false;
end;

procedure TForm1.GenerateData (var data: TArray<Integer>; items:Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(data, items);
  for i := 0 to Length(data)-1 do
    data[i] := random(MaxValue)+1;
end;

procedure TForm1.PrepareSortDemo(paintbox: TPaintBox;
  var data: TArray<Integer>);
var
  items: Integer;
begin
  items := round (paintbox.Width / 6) -1;
  GenerateData (data, items);
  EnableSorting := true;
  SwapCounter := 0;
  SwapPaintBox := paintbox;
  DrawBoard(paintbox, data);
end;

end.
