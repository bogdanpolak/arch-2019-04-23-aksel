unit Main.ClassMembers;

interface

procedure Execute_ClassMembersDemo;

implementation

type
  TFoo = class
  strict private
    class var i: integer;
    class function privateFun: boolean;
  public
    const JAKAS_LICZBA = 5;
    class function SetVariableI (i:integer): boolean;
    class function fun2: integer;
  end;

class function TFoo.SetVariableI (i:integer): boolean;
begin
  self.i := i;
end;

class function TFoo.fun2: integer;
begin
  Result := i + JAKAS_LICZBA;
end;

class function TFoo.privateFun: boolean;
begin

end;

procedure Execute_ClassMembersDemo;
begin
  TFoo.SetVariableI(10);
  WriteLn ('  funckja TFoo.fun2 = ',TFoo.fun2);
  WriteLn ('  sta³a TFoo.JAKAS_LICZBA = ',TFoo.JAKAS_LICZBA);
  // --------
  // Nie widaæ
  // * TFoo.i
  // * TFoo.privateFun
end;

end.
