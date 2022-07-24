object Dtm: TDtm
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conexao: TFDConnection
    Params.Strings = (
      'Database=teste_wle'
      'User_Name=postgres'
      'Password=123456'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    Left = 48
    Top = 40
  end
  object linkDrive: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 144
    Top = 40
  end
end
