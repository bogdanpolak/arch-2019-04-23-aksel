unit Plus.System.AnonymousEvent;

interface

uses
  System.Classes, System.SysUtils;

type
  TNotifyEventWrapper = class(TComponent)
  private
    FProc: TProc<TObject>;
  public
    constructor Create(Owner: TComponent; Proc: TProc<TObject>);
  published
    procedure Event(Sender: TObject);
  end;

function AnonymousMethodToTNotifyEvent(Owner: TComponent; Proc: TProc<TObject>)
  : TNotifyEvent;

implementation

constructor TNotifyEventWrapper.Create(Owner: TComponent; Proc: TProc<TObject>);
begin
  inherited Create(Owner);
  FProc := Proc;
end;

procedure TNotifyEventWrapper.Event(Sender: TObject);
begin
  FProc(Sender);
end;

function AnonymousMethodToTNotifyEvent(Owner: TComponent; Proc: TProc<TObject>)
  : TNotifyEvent;
begin
  Result := TNotifyEventWrapper.Create(Owner, Proc).Event;
end;

end.
