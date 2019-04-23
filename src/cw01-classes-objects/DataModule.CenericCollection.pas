unit DataModule.CenericCollection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.ConsoleUI.Wait, FireDAC.DApt, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    dsOrders: TFDQuery;
    dsOrdersOrderID: TFDAutoIncField;
    dsOrdersCustomerID: TStringField;
    dsOrdersEmployeeID: TIntegerField;
    dsOrdersEmployeeName: TWideStringField;
    dsOrdersOrderDate: TDateTimeField;
    dsOrdersRequiredDate: TDateTimeField;
    dsOrdersShippedDate: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
