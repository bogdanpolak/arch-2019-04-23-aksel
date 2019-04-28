{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit View.Vcl.Board;

interface

uses
  System.UITypes, System.TimeSpan,
  Vcl.ExtCtrls,
  Model.Board,
  View.Board;

type
  TVclBoardView = class(TInterfacedObject, IBoardView)
  private
    FPaintBox: TPaintBox;
    FBoard: TBoard;
    function GetColor(value: Integer): TColor;
  public
    constructor CreateAndInit(APaintBox: TPaintBox; ABoard: TBoard);
    procedure DrawBoard;
    procedure DrawItem(AIndex: Integer);
    procedure DrawResults (const AAlgorithmName: string;
      AElapsedTime: TTimeSpan);
    function CountVisibleItems: Integer;
  end;

implementation

uses
  Winapi.Windows,
  System.Classes, System.SysUtils,
  Vcl.Graphics,
  Colors.Hsl;

constructor TVclBoardView.CreateAndInit(APaintBox: TPaintBox; ABoard: TBoard);
begin
  inherited Create;
  FPaintBox := APaintBox;
  FBoard := ABoard;
end;

procedure TVclBoardView.DrawBoard;
var
  i: Integer;
begin
  FPaintBox.Canvas.Brush.Color := FPaintBox.Color;
  FPaintBox.Canvas.FillRect(Rect(0, 0, FPaintBox.Width, FPaintBox.Height));
  for i := 0 to FBoard.Count - 1 do
    DrawItem(i);
end;

function TVclBoardView.CountVisibleItems: Integer;
begin
  Result := round(FPaintBox.Width / 6) - 1;
end;

procedure TVclBoardView.DrawItem(AIndex: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := FPaintBox.Height;
  j := round(FBoard.Data[AIndex] * maxhg / TBoard.MaxValue);
  c := FPaintBox.Canvas;
  x := AIndex * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := FPaintBox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(FBoard.Data[AIndex]);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

procedure TVclBoardView.DrawResults (const AAlgorithmName: string;
  AElapsedTime: TTimeSpan);
begin
  FPaintbox.Canvas.Brush.Style := bsClear;
  FPaintbox.Canvas.Font.Height := 18;
  FPaintbox.Canvas.Font.Style := [fsBold];
  FPaintbox.Canvas.TextOut(10, 5, AAlgorithmName);
  FPaintbox.Canvas.Font.Style := [];
  FPaintbox.Canvas.TextOut(10, 25, Format('items: %d',
    [FBoard.Count]));
  FPaintbox.Canvas.TextOut(10, 45, Format('time: %.3f',
    [AElapsedTime.TotalSeconds]));
  FPaintbox.Canvas.TextOut(10, 65, Format('swaps: %d',
    [FBoard.FSwapCounter]));
end;


function TVclBoardView.GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := Round(value * 256 / (TBoard.MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

end.
