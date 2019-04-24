unit Action.StartInsertion;

interface

uses
  Vcl.ActnList;

type
  TStartInsertionAction = class (TAction)
  public
    function Execute: boolean; override;
  end;

implementation

{ TStartInsertionAction }

function TStartInsertionAction.Execute: boolean;
begin

end;

end.
