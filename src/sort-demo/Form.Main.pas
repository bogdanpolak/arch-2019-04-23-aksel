{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Dialogs, Vcl.ActnList,
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
    ActionList1: TActionList;
    actStartBubbleSort: TAction;
    actStartQuickSort: TAction;
    actStartInsertionSort: TAction;
    actTermianteAll: TAction;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure actTermianteAllExecute(Sender: TObject);
    procedure actStartBubbleSortExecute(Sender: TObject);
    procedure actStartQuickSortExecute(Sender: TObject);
    procedure actStartInsertionSortExecute(Sender: TObject);
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

procedure TForm1.actStartBubbleSortExecute(Sender: TObject);
begin
  BubbleSortControler.Execute;
end;

procedure TForm1.actStartInsertionSortExecute(Sender: TObject);
begin
  InsertionSortControler.Execute;
end;

procedure TForm1.actStartQuickSortExecute(Sender: TObject);
begin
  QuickSortControler.Execute;
end;

procedure TForm1.actTermianteAllExecute(Sender: TObject);
begin
  BubbleSortControler.TerminateThread;
  QuickSortControler.TerminateThread;
  InsertionSortControler.TerminateThread;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not(actTermianteAll.Enabled);
  if not(CanClose) then
    ShowMessage ('Proszę  najpierw zakończyć sortowanie');
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
  isBusyBubble: Boolean;
  isBusyQuick: Boolean;
  isBusyInsertion: Boolean;
begin
  while FMessageQueue.QueueSize > 0 do
  begin
    m := FMessageQueue.PopItem;
    BubbleSortControler.DispatchBoardMessage(m);
    QuickSortControler.DispatchBoardMessage(m);
    InsertionSortControler.DispatchBoardMessage(m);
  end;
  isBusyBubble := BubbleSortControler.IsBusy;
  isBusyQuick := QuickSortControler.IsBusy;
  isBusyInsertion := InsertionSortControler.IsBusy;
  //
  actStartBubbleSort.Enabled := not(isBusyBubble);
  actStartQuickSort.Enabled := not(isBusyQuick);
  actStartInsertionSort.Enabled := not(isBusyInsertion);
  actTermianteAll.Enabled := isBusyBubble or isBusyQuick or isBusyInsertion;
end;

end.
