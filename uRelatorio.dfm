object frmRelatorio: TfrmRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 437
  ClientWidth = 955
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = -8
    Top = -16
    Width = 794
    Height = 1123
    DataSource = dsRelat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 96
      Width = 718
      Height = 25
      object RLDBText1: TRLDBText
        Left = 17
        Top = 3
        Width = 144
        Height = 16
        DataField = 'dtabastecimento'
        DataSource = dsRelat
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 177
        Top = 3
        Width = 88
        Height = 16
        DataField = 'cdtanque'
        DataSource = dsRelat
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 289
        Top = 3
        Width = 258
        Height = 16
        DataField = 'dsbomba'
        DataSource = dsRelat
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 569
        Top = 3
        Width = 128
        Height = 16
        Alignment = taRightJustify
        DataField = 'vltotal'
        DataSource = dsRelat
        DisplayMask = '#0.00'
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 58
      BandType = btColumnHeader
    end
    object RLLabel1: TRLLabel
      Left = 55
      Top = 53
      Width = 133
      Height = 16
      Caption = 'Data Abateciemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RLLabel2: TRLLabel
      Left = 215
      Top = 53
      Width = 85
      Height = 16
      Caption = 'C'#243'd. Tanque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RLLabel3: TRLLabel
      Left = 431
      Top = 53
      Width = 50
      Height = 16
      Alignment = taCenter
      Caption = 'Bomba'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RLLabel4: TRLLabel
      Left = 634
      Top = 53
      Width = 74
      Height = 16
      Alignment = taCenter
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 121
      Width = 718
      Height = 40
      BandType = btSummary
      object RLDBResult1: TRLDBResult
        Left = 569
        Top = 21
        Width = 115
        Height = 16
        DataField = 'vltotal'
        DataSource = dsRelat
        DisplayMask = '#0.00'
        Info = riSum
        Text = ''
      end
      object RLLabel5: TRLLabel
        Left = 462
        Top = 21
        Width = 47
        Height = 16
        Caption = 'TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object dsRelat: TDataSource
    AutoEdit = False
    DataSet = queryRelat
    Left = 128
    Top = 248
  end
  object queryRelat: TFDQuery
    Active = True
    Connection = DmConn.Conn
    SQL.Strings = (
      
        'SELECT  c.CDTANQUE, a.DtAbastecimento, b.DSBOMBA,  sum(a.VLTOTAL' +
        ') AS vltotal'
      'FROM TBABASTECIMENTOS  a'
      'JOIN TBBOMBAS b ON'
      'a.CDBOMBA  = b.CDBOMBA '
      'JOIN TBTANQUES  c ON'
      'c.CDTANQUE  = b.CDTANQUE '
      'JOIN TBCOMBUSTIVEL d ON'
      'c.CDCOMBUSTIVEL = d.CDCOMBUSTIVEL '
      'GROUP BY '
      'DTABASTECIMENTO,  '
      'c.CDTANQUE, '
      'b.DSBOMBA ')
    Left = 160
    Top = 248
    object queryRelatcdtanque: TIntegerField
      FieldName = 'cdtanque'
    end
    object queryRelatdtabastecimento: TDateField
      FieldName = 'dtabastecimento'
    end
    object queryRelatdsbomba: TStringField
      FieldName = 'dsbomba'
      Size = 50
    end
    object queryRelatvltotal: TBCDField
      FieldName = 'vltotal'
      Size = 2
    end
  end
end
