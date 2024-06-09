object frmAbastecimentos: TfrmAbastecimentos
  Left = 0
  Top = 0
  Caption = 'Abastecimentos'
  ClientHeight = 461
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 949
    Height = 169
    Align = alTop
    TabOrder = 0
    ExplicitTop = -5
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 97
      Height = 13
      Caption = 'Data Abastecimento'
    end
    object lbBomba: TLabel
      Left = 168
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Bomba'
    end
    object lbLitros: TLabel
      Left = 24
      Top = 77
      Width = 26
      Height = 13
      Caption = 'Litros'
    end
    object lbVlCombustivel: TLabel
      Left = 168
      Top = 77
      Width = 85
      Height = 13
      Caption = 'Valor Combustivel'
    end
    object lbVlTotal: TLabel
      Left = 312
      Top = 77
      Width = 49
      Height = 13
      Caption = 'Valor total'
    end
    object dtAbastecimento: TDateTimePicker
      Left = 24
      Top = 43
      Width = 121
      Height = 21
      Date = 0.590996261576947300
      Time = 0.590996261576947300
      TabOrder = 0
    end
    object edLitros: TEdit
      Left = 24
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 2
      OnExit = edLitrosExit
      OnKeyPress = edLitrosKeyPress
    end
    object edVlCombustivel: TEdit
      Left = 168
      Top = 96
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 3
      OnChange = edVlCo
    end
    object edVlTotal: TEdit
      Left = 312
      Top = 96
      Width = 129
      Height = 21
      Enabled = False
      TabOrder = 4
      OnChange = edVlTotalChange
      OnKeyPress = edLitrosKeyPress
    end
    object btGravar: TButton
      Left = 504
      Top = 27
      Width = 75
      Height = 54
      Caption = '&Gravar'
      TabOrder = 5
      OnClick = btGravarClick
    end
    object cbBomba: TComboBox
      Left = 168
      Top = 43
      Width = 273
      Height = 21
      TabOrder = 1
      OnChange = cbBombaChange
      OnEnter = cbBombaEnter
    end
    object btConsulta: TButton
      Left = 864
      Top = 138
      Width = 75
      Height = 25
      Caption = 'Consulta'
      TabOrder = 6
      OnClick = btConsultaClick
    end
    object btAlterar: TButton
      Left = 504
      Top = 87
      Width = 75
      Height = 54
      Caption = '&Alterar'
      Enabled = False
      TabOrder = 7
      OnClick = btAlterarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 169
    Width = 949
    Height = 292
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 183
    ExplicitWidth = 933
    ExplicitHeight = 270
    object gridConsulta: TDBGrid
      Left = 1
      Top = 1
      Width = 947
      Height = 290
      Align = alClient
      DataSource = dsConsulta
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cdAbastecimento'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DtAbastecimento'
          Title.Caption = 'Data Abastecimento'
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DSBOMBA'
          Title.Caption = 'Bomba'
          Width = 259
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qtlitros'
          Title.Caption = 'Litros'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vltotal'
          Title.Caption = 'Valor Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscombustivel'
          Title.Caption = 'Combust'#237'vel'
          Visible = True
        end>
    end
  end
  object dsConsulta: TDataSource
    AutoEdit = False
    Left = 632
    Top = 105
  end
end
