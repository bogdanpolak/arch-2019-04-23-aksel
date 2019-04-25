unit View.Board;

interface

uses
  Vcl.ExtCtrls;

type
  TBoardView = class
  private
    FMaxValue: UInt8;
  public
    procedure DrawBoard(APaintbox: TPaintBox; const AData: TArray<Integer>);
    procedure DrawItem(APaintbox: TPaintBox; AIndex, AValue: Integer);

    property MaxValue: UInt8 read FMaxValue write FMaxValue;
  end;

implementation

uses
  Vcl.Graphics, Colors.Hsl, Winapi.Windows, System.Classes;

function GetColor(AValue: Integer; AMaxValue: UInt8): TColor;
var
  hue: Integer;
  col: TRgbColor;
begin
  hue := round(AValue * 256 / (AMaxValue + 1));
  col := HSLtoRGB(hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

procedure TBoardView.DrawItem(APaintbox: TPaintBox; AIndex, AValue: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := APaintbox.Height;
  j := round(AValue * maxhg / MaxValue);
  c := APaintbox.Canvas;
  x := AIndex * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := APaintbox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(AValue, MaxValue);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

procedure TBoardView.DrawBoard(APaintbox: TPaintBox;
  const AData: TArray<Integer>);
var
  idx: Integer;
begin
  APaintbox.Canvas.Brush.Color := APaintbox.Color;
  APaintbox.Canvas.FillRect(Rect(0, 0, APaintbox.Width, APaintbox.Height));
  for idx := 0 to Length(AData) - 1 do
    DrawItem(APaintbox, idx, AData[idx]);
end;

end.
