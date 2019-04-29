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
    FRunning: Boolean;
    FSortProc: TProc;
    FOnSortFinished: TProc;
  protected
    procedure Execute; override;
  public
    constructor CreateAndInit(const AThreadName: string; ASortProc: TProc;
      AOnSortFinished: TProc);
    function IsTerminated: Boolean;
    function IsRunning: Boolean;
  end;

implementation

constructor TSortThread.CreateAndInit(const AThreadName: string;
  ASortProc: TProc; AOnSortFinished: TProc);
begin
  inherited Create(False);
  NameThreadForDebugging(AThreadName);
  FreeOnTerminate := True;
  FSortProc := ASortProc;
  FOnSortFinished := AOnSortFinished;
end;

procedure TSortThread.Execute;
begin
  FRunning := True;
  if Assigned(FSortProc) then
    FSortProc;
  if Assigned(FOnSortFinished) then
    if not IsTerminated then
      FOnSortFinished;
  FRunning := False;
end;

function TSortThread.IsRunning: Boolean;
begin
  Result := FRunning and not Terminated;
end;

function TSortThread.IsTerminated: Boolean;
begin
  Result := Self.Terminated;
end;

end.
