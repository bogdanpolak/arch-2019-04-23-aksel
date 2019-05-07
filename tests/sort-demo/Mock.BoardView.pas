{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Mock.BoardView;

interface

uses
  System.Classes, System.SysUtils, System.TimeSpan,
  View.Board;

// TODO: Zdefiniować klasę TBoardViewMock, która implementuje interface IBoardView
(*
  Uwaga!
  -------
  Metoda CountVisibleItems musi zwracać liczbę elementów. Nie warto wpisywać
  za duzej wartości bo sortowanie bąbelkowe bedzie trwało zbyt długo/
  Max. 20 elementów
*)

type
  TBoardViewMock = class(TInterfacedObject, IBoardView)
  public
    procedure DrawBoard;
    procedure DrawItem(AIndex: Integer);
    procedure DrawResults(const AAlgoritmName: string; AElapsedTime: TTimeSpan);
    function CountVisibleItems: Integer;
  end;

implementation

{ TBoardViewMock }

function TBoardViewMock.CountVisibleItems: Integer;
begin
  Result := 15;
end;

procedure TBoardViewMock.DrawBoard;
begin
  { do nothing }
end;

procedure TBoardViewMock.DrawItem(AIndex: Integer);
begin
  { do nothing }
end;

procedure TBoardViewMock.DrawResults(const AAlgoritmName: string;
  AElapsedTime: TTimeSpan);
begin
  { do nothing }
end;

end.
