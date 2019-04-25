unit View.SortResults;

interface

uses
  Vcl.ExtCtrls, System.TimeSpan, Model.SortResults;

type
  TSortResultsView = class
  public
    procedure DrawResults(APaintbox: TPaintBox; AValue: TSortResults);
  end;

implementation

uses
  Vcl.Graphics, System.SysUtils;

procedure TSortResultsView.DrawResults(APaintbox: TPaintBox;
  AValue: TSortResults);
begin
  APaintbox.Canvas.Brush.Style := bsClear;
  APaintbox.Canvas.Font.Height := 18;
  APaintbox.Canvas.Font.Style := [fsBold];
  APaintbox.Canvas.TextOut(10, 5, AValue.Name);
  APaintbox.Canvas.Font.Style := [];
  APaintbox.Canvas.TextOut(10, 25, Format('items: %d', [AValue.DataSize]));
  APaintbox.Canvas.TextOut(10, 45, Format('time: %.3f',
    [AValue.Enlapsed.TotalSeconds]));
  APaintbox.Canvas.TextOut(10, 65, Format('swaps: %d', [AValue.SwapCounter]));
end;

end.
