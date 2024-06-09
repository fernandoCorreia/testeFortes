unit uClasses;

interface

uses
  System.SysUtils,
  libtab,
  System.Classes;

type
  TAbastecimento = class
  private
    FCdabastecimento: Integer;
    FDtabastecimento: TDate;
    FCdBomba: Integer;
    FQtlitros: Double;
    FVlTotal: Double;
    FPcImposto: Double;
    procedure SetCdabastecimento(const Value: Integer);
    procedure SetDtabastecimento(const Value: TDate);
    procedure SetCdBomba(const Value: Integer);
    procedure SetQtlitros(const Value: Double);
    procedure SetVlTotal(const Value: Double);
    procedure SetPcImposto(const Value: Double);
  public
    constructor Create(ACdabastecimento: Integer; ADtabastecimento: TDate; ACdBomba: Integer; AQtlitros, AVlTotal, APcImposto: Double);
    function gravar(bAlterar: Boolean): boolean;
    function alterar(campo : string): boolean;
    property Cdabastecimento: Integer read FCdabastecimento write SetCdabastecimento;
    property Dtabastecimento: TDate read FDtabastecimento write SetDtabastecimento;
    property CdBomba: Integer read FCdBomba write SetCdBomba;
    property Qtlitros: Double read FQtlitros write SetQtlitros;
    property VlTotal: Double read FVlTotal write SetVlTotal;
    property PcImposto: Double read FPcImposto write SetPcImposto;
  end;




implementation

{ TAbastecimento }
function TAbastecimento.alterar(campo: string): boolean;
var
  Lista : TstringList;
begin
  try
    Result := false;
    Lista := TStringList.Create;
    if pos('dtAbastecimento', campo) > 0 then
      Lista.Add(' dtAbastecimento = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', FDtabastecimento)));
    if pos('cbBomba', campo) > 0 then
      Lista.Add(' CdBomba = ' + IntToStr(FCdBomba));
    if pos('edLitros', campo) >0 then
    begin
      Lista.Add(' QtLitros = ' + StringReplace(FloatToStr(FQtlitros),',','.', [RfReplaceAll]));
      Lista.Add(' VlTotal = ' + StringReplace(FloatToStr(FVlTotal),',','.', [RfReplaceAll]));
    end;

    Result := alterarTab('TbAbastecimentos', LISTA, ' cdabastecimento = ' + IntToStr(FCdabastecimento));
  finally
    FreeAndNil(Lista)
  end;
end;

constructor TAbastecimento.Create(ACdabastecimento: Integer;
  ADtabastecimento: TDate; ACdBomba: Integer; AQtlitros, AVlTotal,
  APcImposto: Double);
begin
  SetCdabastecimento(ACdabastecimento);
  SetDtabastecimento(ADtabastecimento);
  SetCdBomba(ACdBomba);
  SetQtlitros(AQtlitros);
  SetVlTotal(AVlTotal);
  SetPcImposto(APcImposto);
end;

function TAbastecimento.gravar(bAlterar: boolean): boolean;
var
  lista : tstringlist;
  i: integer;
begin
  try
    Result := false;
    lista := TStringList.Create;
    lista.Insert(0, IntToStr(Cdabastecimento));
    lista.Insert(1, QuotedStr(FormatDateTime('YYYY-MM-DD', Dtabastecimento)));
    lista.Insert(2, IntToStr(CdBomba));
    lista.Insert(3, StringReplace(FloatToStr(Qtlitros),',','.', [RfReplaceAll]));
    lista.Insert(4, StringReplace(FloatToStr(VlTotal),',','.', [RfReplaceAll]));
    lista.Insert(5, FloatToStr(PcImposto));
    Result := gravarTab('TBABASTECIMENTOS', Lista);
  finally
    FreeAndNil(Lista);
  end;
end;

procedure TAbastecimento.SetCdabastecimento(const Value: Integer);
begin
  if Value <= 0 then
    raise Exception.Create('O código do abastecimento não pode ser zero');
  FCdabastecimento := Value;
end;

procedure TAbastecimento.SetDtabastecimento(const Value: TDate);
begin
  if Value = 0 then
    raise Exception.Create('A data do abastecimento não pode ser vazia.');
  FDtabastecimento :=  Value;
end;

procedure TAbastecimento.SetCdBomba(const Value: Integer);
begin
  if Value <= 0 then
    raise Exception.Create('O código da bomba não pode ser zero');
  FCdBomba := Value;
end;

procedure TAbastecimento.SetQtlitros(const Value: Double);
begin
  if Value <= 1 then
    raise Exception.Create('Não permitido abastecimento com menos de 1 litro');
  FQtlitros := Value;
end;

procedure TAbastecimento.SetVlTotal(const Value: Double);
begin
  if Value <= 0 then
    raise Exception.Create('O valor total não pode ser zero ou negativo.');
  FVlTotal := Value;
end;

procedure TAbastecimento.SetPcImposto(const Value: Double);
begin
  if (Value < 0) or (Value > 100) then
    raise Exception.Create('O percentual de imposto deve estar entre 0 e 100.');
  FPcImposto := Value;
end;

end.
