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
  cBubbleSort := TControlerBubbleSort.CreateAndInit(Owner, FPaintBox);
  cBubbleSort.DoSort;
end;

end.
