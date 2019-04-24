unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls,
  Plus.Vcl.PageControlFactory;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    PageControl1: TPageControl;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
  public
    PageControlFactory: TPageControlFactory;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Frame.First, Frame.Second;


procedure TForm1.Button1Click(Sender: TObject);
begin
  PageControlFactory.AddNewFrame<TFirstFrame>('First Frame');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  PageControlFactory.AddNewFrame<TSecondFrame>('Second Frame with Matrix');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if PageControl1.ActivePage<>nil then
    PageControl1.ActivePage.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControlFactory := TPageControlFactory.Create(Self);
  PageControlFactory.PageControl := PageControl1;
  Randomize;
end;

end.
