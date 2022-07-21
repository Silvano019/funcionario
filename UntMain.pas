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
    PopupMenu: TPopupMenu;
    Adicionar1: TMenuItem;
    ALterar1: TMenuItem;
    QryDados: TFDQuery;
    DscDados: TDataSource;
    QryDadosid_funcionario: TIntegerField;
    QryDadosnome: TWideStringField;
    QryDadosendereco: TWideStringField;
    QryDadoscidade: TWideStringField;
    QryDadosestado: TWideStringField;
    QryDadosativo: TWideStringField;
    sb_adicionar: TSpeedButton;
    N1: TMenuItem;
    Verdependentes1: TMenuItem;
    sb_excluir: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sb_editar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sb_adicionarClick(Sender: TObject);
    procedure sb_excluirClick(Sender: TObject);
  private
    procedure excluirDependentes(AIdResponsavel: integer);
    procedure excluirFuncionario(AIdFuncionario: integer);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
 uses
   untDtm, UntFuncionario;
procedure TFrmMain.excluirDependentes(AIdResponsavel: integer);
var
  QryExcluir: TFDQuery;
begin
  QryExcluir := TFDQuery.Create(nil);
  Dtm.conexao.StartTransaction;
  try
  begin
    with QryExcluir do
    begin
      Connection:= Dtm.conexao;
      Close;
      Sql.Add('Update dependentes set ativo = ''Não'' where id_reponsavel = :id_reponsavel');
      ParamByname('id_reponsavel').AsInteger:= AIdResponsavel; 
    end;
    QryExcluir.ExecSQL;
    Dtm.conexao.Commit;
    QryExcluir.Free;
  end;
  except on E : Exception do
  begin
    Dtm.conexao.Rollback;
    ShowMessage(E.ClassName+' gerou a seguinte mensagem de erro: '+E.Message);
  end;
 end;
end;

procedure TFrmMain.excluirFuncionario(AIdFuncionario: integer);
var
  QryExcluir: TFDQuery;
begin
  QryExcluir := TFDQuery.Create(nil);
  Dtm.conexao.StartTransaction;
  try
  begin
    with QryExcluir do
    begin
      Connection:= Dtm.conexao;
      Close;
      Sql.Add('Update funcionarios set ativo = ''Não'' where id_funcionario = :id_funcionario');
      ParamByname('id_funcionario').AsInteger:= AIdFuncionario; 
    end;
    QryExcluir.ExecSQL;
    Dtm.conexao.Commit;
    QryExcluir.Free;
  end;
  except on E : Exception do
  begin
    Dtm.conexao.Rollback;
    ShowMessage(E.ClassName+' gerou a seguinte mensagem de erro: '+E.Message);
  end;
 end;
end;

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
begin
 if Application.MessageBox('Tem certeza que deseja excluir este cadastro?', 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
   screen.Cursor:= crHourGlass;
   excluirDependentes(QryDadosid_funcionario.AsInteger);
   excluirFuncionario(QryDadosid_funcionario.AsInteger);
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

end.
