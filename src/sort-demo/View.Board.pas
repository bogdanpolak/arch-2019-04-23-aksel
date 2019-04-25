unit View.Board;

interface

uses
  Vcl.ExtCtrls;

type
  TBoardView = class
  private
    FMaxValue: UInt8;
  public
    procedure DrawBoard(paintbox: TPaintBox; const data: TArray<Integer>);
    procedure DrawItem(paintbox: TPaintBox; index, value: Integer);

    property MaxValue: UInt8 read FMaxValue write FMaxValue;
  end;

implementation

uses
  Vcl.Graphics, Colors.Hsl, Winapi.Windows, System.Classes;


function GetColor(value: Integer; MaxValue: UInt8): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value * 256 / (MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;
procedure TBoardView.DrawItem(paintbox: TPaintBox; index, value: Integer);
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
  c.Brush.Color := GetColor(value, MaxValue);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

procedure TBoardView.DrawBoard(paintbox: TPaintBox; const data: TArray<Integer>);
var
  i: Integer;
begin
  paintbox.Canvas.Brush.Color := paintbox.Color;
  paintbox.Canvas.FillRect(Rect(0, 0, paintbox.Width, paintbox.Height));
  for i := 0 to Length(data) - 1 do
    DrawItem(paintbox, i, data[i]);
end;
end.
