unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls,
  Action.Sort;

type
  TStartBubbleAction = class (TSortAction)
  private
  public
    procedure DoWork; override;
  end;

implementation

uses Form.Main, Controler.BubbleSort;

procedure TStartBubbleAction.DoWork;
var
  cBubbleSort: TControlerBubbleSort;
begin
  cBubbleSort := TControlerBubbleSort.CreateAndInit(Form1.PaintBox1);
  try
    cBubbleSort.DoSort;
  finally
    cBubbleSort.Free;
  end;
end;

end.
