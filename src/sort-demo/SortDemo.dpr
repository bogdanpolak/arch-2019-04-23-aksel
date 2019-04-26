program SortDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Colors.Hsl in 'Colors.Hsl.pas',
  Model.Board in 'Model.Board.pas',
  Model.SortResults in 'Model.SortResults.pas',
  View.Board in 'View.Board.pas',
  View.SortResults in 'View.SortResults.pas',
  Controler.Sort in 'Controler.Sort.pas',
  Thread.SortControler in 'Thread.SortControler.pas',
  View.Vcl.Board in 'View.Vcl.Board.pas',
  View.Vcl.SortResults in 'View.Vcl.SortResults.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
