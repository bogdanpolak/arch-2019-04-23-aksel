unit View.SortResults;

interface

uses
  Vcl.ExtCtrls, System.TimeSpan, Model.SortResults;

type
  TSortResultsView = class
  public
    procedure DrawResults(paintbox: TPaintBox; AValue: TSortResults);
  end;

implementation

uses
  Vcl.Graphics, System.SysUtils;

procedure TSortResultsView.DrawResults(paintbox: TPaintBox; AValue: TSortResults);
begin
  paintbox.Canvas.Brush.Style := bsClear;
  paintbox.Canvas.Font.Height := 18;
  paintbox.Canvas.Font.Style := [fsBold];
  paintbox.Canvas.TextOut(10, 5, AValue.Name);
  paintbox.Canvas.Font.Style := [];
  paintbox.Canvas.TextOut(10, 25, Format('items: %d', [AValue.DataSize]));
  paintbox.Canvas.TextOut(10, 45, Format('time: %.3f',
    [AValue.Enlapsed.TotalSeconds]));
  paintbox.Canvas.TextOut(10, 65, Format('swaps: %d', [AValue.SwapCounter]));
end;

end.
