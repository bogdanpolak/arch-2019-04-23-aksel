program SortDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Colors.Hsl in 'Colors.Hsl.pas',
  Controler.Sort in 'Controler.Sort.pas',
  Manager.Sort in 'Manager.Sort.pas',
  Model.Board in 'Model.Board.pas',
  Thread.Sort in 'Thread.Sort.pas',
  View.Board in 'View.Board.pas',
  View.Vcl.Board in 'View.Vcl.Board.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
