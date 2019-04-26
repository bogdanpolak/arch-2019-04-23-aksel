unit Thread.SortControler;

interface

uses
  System.Classes;

type
  TSortProc = procedure of object;
  TCallBackAfterSort = procedure of object;

  TSortControlerThread = class(TThread)
  private
    FRunning: Boolean;
    FSortProc: TSortProc;
    FCallBackAfterSort: TCallBackAfterSort;
  protected
    procedure Execute; override;
  public
    constructor CreateAndInit(ASortProc: TSortProc; ACallBackAfterSort: TCallBackAfterSort);
    function IsTerminated: Boolean;
    function IsRunning: Boolean;
  end;

implementation

constructor TSortControlerThread.CreateAndInit(ASortProc: TSortProc; ACallBackAfterSort: TCallBackAfterSort);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FSortProc := ASortProc;
  FCallBackAfterSort := ACallBackAfterSort;
end;

procedure TSortControlerThread.Execute;
begin
  FRunning := True;
  NameThreadForDebugging('ControlerThread');
  if Assigned(FSortProc) then
    FSortProc;
  if Assigned(FCallBackAfterSort) then
    if not IsTerminated then
      FCallBackAfterSort;
  FRunning := False;
end;

function TSortControlerThread.IsRunning: Boolean;
begin
  Result := FRunning and not Terminated;
end;

function TSortControlerThread.IsTerminated: Boolean;
begin
  Result := Self.Terminated;
end;

end.
