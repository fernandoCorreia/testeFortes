unit uDmConn;
(*

  ********** DM Criado apenas para realizar a conexão com o banco
  ********** O comando Conn := TSqlConnection.Create(nil) está com algum bug na minha install do Delphi

*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXFirebird, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client;

type
  TDmConn = class(TForm)
    Conn: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmConn: TDmConn;

implementation

{$R *.dfm}

end.
