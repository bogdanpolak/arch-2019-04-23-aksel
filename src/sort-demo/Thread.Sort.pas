{ * ------------------------------------------------------------------------
  * ♥  Akademia BSC © 2019  ♥
  *  ----------------------------------------------------------------------- * }
unit Thread.Sort;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TSortThread = class(TThread)
  private
    FThreadName: string;
    FSortProc: TProc;
    FOnSortFinished: TProc;
  protected
    procedure Execute; override;
  public
    constructor CreateAndInit(const AThreadName: string; ASortProc: TProc;
      AOnSortFinished: TProc);
  end;

implementation

constructor TSortThread.CreateAndInit(const AThreadName: string;
  ASortProc: TProc; AOnSortFinished: TProc);
begin
  inherited Create(False);
  FThreadName := AThreadName;
  FreeOnTerminate := True;
  FSortProc := ASortProc;
  FOnSortFinished := AOnSortFinished;
end;

procedure TSortThread.Execute;
begin
  NameThreadForDebugging(FThreadName);
  if Assigned(FSortProc) then
    FSortProc;
  if Assigned(FOnSortFinished) then
    FOnSortFinished;
end;

end.
