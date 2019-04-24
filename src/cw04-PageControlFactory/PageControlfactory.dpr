program PageControlfactory;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Plus.Vcl.PageControlFactory in 'Plus.Vcl.PageControlFactory.pas',
  Frame.First in 'Frame.First.pas' {FirstFrame: TFrame},
  Frame.Second in 'Frame.Second.pas' {SecondFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
