unit Form.Form2;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Plus.Vcl.Form;

type
  TForm2 = class(TFormPlus)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    FText: string;
    procedure FormReady; override;
    procedure FormIdle; override;
  public
    constructor Create (Owner: TComponent); override;
  end;


implementation

{$R *.dfm}


constructor TForm2.Create(Owner: TComponent);
begin
  inherited;
  FText := 'constructor Create';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ListBox1.Clear;
  ListBox1.Items.Add(FText);
  ListBox1.Items.Add('FormCreate');
end;

procedure TForm2.FormIdle;
begin
  ListBox2.Tag := ListBox2.Tag + 1;
  ListBox2.Items.Text := ListBox2.Tag.ToString;
end;

{ TForm2 }

procedure TForm2.FormReady;
begin
  ListBox1.Items.Add('FormReady');
end;

end.
