unit libtab;

interface

uses
  Data.SqlExpr,
  Data.FMTBcd,
  Data.DBXFirebird,
  System.SysUtils,
  vcl.forms,
  UDmConn,
  System.Classes,
  FireDAC.Comp.Client;



  procedure selecao(nomeTab, juncao , campos, condicoes, ordenacao, agrupamento: string );
  function gravarTab(nometab: string; campos: TStringList): boolean;
  function alterarTab(nometab: string; campos: tStringlist; condicao: string): boolean;

  var
    QueryMaster : TfdQuery;
implementation


{ tComandos }

procedure selecao(nomeTab, juncao, campos, condicoes, ordenacao,
  agrupamento: string);
var
   Query : TfdQuery;
begin
  try
    Query := TFdQuery.Create(nil);
    query.Connection := DmConn.Conn;
    Query.Close;
    Query.SQL.Clear;
    Query.sql.Add(' Select ' + campos);
    Query.sql.Add(' From ' + nomeTab);
    if juncao <> emptyStr then
      Query.sql.Add( juncao);
    if condicoes <> EmptyStr then
      Query.sql.Add(' where ' + Condicoes);
    if Ordenacao <> EmptyStr then
      Query.sql.Add(' order by ' + ordenacao);
    if agrupamento <> EmptyStr then
      Query.sql.Add(' group by ' + agrupamento);
    Query.Open;

    QueryMaster := Query;
  Except on e:Exception do
     raise Exception.Create('Erro função selecao: ' + e.Message);
  end;
end;

Function gravarTab(nometab: string; campos: tStringList): Boolean;
var
  InsCmd: TFDCommand;
  i: integer;
begin
  try
    try
      InsCmd := TFDCommand.Create(nil);
      InsCmd.Connection := DmConn.Conn;
      InsCmd.CommandText.Clear;
      InsCmd.CommandText.Add(' INSERT INTO ' + nometab);
      InsCmd.CommandText.Add(' values( ');
      for I := 0 to pred(campos.Count) do
      begin
        if i = pred(campos.Count) then
          InsCmd.CommandText.Add( campos.Strings[i] + ')' )
        else
          InsCmd.CommandText.Add( campos.Strings[i] + ', ' );
      end;
      InsCmd.Execute(0);
      Result := true;
    Except on e:Exception do
      begin
        Result := false;
        raise Exception.Create('Erro GravaTab libtab: ' + SlineBreak + e.Message);
      end;
    end;
  finally
    FreeAndNil(InsCmd);
  end;
end;

function alterarTab(nometab: string; campos: tStringlist; condicao: string): boolean;
var
  updCmd: TFdQuery;
  i: integer;
begin
  try
    try
      updCmd := TFdQuery.Create(nil);
      updCmd.Connection := DmConn.Conn;
      updCmd.Sql.Clear;
      updCmd.Sql.Add('UPDATE ' + nometab);
      updCmd.Sql.Add(' SET ' );
      for I := 0 to pred(campos.Count) do
      begin
        if i = pred(campos.Count) then
          updCmd.Sql.Add( campos.Strings[i])
        else
          updCmd.Sql.Add( campos.Strings[i] + ', ' );
      end;
      updCmd.Sql.Add(' WHERE ' + condicao);
      updCmd.ExecSQL;
      Result := true;
      Except on e:exception do
      begin
        Result := false;
        raise Exception.Create('Erro alterarTab libtab : ' + SlineBreak + e.Message);
      end;
      end;
  finally
    FreeAndNil(updCmd);
  end;
end;
end.
