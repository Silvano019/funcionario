unit UntMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus;

type
  TFrmMain = class(TForm)
    DBGrid1: TDBGrid;
    QryDados: TFDQuery;
    DscDados: TDataSource;
    QryDadosid_funcionario: TIntegerField;
    QryDadosnome: TWideStringField;
    QryDadosendereco: TWideStringField;
    QryDadoscidade: TWideStringField;
    QryDadosestado: TWideStringField;
    QryDadosativo: TWideStringField;
    sb_adicionar: TSpeedButton;
    sb_excluir: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sb_editar: TSpeedButton;
    sp_exporta_todos: TSpeedButton;
    sp_exportar_selecionado: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sb_adicionarClick(Sender: TObject);
    procedure sb_excluirClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sp_exporta_todosClick(Sender: TObject);
    procedure sp_exportar_selecionadoClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
 uses
   untDtm, UntFuncionario, UntDependente, UntUtil;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  with QryDados do
  begin
    Close;
    Open;
  end;
end;

procedure TFrmMain.sb_adicionarClick(Sender: TObject);
begin
  FrmFuncionario:= TFrmFuncionario.create(nil);
  try
    FrmFuncionario.addFuncionario;
    FrmFuncionario.ShowModal;
  finally
    FrmFuncionario.Free;
  end;
  screen.Cursor:= crHourGlass;
  QryDados.Refresh;
  screen.Cursor:= crDefault;
end;

procedure TFrmMain.sb_excluirClick(Sender: TObject);
var
  LMessage: String;
begin
  LMessage:= 'Tem certeza que deseja excluir ' + QryDadosnome.AsString+ '?';
 if Application.MessageBox(PChar(LMessage), 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
   screen.Cursor:= crHourGlass;
   TUtil.excluirDependentes(QryDadosid_funcionario.AsInteger);
   TUtil.excluirFuncionario(QryDadosid_funcionario.AsInteger);
   QryDados.Refresh;
   screen.Cursor:= crDefault;
 end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  FrmFuncionario:= TFrmFuncionario.create(nil);
  try
    FrmFuncionario.setFuncionario(QryDadosid_funcionario.AsInteger);
    FrmFuncionario.ShowModal;
  finally
    FrmFuncionario.Free;
  end;
  screen.Cursor:= crHourGlass;
  QryDados.Refresh;
  screen.Cursor:= crDefault;

end;

procedure TFrmMain.SpeedButton3Click(Sender: TObject);
begin
   FrmDependentes:= TFrmDependentes.create(nil);
  try
    FrmDependentes.getDependente(QryDadosid_funcionario.AsInteger);
    FrmDependentes.ShowModal;
  finally
    FrmFuncionario.Free;
  end;
end;

procedure TFrmMain.sp_exportar_selecionadoClick(Sender: TObject);
var
  LConteudoArquivo: TextFile;
begin
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      raise Exception.Create('Arquivo já existente.');
    end
    else
    begin
      AssignFile(LConteudoArquivo, SaveDialog1.FileName);
      Rewrite(LConteudoArquivo);
      Writeln(LConteudoArquivo,'+-- Lista de Funcionário --+');
      Writeln(LConteudoArquivo,'----------------------------');
      Writeln(LConteudoArquivo, ' Cod. Funcionário: ' + inttostr(QryDadosid_funcionario.AsInteger));
      Writeln(LConteudoArquivo, ' Nome: ' + QryDadosnome.AsString);
      Writeln(LConteudoArquivo, ' Endereço: ' + QryDadosendereco.AsString);
      Writeln(LConteudoArquivo, ' Cidade:  ' + QryDadoscidade.AsString + '-' + QryDadosestado.AsString);
      Writeln(LConteudoArquivo,'----------------------------');
      CloseFile(LConteudoArquivo);
    end;
  end;

end;

procedure TFrmMain.sp_exporta_todosClick(Sender: TObject);
var
  LConteudoArquivo: TextFile;
begin
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      raise Exception.Create('Arquivo já existente.');
    end
    else
    begin
      AssignFile(LConteudoArquivo, SaveDialog1.FileName);
      Rewrite(LConteudoArquivo);
      QryDados.First;
      Writeln(LConteudoArquivo,'+-- Lista de Funcionário --+');
      while not QryDados.Eof do
      begin
        Writeln(LConteudoArquivo,'----------------------------');
        Writeln(LConteudoArquivo, ' Cod. Funcionário: ' + inttostr(QryDadosid_funcionario.AsInteger));
        Writeln(LConteudoArquivo, ' Nome: ' + QryDadosnome.AsString);
        Writeln(LConteudoArquivo, ' Endereço: ' + QryDadosendereco.AsString);
        Writeln(LConteudoArquivo, ' Cidade:  ' + QryDadoscidade.AsString + '-' + QryDadosestado.AsString);
        Writeln(LConteudoArquivo,'----------------------------');
        QryDados.Next;
      end;
      CloseFile(LConteudoArquivo);
    end;
  end;

end;

end.
