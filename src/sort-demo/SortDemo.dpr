program SortDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Colors.Hsl in 'Colors.Hsl.pas',
  Model.Board in 'Model.Board.pas',
  Model.SortResults in 'Model.SortResults.pas',
  View.Board in 'View.Board.pas',
  View.SortResults in 'View.SortResults.pas',
  Action.StartBubble in 'Action.StartBubble.pas',
  Action.StartQuick in 'Action.StartQuick.pas',
  Action.StartInsertion in 'Action.StartInsertion.pas',
  Action.Sort in 'Action.Sort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
