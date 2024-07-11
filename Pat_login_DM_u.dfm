object DM1: TDM1
  Height = 445
  Width = 419
  object ADOCon1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 72
    Top = 96
  end
  object ADOT1: TADOTable
    Connection = ADOCon1
    CursorType = ctStatic
    TableName = 'tblUsers'
    Left = 72
    Top = 168
  end
  object ADOQ1: TADOQuery
    Connection = ADOCon1
    Parameters = <>
    Left = 144
    Top = 128
  end
  object DS1: TDataSource
    DataSet = ADOT1
    Left = 80
    Top = 256
  end
end
