unit Action.Sort;

interface

uses
  System.Classes, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSortAction = class (TAction)
  protected
    FPaintBox: TPaintBox;
    procedure OnActionExecute(Sender: TObject);
  public
    constructor CreateAndInit(Button: TButton; APaintBox: TPaintBox; const Caption: String);
    procedure DoWork; virtual; abstract;
  end;

implementation

constructor TSortAction.CreateAndInit(Button: TButton; APaintBox: TPaintBox; const Caption: String);
begin
  inherited Create(Button);
  Self.Caption := Caption;
  Button.Action := Self;
  Self.OnExecute := OnActionExecute;
  FPaintBox := APaintBox;
end;

procedure TSortAction.OnActionExecute (Sender: TObject);
begin
  DoWork;
end;

end.
