unit Model.SortResults;

interface

uses
  System.TimeSpan, System.Diagnostics;

type
  TSortResults = class
  private
    FSwapCounter: Integer;
    FName: string;
    FDataSize: Integer;
    FStopWatch: TStopwatch;
    FElapsed: TTimeSpan;
  public
    constructor Create(const AName: string; ADataSize: Integer);
    procedure StartCountingTime;
    procedure StopCountingTime;

    property SwapCounter: Integer read FSwapCounter write FSwapCounter;
  end;

implementation

constructor TSortResults.Create(const AName: string; ADataSize: Integer);
begin
  FName := AName;
  FDataSize := ADataSize;
end;

procedure TSortResults.StartCountingTime;
begin
  FStopWatch := TStopWatch.StartNew;
end;

procedure TSortResults.StopCountingTime;
begin
  FElapsed := FStopWatch.Elapsed;
end;

end.
