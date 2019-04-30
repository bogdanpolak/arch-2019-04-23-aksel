{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  * Console Runner:
  *   * Add "CONSOLE_TESTRUNNER" to Project -> Options -> Delphi Compiler -> Conditional defines
  *   * http://docwiki.embarcadero.com/RADStudio/Rio/en/Delphi_Compiler
  *  ----------------------------------------------------------------------- * }
program SortDemoTests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Model.Board in '..\..\src\sort-demo\Model.Board.pas',
  Controler.Sort in '..\..\src\sort-demo\Controler.Sort.pas',
  Thread.Sort in '..\..\src\sort-demo\Thread.Sort.pas',
  View.Board in '..\..\src\sort-demo\View.Board.pas',
  TestBoard in 'TestBoard.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

