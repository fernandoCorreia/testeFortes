unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, RLReport, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelatorio = class(TForm)
    RLReport1: TRLReport;
    dsRelat: TDataSource;
    queryRelat: TFDQuery;
    queryRelatcdtanque: TIntegerField;
    queryRelatdtabastecimento: TDateField;
    queryRelatdsbomba: TStringField;
    queryRelatvltotal: TBCDField;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel5: TRLLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

uses
  udmconn;

{$R *.dfm}

procedure TfrmRelatorio.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  queryRelat.Close;
end;

procedure TfrmRelatorio.FormShow(Sender: TObject);
begin
  queryRelat.Close;
  queryRelat.sql.clear;
  queryRelat.sql.Add(' SELECT  c.CDTANQUE, a.DtAbastecimento, b.DSBOMBA,  sum(a.VLTOTAL) AS vltotal ');
  queryRelat.sql.Add('FROM TBABASTECIMENTOS  a                                                      ');
  queryRelat.sql.Add('JOIN TBBOMBAS b ON                                                            ');
  queryRelat.sql.Add('a.CDBOMBA  = b.CDBOMBA                                                        ');
  queryRelat.sql.Add('JOIN TBTANQUES  c ON                                                          ');
  queryRelat.sql.Add('c.CDTANQUE  = b.CDTANQUE                                                      ');
  queryRelat.sql.Add('JOIN TBCOMBUSTIVEL d ON                                                       ');
  queryRelat.sql.Add('c.CDCOMBUSTIVEL = d.CDCOMBUSTIVEL                                             ');
  queryRelat.sql.Add('GROUP BY                                                                      ');
  queryRelat.sql.Add('DTABASTECIMENTO,                                                              ');
  queryRelat.sql.Add('c.CDTANQUE,                                                                   ');
  queryRelat.sql.Add('b.DSBOMBA                                                                     ');

  queryRelat.Open();
  RLReport1.Refresh;
end;

end.
