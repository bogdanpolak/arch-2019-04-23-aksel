unit Plus.Vcl.Form;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.AppEvnts,
  Vcl.Forms;

type
  TFormPlus = class(TForm)
  private
    FFirstTime: boolean;
    FApplicationEvents: Vcl.AppEvnts.TApplicationEvents;
    procedure OnApplicationIdle(Sender: TObject; var Done: Boolean);
  protected
    procedure FormReady; virtual; abstract;
    procedure FormIdle; virtual; abstract;
  public
    constructor Create (Owner: TComponent); override;
  end;

implementation

{ TFormWithReadyEvent }

constructor TFormPlus.Create(Owner: TComponent);
begin
  inherited;
  FFirstTime := True;
  FApplicationEvents := TApplicationEvents.Create(Self);
  FApplicationEvents.OnIdle := OnApplicationIdle;
end;

procedure TFormPlus.OnApplicationIdle(Sender: TObject; var Done: Boolean);
begin
  try
    if FFirstTime then
      FormReady;
    FormIdle();
  finally
    FFirstTime := False;
    Done := True;
  end;
end;

end.
