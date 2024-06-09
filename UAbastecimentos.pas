unit UAbastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.DBCtrls, Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TfrmAbastecimentos = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    lbBomba: TLabel;
    dtAbastecimento: TDateTimePicker;
    edLitros: TEdit;
    lbLitros: TLabel;
    lbVlCombustivel: TLabel;
    edVlCombustivel: TEdit;
    lbVlTotal: TLabel;
    edVlTotal: TEdit;
    btGravar: TButton;
    cbBomba: TComboBox;
    gridConsulta: TDBGrid;
    btConsulta: TButton;
    dsConsulta: TDataSource;
    btAlterar: TButton;

    procedure btGravarClick(Sender: TObject);
    procedure edVlCo(Sender: TObject);
    procedure preencheVlCombustivel;
    procedure cbBombaChange(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure edLitrosExit(Sender: TObject);
    procedure edLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure cbBombaEnter(Sender: TObject);
    procedure edVlTotalChange(Sender: TObject);
    procedure DataFieldGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure preencheCbBomba;
  private
    { Private declarations }
    bAlterar: Boolean;
  public
    QueryBomba : TFDQuery;

  end;

var
  frmAbastecimentos: TfrmAbastecimentos;

implementation
uses
  libfunc, libtab, uClasses, udmConn;
var
  Abastecimento : TAbastecimento;

{$R *.dfm}

procedure TfrmAbastecimentos.btAlterarClick(Sender: TObject);
begin
  preencheCbBomba;
  selecao('TBABASTECIMENTOS A ',
          'JOIN TBBOMBAS b ON '+
          'a.CDBOMBA  = b.CDBOMBA '+
          'JOIN TBTANQUES  c ON   '+
          'c.CDTANQUE  = b.CDTANQUE '+
          'JOIN TBCOMBUSTIVEL d ON  '+
          'c.CDCOMBUSTIVEL = d.CDCOMBUSTIVEL ',
          ' * ',
          ' CDABASTECIMENTO = ' + IntToStr(dsConsulta.DataSet.FieldByName('CdAbastecimento').AsInteger),
          '',
          '' );

  dtAbastecimento.Date := QueryMaster.FieldByName('DtAbastecimento').AsDateTime;
  cbBomba.ItemIndex    := RetornaCdBomba(1, QueryMaster.FieldByName('CdBomba').AsInteger);
  edLitros.Text        := FloatToStr(QueryMaster.FieldByName('Qtlitros').AsFloat);
  edvlTotal.Text       := FloatToStr(QueryMaster.FieldByName('VlTotal').AsFloat);

  Abastecimento := TAbastecimento.Create(queryMaster.FieldByName('cdAbastecimento').AsInteger,
                                         dtAbastecimento.Date,
                                         RetornaCdBomba(0, cbBomba.ItemIndex),
                                         StringFloat(edLitros.Text),
                                         StringFloat(edVlTotal.Text),
                                         13.00);
  BAlterar := true;
end;

procedure TfrmAbastecimentos.btConsultaClick(Sender: TObject);
Var
  DataField: TField;
begin
  LimparCampos(Self.Panel1);
  selecao('TBABASTECIMENTOS  a',
          ' JOIN TBBOMBAS b ON ' +
          ' a.CDBOMBA  = b.CDBOMBA ' +
          ' JOIN TBTANQUES  c ON   ' +
          ' c.CDTANQUE  = b.CDTANQUE ' +
          ' JOIN TBCOMBUSTIVEL d ON  ' +
          ' c.CDCOMBUSTIVEL = d.CDCOMBUSTIVEL ',
          ' a.CdAbastecimento, a.DtAbastecimento, b.DSBOMBA, a.QTLITROS, a.VLTOTAL, d.dsCOMBUSTIVEL',
          '',
          'a.cdAbastecimento',
          '' );
  dsConsulta.DataSet :=  QueryMaster;
  DataField := DsConsulta.DataSet.FieldByName('DtAbastecimento');
  DataField.OnGetText := DataFieldGetText;
  btAlterar.enabled := true;
end;

procedure TfrmAbastecimentos.btGravarClick(Sender: TObject);
var
  CdSequencia: integer;
  Campos: string;

begin
  try
    if BAlterar = false then
    begin
      Abastecimento := TAbastecimento.Create(RetornaSequencia('TbAbastecimentos', 'Cdabastecimento'),
                                             dtAbastecimento.Date,
                                             RetornaCdBomba(0, cbBomba.ItemIndex),
                                             StringFloat(edLitros.Text),
                                             StringFloat(edVlTotal.Text),
                                             13.00);
      if abastecimento.gravar(false) then
        Showmessage('Gravado com sucesso!');
    end
    else
    begin
      if dtAbastecimento.Date <> Abastecimento.Dtabastecimento then
      begin
        campos := 'dtAbastecimento ,' ;
        Abastecimento.Dtabastecimento :=  dtAbastecimento.Date;
      end;
      if RetornaCdBomba(0, cbBomba.ItemIndex) <> RetornaCdBomba(1, Abastecimento.CdBomba) then
      begin
        campos := Campos + 'cbBomba ,';
        Abastecimento.CdBomba := RetornaCdBomba(0, cbBomba.ItemIndex);
      end;
      if strToFloat(edLitros.Text) <> (Abastecimento.Qtlitros) then
      begin
        Campos := Campos + 'edLitros ,';
        Abastecimento.Qtlitros := strToFloat(edLitros.Text);
        Abastecimento.VlTotal :=  strToFloat(edVlTotal.Text);
      end;
      if campos <> EmptyStr then
      begin
        if Abastecimento.alterar(campos) then
        begin
          showmessage('Alterado com sucesso!');
          btAlterar.Enabled := false;
        end;
      end;
      BAlterar := false;
    end;

  Except on e:exception do
  begin
    ShowMessage('Erro ao gravar' + SlineBreak + e.message);
    abort;
  end;
  end;
  LimparCampos(self.Panel1);
  Abastecimento.Destroy;
end;

procedure TfrmAbastecimentos.cbBombaChange(Sender: TObject);
begin
  preencheVlCombustivel;
end;

procedure TfrmAbastecimentos.cbBombaEnter(Sender: TObject);
begin
 preencheCbBomba;
end;

procedure TfrmAbastecimentos.DataFieldGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if not Sender.IsNull then
    Text := FormatDateTime('dd/mm/yyyy', Sender.AsDateTime)
  else
    Text := '';
end;

procedure TfrmAbastecimentos.edLitrosExit(Sender: TObject);
begin
  formataCampos(sender as TEdit);
  if (edLitros.Text = EmptyStr) or
     (edVlCombustivel.Text = EmptyStr)then
     exit;

  edVlTotal.Text :=  CurrToStr(CalculaTotal(StrToCurr(edLitros.Text), StrToCurr(edVlCombustivel.Text)));
end;

procedure TfrmAbastecimentos.edLitrosKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #8]) then
    Key := #0;

  if (Key = ',') and (Pos('.', TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TfrmAbastecimentos.edVlCo(Sender: TObject);
begin
  formataCampos(sender as TEdit)
end;



procedure TfrmAbastecimentos.edVlTotalChange(Sender: TObject);
begin
  formataCampos(sender as TEdit)
end;

procedure TfrmAbastecimentos.FormShow(Sender: TObject);
begin
   dtAbastecimento.Date := Now;
   bAlterar := false;
end;

procedure TfrmAbastecimentos.preencheCbBomba;
var
  Lista : TStringlist;
  i: integer;
begin
   try
     Lista := TstringList.create();
     if cbBomba.Items.Count > 0 then
       exit ;

     Lista := RetornaListaBombas;

     for i := 0 to pred(Lista.count) do
       CBBomba.Items.add(lista.Strings[i]);

     cbBomba.ItemIndex := 0;
     preencheVlCombustivel;
   finally
     FreeAndNil(Lista);
   end;
end;

procedure TfrmAbastecimentos.preencheVlCombustivel;
var
  vlCombustivel: extended;
begin
  selecao('tbbombas a',
          ' JOIN TBTANQUES  b ON ' +
          ' a.CDTANQUE = b.CDTANQUE ' +
          ' JOIN TBCOMBUSTIVEL c ON ' +
          'b.CDCOMBUSTIVEL  = c.CDCOMBUSTIVEL ',
          'VlCombustivel ',
          ' cdbomba = ' + InttoStr(RetornaCdBomba(0, CbBomba.ItemIndex)),
          ' a.cdbomba',
          '');
  vlCombustivel := querymaster.FieldByName('VlCombustivel').AsFloat + (1 + 13.00 / 100);
  edVlCombustivel.text :=  FloatToStr(vlCombustivel);
end;

end.
