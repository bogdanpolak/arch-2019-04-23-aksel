unit Frame.First;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFirstFrame = class(TFrame)
    Label1: TLabel;
    tmrReady: TTimer;
    procedure tmrReadyTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

const
  ColorsCount = 10;

var
  RandomColors: array [0 .. ColorsCount - 1] of TColor = (
    $808080,
    $004040,
    $400000,
    $302010,
    $400040,
    $000000,
    $402000,
    $200040,
    $101010,
    $000000
  );

procedure TFirstFrame.tmrReadyTimer(Sender: TObject);
begin
  tmrReady.Enabled := False;
  Label1.Font.Height := 30 + random(25) * 2;
  Label1.Font.Color := RandomColors[random(ColorsCount)];
  Label1.Margins.Top := random(40) * 2;
end;

end.
