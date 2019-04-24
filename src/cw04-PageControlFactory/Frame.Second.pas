unit Frame.Second;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls;

type
  TSecondFrame = class(TFrame)
    StringGrid1: TStringGrid;
    tmrReady: TTimer;
    procedure tmrReadyTimer(Sender: TObject);
  private
    procedure SetupGrid(aStringGrid: TStringGrid);
  public
  end;

implementation

{$R *.dfm}

procedure TSecondFrame.tmrReadyTimer(Sender: TObject);
begin
  tmrReady.Enabled := False;
  SetupGrid(StringGrid1);
end;

procedure TSecondFrame.SetupGrid(aStringGrid: TStringGrid);
var
  RowStartValue: Integer;
  ColStartValue: Integer;
  GridMaxRows: Integer;
  GridMaxCols: Integer;
  CellWidth: Integer;
  ACol: Integer;
  ARow: Integer;
begin
  RowStartValue := 1 + random(6);
  ColStartValue := 1 + random(6);
  GridMaxRows := 5 + random(22);
  GridMaxCols := 5 + random(22);
  CellWidth := 32;
  aStringGrid.RowCount := GridMaxRows + 1;
  aStringGrid.ColCount := GridMaxCols + 1;
  aStringGrid.ColWidths[0] := CellWidth;
  for ACol := 0 to GridMaxCols - 1 do
  begin
    aStringGrid.Cells[ACol + 1, 0] := (ACol + ColStartValue).ToString;
    aStringGrid.ColWidths[ACol + 1] := CellWidth;
  end;
  for ARow := 0 to GridMaxRows - 1 do
  begin
    aStringGrid.Cells[0, ARow + 1] := (ARow + RowStartValue).ToString;
  end;
  for ARow := 0 to GridMaxRows - 1 do
    for ACol := 0 to GridMaxCols - 1 do
    begin
      aStringGrid.Cells[ACol + 1, ARow + 1] :=
        ((ACol + ColStartValue) * (ARow + RowStartValue)).ToString;
    end;
end;

end.
