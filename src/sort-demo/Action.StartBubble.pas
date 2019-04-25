unit Action.StartBubble;

interface

uses
  Action.Sort;

type
  TStartBubbleAction = class (TSortAction)
  private
  public
    procedure DoWork; override;
  end;

implementation

uses Controler.BubbleSort;

procedure TStartBubbleAction.DoWork;
var
  cBubbleSort: TControlerBubbleSort;
begin
  cBubbleSort := TControlerBubbleSort.CreateAndInit(FPaintBox);
  try
    cBubbleSort.DoSort;
  finally
    cBubbleSort.Free;
  end;
end;

end.
