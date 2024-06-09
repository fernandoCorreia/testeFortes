unit libFunc;

interface

uses
  System.SysUtils,
  System.Classes,
  libtab,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls;

  function RetornaListaBombas: TStringlist;
  function RetornaSequencia(tabela, campo: String): Integer;
  Function RetornaCdBomba(TipoOperacao, index: integer): integer;
  procedure LimparCampos(Campo: TWinControl);
  procedure formataCampos(sender: tobject);
  function CalculaTotal(QtLitros, vlCombustivel: currency): currency;
  function StringFloat(texto: string): extended;

implementation


{ TFuncoes }

function RetornaListaBombas: TStringlist;
var
  Lista: TStringList;
begin
  try
     Lista := TStringList.Create;
     selecao('tbbombas', '', 'cdbomba, dsbomba', '','','');

     if queryMaster.RecordCount > 0 then
     begin
       queryMaster.First;
       while not queryMaster.Eof do
       begin
         Lista.Insert(QueryMaster.FieldByName('CdBomba').AsInteger - 1, QueryMaster.FieldByName('DsBomba').AsString);
         QueryMaster.next;
       end;
     end;
     Result := Lista;
  finally
   // FreeAndNil(Lista);
  end;
end;

function RetornaSequencia(tabela, campo: String): Integer;
begin
   try
     Result := 0;
     selecao(tabela, '', 'max(' + campo+ ') as seq', '','','');
   finally
     if QueryMaster.RecordCount > 0 then
       Result := QueryMaster.FieldByName('seq').AsInteger + 1;
   end;
end;

Function RetornaCdBomba(TipoOperacao, index: integer): integer;
begin
  result := 0;
  if TipoOperacao = 0 then
  begin
    case index of
      0: Result := 1;
      1: Result := 2;
      2: Result := 3;
      3: Result := 4;
    end;
  End
  else
  begin
    case index of
      1: Result := 0;
      2: Result := 1;
      3: Result := 2;
      4: Result := 3;
    end;
  end;
end;

procedure LimparCampos(Campo: TWinControl);
var
  I: Integer;
begin
  for I := 0 to Campo.ControlCount - 1 do
  begin
    if Campo.Controls[I] is TEdit then
      TEdit(Campo.Controls[I]).Text := ''
    else if Campo.Controls[I] is TComboBox then
      begin
        TComboBox(Campo.Controls[I]).ItemIndex := -1;
        TComboBox(Campo.Controls[I]).Items.clear;
      end
    else if Campo.Controls[I] is TDateTimePicker then
      TDateTimePicker(Campo.Controls[I]).DateTime := Date;
  end;
end;

procedure formataCampos(sender: tobject);
var
  Valor:Currency;
  Formatacao: string;
begin
  if TryStrToCurr(TEdit(sender).Text, Valor) then
  begin
    Formatacao := FormatCurr('#,##0.00', Valor);
    TEdit(sender).Text := Formatacao;
  end;
end;

function CalculaTotal(QtLitros, vlCombustivel: currency): currency;
var
  vlTotal : currency;
begin
  try
     vlTotal := 0 ;
     vlTotal := qtLitros * VlCombustivel;
  finally
     result := vltotal;
  end;
end;

function StringFloat(texto: string): extended;
begin
  if texto = EmptyStr then
  begin
    Result := 0;
    exit;
  end;
  result := StrToFloat(texto)
end;

end.
