unit View.Board;

interface

uses
  System.TimeSpan;

type
  IBoardView = interface
    ['{8734291B-DA8D-4569-8AEC-A9741DE778B7}']
    procedure DrawBoard;
    procedure DrawItem(AIndex: Integer);
    procedure DrawResults (const AAlgoritmName: string;
      AElapsedTime: TTimeSpan);
    function CountVisibleItems: Integer;
  end;

implementation

end.
