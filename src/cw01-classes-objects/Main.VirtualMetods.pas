unit Main.VirtualMetods;

interface

procedure Execute_VirtualMetodsDemo;

implementation

type
  TBase = class(TObject)
  public
    procedure NonVirtualOne;
    procedure VirtualOne; virtual;
  end;

  TFoo = class(TBase)
    procedure NonVirtualOne;
    procedure VirtualOne; override;
  end;

procedure Execute_VirtualMetodsDemo;
var
  Foo: TFoo;
begin
  Foo := TFoo.Create;
  Foo.NonVirtualOne;
  Foo.VirtualOne;
  WriteLn('- - -');
  (Foo as TBase).NonVirtualOne;
  (Foo as TBase).VirtualOne;
end;

{ TBase }

procedure TBase.NonVirtualOne;
begin
  WriteLn('  TBase.NonVirtualOne');
end;

procedure TBase.VirtualOne;
begin
  WriteLn('  TBase.VirtualOne');
end;

{ TFoo }

procedure TFoo.NonVirtualOne;
begin
  WriteLn('  TFoo.NonVirtualOne');
  // inherited;
end;

procedure TFoo.VirtualOne;
begin
  WriteLn('  TFoo.VirtualOne');
  // inherited;
end;

end.
