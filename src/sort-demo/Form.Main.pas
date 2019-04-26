unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Controler.BubbleSort,
  Controler.QuickSort;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FBubbleSortControler: TBubbleSortControler;
    FQuickSortControler: TQuickSortControler;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  FBubbleSortControler.DoSort;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FQuickSortControler.DoSort;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // EnableSorting := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  FBubbleSortControler := TBubbleSortControler.CreateAndInit(Button1, PaintBox1);
  FQuickSortControler := TQuickSortControler.CreateAndInit(Button2, PaintBox2);
end;

end.
