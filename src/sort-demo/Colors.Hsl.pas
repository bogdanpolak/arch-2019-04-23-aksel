unit Colors.Hsl;

interface

type
  TRgbColor = record
    r, g, b : byte;
    class function Create (vR, vG, vB: byte): TRgbColor; static;
  end;

function HSLtoRGB(H, S, L: Integer): TRgbColor;


implementation

uses
  System.Math;

{ TRgbColor }

class function TRgbColor.Create (vR, vG, vB: byte): TRgbColor;
begin
  Result.r := vR;
  Result.g := vG;
  Result.b := vB;
end;

function Div255(Value: Cardinal): Cardinal;
begin
  Result := (Value * $8081) shr 23;
end;


function HSLtoRGB(H, S, L: Integer): TRgbColor;
var
  V, M, M1, M2, VSF: Integer;
begin
  if L <= $7F then
    V := L * (256 + S) shr 8
  else
    V := L + S - Integer(Div255(L * S));
  if V <= 0 then
    Result := TRgbColor.Create(0, 0, 0)
  else
  begin
    M := L * 2 - V;
    H := H * 6;
    VSF := (V - M) * (H and $FF) shr 8;
    M1 := M + VSF;
    M2 := V - VSF;
    case H shr 8 of
      0: Result := TRgbColor.Create(V, M1, M);
      1: Result := TRgbColor.Create(M2, V, M);
      2: Result := TRgbColor.Create(M, V, M1);
      3: Result := TRgbColor.Create(M, M2, V);
      4: Result := TRgbColor.Create(M1, M, V);
      5: Result := TRgbColor.Create(V, M, M2);
    else
      Result := TRgbColor.Create(0, 0, 0)
    end;
  end;
end;

end.
