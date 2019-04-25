unit Model.SortResults;

interface

uses
  System.TimeSpan;

type
  TSortResults = class
  private
    FName: string;
    FDataSize: Integer;
    FEnlapsed: TTimeSpan;
    FSwapCounter: Integer;
  public
    property Name: string read FName write FName;
    property DataSize: Integer read FDataSize write FDataSize;
    property Enlapsed: TTimeSpan read FEnlapsed write FEnlapsed;
    property SwapCounter: Integer read FSwapCounter write FSwapCounter;
  end;

implementation

end.
