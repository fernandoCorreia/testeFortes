object DmConn: TDmConn
  Left = 0
  Top = 0
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Conn: TFDConnection
    Params.Strings = (
      'Database=C:\Users\Fefe\Documents\TesteFortes\POSTO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=fB')
    LoginPrompt = False
    Left = 216
    Top = 104
  end
end
