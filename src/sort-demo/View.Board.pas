unit View.Board;

interface

uses
  Model.Board, Vcl.ExtCtrls, System.UITypes;

type
  IBoardView = interface
    ['{8734291B-DA8D-4569-8AEC-A9741DE778B7}']
    procedure DrawBoard;
    procedure DrawItem(AIndex: Integer);
    function CountVisibleItems: Integer;
  end;

  TBoardView = class(TInterfacedObject, IBoardView)
  private
    FPaintBox: TPaintBox;
    FBoard: TBoard;
    function GetColor(value: Integer): TColor;
  public
    constructor CreateAndInit(APaintBox: TPaintBox; ABoard: TBoard);
    procedure DrawBoard;
    procedure DrawItem(AIndex: Integer);
    function CountVisibleItems: Integer;
  end;

implementation

uses
  Vcl.Graphics, Colors.Hsl, Winapi.Windows, System.Classes;

{ TBoardView }


{ TBoardView }

constructor TBoardView.CreateAndInit(APaintBox: TPaintBox; ABoard: TBoard);
begin
  inherited Create;
  FPaintBox := APaintBox;
  FBoard := ABoard;
end;

procedure TBoardView.DrawBoard;
var
  i: Integer;
begin
  FPaintBox.Canvas.Brush.Color := FPaintBox.Color;
  FPaintBox.Canvas.FillRect(Rect(0, 0, FPaintBox.Width, FPaintBox.Height));
  for i := 0 to FBoard.Count - 1 do
    DrawItem(i);
end;

function TBoardView.CountVisibleItems: Integer;
begin
  Result := round(FPaintBox.Width / 6) - 1;
end;

procedure TBoardView.DrawItem(AIndex: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := FPaintBox.Height;
  j := round(FBoard.Data[AIndex] * maxhg / MaxValue);
  c := FPaintBox.Canvas;
  x := AIndex * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := FPaintBox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(FBoard.Data[AIndex]);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

function TBoardView.GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := Round(value * 256 / (MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

end.
