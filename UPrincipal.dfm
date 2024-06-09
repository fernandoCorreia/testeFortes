object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Posto ABC'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnShow = FormShow
  DesignSize = (
    447
    201)
  PixelsPerInch = 96
  TextHeight = 13
  object btAbastecimentos: TButton
    Left = 0
    Top = 0
    Width = 447
    Height = 41
    Align = alTop
    Caption = '&Abastecimentos'
    Style = bsCommandLink
    TabOrder = 0
    OnClick = btAbastecimentosClick
  end
  object btSair: TButton
    Left = 344
    Top = 136
    Width = 95
    Height = 57
    Anchors = [akRight, akBottom]
    Caption = '&Sair'
    TabOrder = 1
    OnClick = btSairClick
  end
  object Btrelatorio: TButton
    Left = 0
    Top = 41
    Width = 447
    Height = 41
    Align = alTop
    Caption = '&Relat'#243'rio'
    Style = bsCommandLink
    TabOrder = 2
    OnClick = BtrelatorioClick
  end
end
