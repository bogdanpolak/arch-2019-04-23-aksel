unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Bevel1: TBevel;
    GroupBox2: TGroupBox;
    Button1: TButton;
    btnShowForm2: TButton;
    GroupBox3: TGroupBox;
    procedure btnShowForm2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function AddLabel(aParent: TGroupBox; aCaption: string): TLabel;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  Plus.Vcl.Timer,
  Plus.System.AnonymousEvent,
  Form.Form2;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Edit1.Text := '';
  TEventOnFirstShow.Setup(Self,
    procedure()
    begin
      btnShowForm2.SetFocus;
      AddLabel(GroupBox1, 'Done: On first show event.');
      TEvenOnTimer.SetupOnce(Self, 1000,
        procedure()
        var
          lblTimer: TLabel;
        begin
          AddLabel(GroupBox1, 'Done: Timer tick once (Interval = 10000 ms)');
          lblTimer := AddLabel(GroupBox1, '');
          TEvenOnTimer.SetupRepeat(Self, 1000,
            procedure
            begin
              lblTimer.Tag := lblTimer.Tag + 1;
              lblTimer.Caption := Format('Timer counter: %d', [lblTimer.Tag]);
            end);
        end);
    end);
  Button1.OnClick := AnonymousMethodToTNotifyEvent(Button1,
    procedure(Sender: TObject)
    begin
      (Sender as TButton).Caption := 'Clicked !';
      Self.Caption := 'Changed form caption';
    end);
end;

function TFormMain.AddLabel(aParent: TGroupBox; aCaption: string): TLabel;
begin
  Result := TLabel.Create(aParent);
  Result.Caption := aCaption;
  Result.Parent := aParent;
  Result.Top := 2000;
  Result.AlignWithMargins := True;
  Result.Align := alTop;
end;

procedure TFormMain.btnShowForm2Click(Sender: TObject);
begin
  with TForm2.Create(Application) do begin
    Left := Self.Left + Self.Width + 1;
    Top := Self.Top;
    Show;
  end;
end;

end.
