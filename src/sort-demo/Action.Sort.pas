unit Action.Sort;

interface

uses
  System.Classes, Vcl.ActnList, Vcl.StdCtrls;

type
  TSortAction = class (TAction)
  protected
    procedure OnActionExecute(Sender: TObject);
  public
    constructor CreateAndInit (Button:TButton; const Caption: String); virtual;
    procedure DoWork; virtual; abstract;
  end;

implementation

{ TStartBubbleAction }

constructor TSortAction.CreateAndInit(Button:TButton; const Caption: String);
begin
  inherited Create(Button);
  Self.Caption := Caption;
  Button.Action := Self;
  Self.OnExecute := OnActionExecute
end;

procedure TSortAction.OnActionExecute (Sender: TObject);
begin
  DoWork;
end;

end.
