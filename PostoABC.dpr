program PostoABC;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {frmPrincipal},
  UAbastecimentos in 'UAbastecimentos.pas' {frmAbastecimentos},
  libtab in 'libtab.pas',
  uDmConn in 'uDmConn.pas' {DmConn},
  libFunc in 'libFunc.pas',
  uClasses in 'uClasses.pas',
  uRelatorio in 'uRelatorio.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDmConn, DmConn);
  Application.Run;
end.
