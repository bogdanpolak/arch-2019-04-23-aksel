program SortDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Colors.Hsl in 'Colors.Hsl.pas',
  Model.Board in 'Model.Board.pas',
  View.Board in 'View.Board.pas',
  Controler.Sort in 'Controler.Sort.pas',
  Thread.SortControler in 'Thread.SortControler.pas',
  View.Vcl.Board in 'View.Vcl.Board.pas',
  Manager.Sort in 'Manager.Sort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
