program Funcionario;

uses
  Vcl.Forms,
  UntMain in 'UntMain.pas' {Form1},
  UntDtm in 'UntDtm.pas' {DtmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtmConexao, DtmConexao);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
