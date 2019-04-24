unit Action.StartQuick;

interface

uses
  Vcl.ActnList;

type
  TStartQuickAction = class (TAction)
  public
    function Execute: boolean; override;
  end;

implementation

{ TStartBubbleAction }

function TStartQuickAction.Execute: boolean;
begin

end;

end.
