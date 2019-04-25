unit View.Board;

interface

uses
  Vcl.ExtCtrls, Vcl.Graphics,
  Colors.Hsl, Winapi.Windows, System.TimeSpan;

type
  TBoardView = class
  private
    FPaintBox: TPaintBox;
    FMaxValue: Integer;
    function GetItemsCount: Integer;
    procedure DrawItem(index, value: Integer);
    function GetColor(value: Integer): TColor;
  public
    constructor CreateAndInit(APaintBox: TPaintBox);
    procedure Swap(i,j: Integer; var data: TArray<Integer>);
    procedure DrawBoard(const data: TArray<Integer>);
    procedure DrawResults(const name: string; dataSize: Integer;
      enlapsed: TTimeSpan; swaps: Integer);
    property ItemsCount: Integer read GetItemsCount;
    property MaxValue: Integer write FMaxValue;
  end;

implementation

uses
  System.Classes, System.SysUtils;

{ TBoardView }

constructor TBoardView.CreateAndInit(APaintBox: TPaintBox);
begin
  FPaintBox := APaintBox;
end;

function TBoardView.GetItemsCount: Integer;
begin
  Result := round(FPaintBox.Width / 6) - 1;
end;

function TBoardView.GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value * 256 / (FMaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

procedure TBoardView.DrawBoard(const data: TArray<Integer>);
var
  i: Integer;
begin
  FPaintbox.Canvas.Brush.Color := FPaintbox.Color;
  FPaintbox.Canvas.FillRect(Rect(0, 0, FPaintbox.Width, FPaintbox.Height));
  for i := 0 to Length(data) - 1 do
    DrawItem(i, data[i]);
end;

procedure TBoardView.DrawItem(index, value: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := FPaintBox.Height;
  j := round(value * maxhg / FMaxValue);
  c := FPaintBox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := FPaintBox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(value);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

procedure TBoardView.DrawResults(const name: string; dataSize: Integer;
  enlapsed: TTimeSpan; swaps: Integer);
begin
  FPaintBox.Canvas.Brush.Style := bsClear;
  FPaintBox.Canvas.Font.Height := 18;
  FPaintBox.Canvas.Font.Style := [fsBold];
  FPaintBox.Canvas.TextOut(10, 5, name);
  FPaintBox.Canvas.Font.Style := [];
  FPaintBox.Canvas.TextOut(10, 25, Format('items: %d', [dataSize]));
  FPaintBox.Canvas.TextOut(10, 45, Format('time: %.3f',
    [enlapsed.TotalSeconds]));
  FPaintBox.Canvas.TextOut(10, 65, Format('swaps: %d', [swaps]));
end;

procedure TBoardView.Swap(i, j: Integer; var data: TArray<Integer>);
begin
  DrawItem(i, data[i]);
  DrawItem(j, data[j]);
end;

end.
