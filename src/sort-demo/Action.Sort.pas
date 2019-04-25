unit Action.Sort;

interface

uses
  System.Classes, Vcl.ActnList, Vcl.StdCtrls;

type
  TSortAction = class(TAction)
  protected
    procedure OnActionExecute(ASender: TObject);
  public
    constructor CreateAndInit(AButton: TButton; const ACaption: String);
    procedure DoWork; virtual; abstract;
  end;

implementation

{ TStartBubbleAction }

constructor TSortAction.CreateAndInit(AButton: TButton; const ACaption: String);
begin
  inherited Create(AButton);
  Self.Caption := ACaption;
  AButton.Action := Self;
  Self.OnExecute := OnActionExecute
end;

procedure TSortAction.OnActionExecute(ASender: TObject);
begin
  DoWork;
end;

end.
