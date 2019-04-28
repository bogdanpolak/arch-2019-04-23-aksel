unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Manager.Sort;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    PaintBox3: TPaintBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    BubbleSortManager: TSortManager;
    QuickSortManager: TSortManager;
    InsertionSortManager: TSortManager;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Model.Board,
  Controler.Sort;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  BubbleSortManager.Execute;
  Timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  QuickSortManager.Execute;
  Timer1.Enabled := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  InsertionSortManager.Execute;
  Timer1.Enabled := True;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // EnableSorting := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BubbleSortManager := TSortManager.CreateAndInit(Button1, saBubbleSort,
    PaintBox1);
  QuickSortManager := TSortManager.CreateAndInit(Button2, saQuickSort,
    PaintBox2);
  InsertionSortManager := TSortManager.CreateAndInit(Button3, saInsertionSort,
    PaintBox3);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  m: TSortMessage;
begin
  while FMessageQueue.QueueSize > 0 do
  begin
    m := FMessageQueue.PopItem;
    BubbleSortManager.DispatchSortMessage(m);
    QuickSortManager.DispatchSortMessage(m);
    InsertionSortManager.DispatchSortMessage(m);
  end;
end;

end.
