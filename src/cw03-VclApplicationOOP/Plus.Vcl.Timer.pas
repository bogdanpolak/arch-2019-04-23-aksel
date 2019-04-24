unit Plus.Vcl.Timer;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.ExtCtrls;

type
  TEventOnFirstShow = class(TComponent)
  private
    FOnFirstShow: System.SysUtils.TProc;
    FTimer: TTimer;
    procedure OnTimerEvent(Sender: TObject);
  public
    constructor Create(Owner: TComponent); override;
    property OnFirstShow: TProc read FOnFirstShow write FOnFirstShow;
    class procedure Setup(Owner: TComponent; OnFirstShow: TProc);
  end;

  TTimerMode = (tmOnce, tmRepeat);

  TEvenOnTimer = class(TComponent)
  private
    FOnTimer: System.SysUtils.TProc;
    FTimerMode: TTimerMode;
    FTimer: TTimer;
    FInterval: Integer;
    procedure OnTimerEvent(Sender: TObject);
    procedure SetInterval(const Value: Integer);
  public
    constructor Create(Owner: TComponent); override;
    property OnTimer: TProc read FOnTimer write FOnTimer;
    property Interval: Integer read FInterval write SetInterval;
    class procedure SetupRepeat(Owner: TComponent; DelayMs: Integer;
      OnTimerProc: TProc);
    class procedure SetupOnce(Owner: TComponent; DelayMs: Integer;
      OnTimerProc: TProc);
  end;

implementation

{ TFirstShowEvent }

constructor TEventOnFirstShow.Create(Owner: TComponent);
begin
  inherited;
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 1;
  FTimer.Enabled := True;
  FTimer.OnTimer := OnTimerEvent;
end;

procedure TEventOnFirstShow.OnTimerEvent(Sender: TObject);
begin
  if Assigned(FOnFirstShow) then
    FOnFirstShow();
  FTimer.Free;
  FTimer := nil;
end;

class procedure TEventOnFirstShow.Setup(Owner: TComponent; OnFirstShow: TProc);
var
  obj: TEventOnFirstShow;
begin
  obj := TEventOnFirstShow.Create(Owner);
  obj.FOnFirstShow := OnFirstShow;
end;

{ TEvenOnTimer }

constructor TEvenOnTimer.Create(Owner: TComponent);
begin
  inherited;
  FTimer := TTimer.Create(Self);
  FTimer.OnTimer := OnTimerEvent;
end;

procedure TEvenOnTimer.OnTimerEvent(Sender: TObject);
begin
  if Assigned(FOnTimer) then
    FOnTimer();
  if (FTimerMode = tmOnce) then
  begin
    FTimer.Enabled := False;
    FTimer.Free;
    FTimer := nil;
  end;
end;

procedure TEvenOnTimer.SetInterval(const Value: Integer);
begin
  FTimer.Enabled := False;
  FTimer.Interval := Value;
  FTimer.Enabled := True;
  FInterval := Value;
end;

class procedure TEvenOnTimer.SetupOnce(Owner: TComponent; DelayMs: Integer;
  OnTimerProc: TProc);
begin
  with TEvenOnTimer.Create(Owner) do
  begin
    OnTimer := OnTimerProc;
    FTimerMode := tmOnce;
    Interval := DelayMs;
  end;
end;

class procedure TEvenOnTimer.SetupRepeat(Owner: TComponent; DelayMs: Integer;
  OnTimerProc: TProc);
begin
  with TEvenOnTimer.Create(Owner) do
  begin
    OnTimer := OnTimerProc;
    FTimerMode := tmRepeat;
    Interval := DelayMs;
  end;
end;

end.
