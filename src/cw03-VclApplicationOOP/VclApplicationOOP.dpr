program VclApplicationOOP;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {FormMain},
  Plus.Vcl.Form in 'Plus.Vcl.Form.pas',
  Plus.Vcl.Timer in 'Plus.Vcl.Timer.pas',
  Form.Form2 in 'Form.Form2.pas' {Form2},
  Plus.System.AnonymousEvent in 'Plus.System.AnonymousEvent.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
