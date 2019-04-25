unit Action.Sort;

interface

uses
  System.Classes, Vcl.ActnList, Vcl.StdCtrls, Controller.Board, View.Board, Model.Board,
  Vcl.ExtCtrls;

type
  TSortAction = class (TAction)
  protected
    FController: TBoardController;
    procedure OnActionExecute(Sender: TObject);
  public
    constructor CreateAndInit (Button:TButton; PaintBox: TPaintBox; const Caption: String);
    procedure DoWork; virtual; abstract;
  end;

implementation

{ TStartBubbleAction }

constructor TSortAction.CreateAndInit(Button:TButton; PaintBox: TPaintBox; const Caption: String);
begin
  inherited Create(Button);
  Self.Caption := Caption;
  Button.Action := Self;
  Self.OnExecute := OnActionExecute;
  FController := TBoardController.CreateAndInit(Self, TBoard.Create, TBoardView.CreateAndInit(PaintBox));
end;

procedure TSortAction.OnActionExecute (Sender: TObject);
begin
  DoWork;
end;

end.
