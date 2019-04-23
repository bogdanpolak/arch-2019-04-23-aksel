unit Main.GenericCollection;

interface

procedure Execute_GenericCollectionDemo;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  DataModule.CenericCollection,
  Helper.TDataSet;

type
  TShipmentWarning = (swGreen, swYellow, swRed);

  TOrder = class
    OrderID: Integer;
    CustomerID: String;
    EmployeeID: Integer;
    EmployeeName: String;
    OrderDate: TDateTime;
    RequiredDate: TDateTime;
    ShippedDate: Variant;
    ShipVia: Integer;
    Freight: Currency;
    function IsShipped: boolean;
    function ShipmentWarnng: TShipmentWarning;
  end;

  TOrderList = class(TObjectList<TOrder>)
    function GetOrdersExpectedToShip: TList<TOrder>;
  end;

function TOrder.IsShipped: boolean;
begin
  Result := ShippedDate <> Null;
end;

function TOrder.ShipmentWarnng: TShipmentWarning;
var
  daysToRequire: Int64;
begin
  if IsShipped then
    Result := swGreen
  else begin
    daysToRequire := round(int(RequiredDate - Now));
    if daysToRequire < 0 then
      Result := swRed
    else if daysToRequire <=7 then
      Result := swYellow
    else
      Result := swGreen;
  end;
end;

function TOrderList.GetOrdersExpectedToShip: TList<TOrder>;
var
  o: TOrder;
begin
  Result := TList<TOrder>.Create();
  for o in Self do
    if o.ShipmentWarnng=swRed then
      Result.Add(o);
end;

procedure Execute_GenericCollectionDemo;
var
  dm: TDataModule1;
  Orders: TOrderList;
  OrdersForShipment: TList<TOrder>;
  o: TOrder;
  addDays: Integer;
  CompareOrderDateReverse: TComparison<TOrder>;
begin
  dm := TDataModule1.Create(nil);
  Orders := TOrderList.Create();
  // -----------------------------------------------------------
  dm.dsOrders.Open();
  while not dm.dsOrders.Eof do
  begin
    o := TOrder.Create;
    Orders.Add(o);
    addDays := 7620;
    with o do begin
      OrderID := dm.dsOrdersOrderID.Value;
      CustomerID := dm.dsOrdersCustomerID.AsString;
      EmployeeID := dm.dsOrdersEmployeeID.Value;
      EmployeeName := dm.dsOrdersEmployeeName.Value;
      OrderDate := dm.dsOrdersOrderDate.Value + addDays;
      RequiredDate := dm.dsOrdersRequiredDate.Value + addDays;
      if not dm.dsOrdersShippedDate.IsNull then
        ShippedDate := dm.dsOrdersShippedDate.Value + addDays
      else
        ShippedDate := Null;
    end;
    dm.dsOrders.Next;
  end;
  // -----------------------------------------------------------
  OrdersForShipment := Orders.GetOrdersExpectedToShip;
  Writeln('Total orders: ', Orders.Count);
  Writeln('Orders for shippment: ', OrdersForShipment.Count);
  // -----------------------------------------------------------
  CompareOrderDateReverse := function(const Left, Right: TOrder): Integer
  begin
    Result := round(int(Right.OrderDate-Left.OrderDate));
  end;
  OrdersForShipment.Sort(TComparer<TOrder>.Construct(CompareOrderDateReverse));
  // -----------------------------------------------------------
  for o in OrdersForShipment do
    Writeln (o.OrderID.ToString+'  '+DateToStr(o.OrderDate)+
      '  '+DateToStr(o.RequiredDate));
  // -----------------------------------------------------------
  Orders.Free;
  OrdersForShipment.Free;
  dm.Free;
end;

end.
