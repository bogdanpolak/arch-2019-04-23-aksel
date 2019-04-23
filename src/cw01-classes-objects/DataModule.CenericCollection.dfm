object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 169
  Width = 233
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLite_Demo')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object dsOrders: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT OrderID, CustomerID, '
      
        '  Orders.EmployeeID, Employees.FirstName||'#39' '#39'||Employees.LastNam' +
        'e as EmployeeName, '
      '  OrderDate, RequiredDate, ShippedDate'
      'FROM Orders'
      
        'INNER JOIN Employees ON (Employees.EmployeeID = Orders.EmployeeI' +
        'D)'
      ''
      '')
    Left = 40
    Top = 72
    object dsOrdersOrderID: TFDAutoIncField
      FieldName = 'OrderID'
      Origin = 'OrderID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object dsOrdersCustomerID: TStringField
      FieldName = 'CustomerID'
      Origin = 'CustomerID'
      FixedChar = True
      Size = 5
    end
    object dsOrdersEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'EmployeeID'
    end
    object dsOrdersEmployeeName: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'EmployeeName'
      Origin = 'EmployeeName'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object dsOrdersOrderDate: TDateTimeField
      FieldName = 'OrderDate'
      Origin = 'OrderDate'
    end
    object dsOrdersRequiredDate: TDateTimeField
      FieldName = 'RequiredDate'
      Origin = 'RequiredDate'
    end
    object dsOrdersShippedDate: TDateTimeField
      FieldName = 'ShippedDate'
      Origin = 'ShippedDate'
    end
  end
end
