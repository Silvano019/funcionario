program Funcionario;

uses
  Vcl.Forms,
  UntMain in 'UntMain.pas' {FrmMain},
  UntDtm in 'UntDtm.pas' {Dtm: TDataModule},
  UntFuncionario in 'UntFuncionario.pas' {FrmFuncionario},
  UntUtil in 'UntUtil.pas',
  UntDependente in 'UntDependente.pas' {FrmDependentes},
  UntManDependente in 'UntManDependente.pas' {FrmManDependente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtm, Dtm);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
