unit View.SortResults;

interface

uses
  Model.SortResults, Vcl.ExtCtrls;

type
  ISortResultsView = interface
    ['{D4CDDABA-6CAB-4C85-A3C6-B6694F0785B3}']
  end;

  TSortResultsView = class(TInterfacedObject, ISortResultsView)
  private
    FPaintbox: TPaintBox;
    FSortResult: TSortResults;
  public
    constructor CreateAndInit(APaintbox: TPaintBox; ASortResult: TSortResults);
    procedure DrawResults;
  end;

implementation

uses
  Vcl.Graphics, System.SysUtils;


constructor TSortResultsView.CreateAndInit(APaintbox: TPaintBox;
  ASortResult: TSortResults);
begin
  inherited Create;
  FPaintbox := APaintbox;
  FSortResult := ASortResult;
end;

procedure TSortResultsView.DrawResults;
begin
  FPaintbox.Canvas.Brush.Style := bsClear;
  FPaintbox.Canvas.Font.Height := 18;
  FPaintbox.Canvas.Font.Style := [fsBold];
  FPaintbox.Canvas.TextOut(10, 5, FSortResult.Name);
  FPaintbox.Canvas.Font.Style := [];
  FPaintbox.Canvas.TextOut(10, 25, Format('items: %d', [FSortResult.DataSize]));
  FPaintbox.Canvas.TextOut(10, 45, Format('time: %.3f',
    [FSortResult.ElapsedTime.TotalSeconds]));
  FPaintbox.Canvas.TextOut(10, 65, Format('swaps: %d', [FSortResult.SwapCounter]));
end;

end.
