unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    Action1: TAction;
    ApplicationEvents1: TApplicationEvents;
    Action2: TAction;
    actClearMemo: TAction;
    actMaximize: TAction;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    chkBindAction1ToButton1: TCheckBox;
    chkBindAction2ToButton2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Splitter1: TSplitter;
    actQuitApp: TAction;
    Timer1: TTimer;
    chkTimer1Enable: TCheckBox;
    actCallApplicaionIdle: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure actClearMemoExecute(Sender: TObject);
    procedure actMaximizeExecute(Sender: TObject);
    procedure actQuitAppExecute(Sender: TObject);
    procedure actCallApplicaionIdleExecute(Sender: TObject);
    procedure ApplicationEvents1ActionExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure ApplicationEvents1ActionUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure chkBindAction1ToButton1Click(Sender: TObject);
    procedure chkBindAction2ToButton2Click(Sender: TObject);
    procedure chkTimer1EnableClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure LogInfo(AText: string);
    procedure LogWelcome;
    { Private declarations }
  const
    DoNotReportSpeed = True;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  LogWelcome;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  speed: String;
begin
  LogInfo('Aplication.OnIdle');
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  LogInfo('*** Action1 Execute');
end;

procedure TForm1.Action2Execute(Sender: TObject);
begin
  LogInfo('**** Action2 Execute');
end;

procedure TForm1.actClearMemoExecute(Sender: TObject);
begin
  Memo1.Clear;
  LogInfo('Action3.Execute - Memo1.Clear');
  LogWelcome;
end;

procedure TForm1.actMaximizeExecute(Sender: TObject);
begin
  LogInfo('Action4.Execute - Maximize');
  Top := 0;
  Height := Screen.DesktopHeight - 40;
end;

procedure TForm1.actQuitAppExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actCallApplicaionIdleExecute(Sender: TObject);
begin
  Application.DoApplicationIdle;
end;

procedure TForm1.ApplicationEvents1ActionExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  LogInfo('Aplication.ActionExecute (' + Action.Name + ')');
end;

procedure TForm1.ApplicationEvents1ActionUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  LogInfo('Aplication.ActionUpdate (' + Action.Name + ')');
end;

procedure TForm1.chkBindAction1ToButton1Click(Sender: TObject);
begin
  Button1.Action := Action1;
end;

procedure TForm1.chkBindAction2ToButton2Click(Sender: TObject);
begin
  Button2.Action := Action2;
end;

procedure TForm1.chkTimer1EnableClick(Sender: TObject);
begin
  Timer1.Enabled := chkTimer1Enable.Checked;
end;

procedure TForm1.LogInfo(AText: string);
begin
  Memo1.Lines.Add(FormatDateTime('(hh:mm:ss)  ', Now) + AText);
end;

procedure TForm1.LogWelcome;
begin
  Memo1.Lines.Add('-----------------------------------------------------');
  Memo1.Lines.Add(' * Ctrl+C - Clear Memo');
  Memo1.Lines.Add(' * Ctrl+M - Maximize form');
  Memo1.Lines.Add(' * Ctrl+I - Application.DOApplicationIdle');
  Memo1.Lines.Add(' * Ctrl+Q - Quit application (Atl+F4)');
  Memo1.Lines.Add('-----------------------------------------------------');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  // x
end;

end.
