{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Model.SortResults;

interface

uses
  System.TimeSpan;

type
  TSortResults = class { todo: guard na property }
  private
    FSwapCounter: Integer;
    FName: string;
    FDataSize: Integer;
    FElapsedTime: TTimeSpan;
  public
    property DataSize: Integer read FDataSize write FDataSize;
    property Name: string read FName write FName;
    property SwapCounter: Integer read FSwapCounter write FSwapCounter;
    property ElapsedTime: TTimeSpan read FElapsedTime write FElapsedTime;
  end;

implementation

end.
