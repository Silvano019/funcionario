unit UntUtil;

interface

type
  TUtil = class
 private

 public
  class procedure excluirTodosDependentes(AIdResponsavel: integer);
  class procedure excluirDependentes(AIdDependente: integer);
  class procedure excluirFuncionario(AIdFuncionario: integer);
 end;
implementation

{ TUtil }
  uses
   untDtm, FireDAC.Comp.Client, Vcl.Dialogs, System.SysUtils;
class procedure TUtil.excluirTodosDependentes(AIdResponsavel: integer);
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

class procedure TUtil.excluirDependentes(AIdDependente: integer);
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
      Sql.Add('Update dependentes set ativo = ''Não'' where id_dependente = :id_dependente');
      ParamByname('id_dependente').AsInteger:= AIdDependente;
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

class procedure TUtil.excluirFuncionario(AIdFuncionario: integer);
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

end.
