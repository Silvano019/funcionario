object Dtm: TDtm
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conexao: TFDConnection
    Params.Strings = (
      'Database=teste_wle_'
      'User_Name=postgres'
      'Password=123456'
      'Server=localhost'
      'DriverID=PG')
    Left = 48
    Top = 40
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 144
    Top = 40
  end
end
