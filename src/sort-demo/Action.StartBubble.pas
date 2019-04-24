unit Action.StartBubble;

interface

uses
  Vcl.ActnList, Vcl.StdCtrls;

type
  TStartBubbleAction = class (TAction)
  public
    function Execute: boolean; override;
  end;

implementation

{ TStartBubbleAction }

uses Form.Main;

{ TStartBubbleAction }

function TStartBubbleAction.Execute: boolean;
var
  data: TArray<Integer>;
begin
  Form1.PrepareSortDemo(Form1.PaintBox1, data);
  Form1.BubbleSort(data);
end;

end.
