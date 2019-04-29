{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Controler.Sort;

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
    Button4: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    BubbleSortControler: TSortControler;
    QuickSortControler: TSortControler;
    InsertionSortControler: TSortControler;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Model.Board,
  Manager.Sort;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  BubbleSortControler.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  QuickSortControler.Execute;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  InsertionSortControler.Execute;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  BubbleSortControler.TerminateThread;
  QuickSortControler.TerminateThread;
  QuickSortControler.TerminateThread;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not(BubbleSortControler.IsBusy) and
    not(QuickSortControler.IsBusy) and
    not(InsertionSortControler.IsBusy);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BubbleSortControler := TSortManager.CreateAndInit(Button1, saBubbleSort,
    PaintBox1).Controler;
  QuickSortControler := TSortManager.CreateAndInit(Button2, saQuickSort,
    PaintBox2).Controler;
  InsertionSortControler := TSortManager.CreateAndInit(Button3, saInsertionSort,
    PaintBox3).Controler;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  m: TBoardMessage;
begin
  while FMessageQueue.QueueSize > 0 do
  begin
    m := FMessageQueue.PopItem;
    BubbleSortControler.DispatchBoardMessage(m);
    QuickSortControler.DispatchBoardMessage(m);
    InsertionSortControler.DispatchBoardMessage(m);
  end;
end;

end.
