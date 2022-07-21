object Dtm: TDtm
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conexao: TFDConnection
    Params.Strings = (
      'Database=teste_wle'
      'User_Name=postgres'
      'Password=123456'
      'DriverID=PG')
    Connected = True
    Left = 48
    Top = 40
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 152
    Top = 40
  end
end
