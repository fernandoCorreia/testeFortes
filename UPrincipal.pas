unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, libtab,
  Data.SqlExpr, Data.FMTBcd, Data.DBXFirebird;

type
  TfrmPrincipal = class(TForm)
    btAbastecimentos: TButton;
    btSair: TButton;
    Btrelatorio: TButton;
    procedure btAbastecimentosClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtrelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    Conection: TSQLConnection;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UAbastecimentos, uDmConn, uRelatorio;

procedure TfrmPrincipal.btAbastecimentosClick(Sender: TObject);
begin
  try
    FrmAbastecimentos := TFrmAbastecimentos.create(Application);
    frmAbastecimentos.showmodal;
  finally
     FreeandNil(frmAbastecimentos);
  end;
end;

procedure TfrmPrincipal.BtrelatorioClick(Sender: TObject);
begin
  TRY
    frmRelatorio := TfrmRelatorio.Create(application);
    frmRelatorio.RLReport1.Preview() ;
  FINALLY
    FreeAndNil(frmRelatorio);
  END;
end;

procedure TfrmPrincipal.btSairClick(Sender: TObject);
begin
  Dmconn.Conn.Connected := False;
  Close;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    Dmconn.Conn.Connected := true;
  Except on e:Exception do
    Showmessage('Erro de conexão: ' + SlineBreak + e.Message);
  end;
end;

end.
