unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Controler.Sort,
  View.Board,
  View.SortResults,
  Model.Board,
  Model.SortResults;

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
  private
    SortControler1: TSortControler;
    SortControler2: TSortControler;
    SortControler3: TSortControler;
    // ------
    BoardView1: IBoardView;
    BoardView2: IBoardView;
    SortResultView1: ISortResultsView;
    SortResultView2: ISortResultsView;
    // ------
    Board1: TBoard;
    SortResult1: TSortResults;
    Board2: TBoard;
    SortResult2: TSortResults;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses View.Vcl.SortResults, View.Vcl.Board;


procedure TForm1.Button1Click(Sender: TObject);
begin
  BoardView1.DrawBoard;
  SortControler1.DoSort (saBubbleSort);
  Timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  BoardView2.DrawBoard;
  SortControler2.DoSort (saQuickSort);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // EnableSorting := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Board1 := TBoard.Create;
  SortResult1 := TSortResults.Create;
  BoardView1 := TBoardView.CreateAndInit(PaintBox1, Board1);
  Board1.GenerateData( BoardView1.CountVisibleItems );
  SortResult1.Name := 'BubbleSort';
  SortResultView1 := TSortResultsView.CreateAndInit(PaintBox1, SortResult1);
  BoardView1.DrawBoard;
  SortControler1 := TSortControler.Create ( Board1,
    SortResult1, BoardView1, SortResultView1 );
  // -------
  Board2 := TBoard.Create;
  SortResult2 := TSortResults.Create;
  BoardView2 := TBoardView.CreateAndInit(PaintBox2, Board2);
  Board2.GenerateData( BoardView2.CountVisibleItems );
  SortResult2.Name := 'Quick Sort';
  SortResultView2 := TSortResultsView.CreateAndInit(PaintBox2, SortResult2);
  BoardView2.DrawBoard;
  SortControler2 := TSortControler.Create ( Board2,
    SortResult2, BoardView2, SortResultView2 );
  // TODO: Brakuje zwalniania pamiêci: Board, SortResult, FBubbleSortControler
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  msg1: TSortMessage;
  BoardView: IBoardView;
  SortResultView: ISortResultsView;
begin
  while FMessageQueue.QueueSize>0 do begin
    msg1 := FMessageQueue.PopItem;
    if msg1.Board = Board1 then begin
      BoardView := BoardView1;
      SortResultView := SortResultView1;
    end
    else if msg1.Board = Board2 then
    begin
      BoardView := BoardView2;
      SortResultView := SortResultView2;
    end;
    (*
    else
      BoardView := BoardView3;
      SortResultView := SortResultView3;
    *)
    case msg1.MessageType of
      mtSwap: begin
        BoardView.DrawItem(msg1.SwapIndex1);
        BoardView.DrawItem(msg1.SwapIndex2);
      end;
      mtDone: begin
        SortResultView.DrawResults;
      end;

    end;
  end;
  (*
  FSwapCounter := 0;
  *)
end;

end.
