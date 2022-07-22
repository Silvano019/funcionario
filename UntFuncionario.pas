unit UntFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  TFrmFuncionario = class(TForm)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    QryFuncionario: TFDQuery;
    QryFuncionarioid_funcionario: TIntegerField;
    QryFuncionarionome: TWideStringField;
    QryFuncionarioendereco: TWideStringField;
    QryFuncionariocidade: TWideStringField;
    QryFuncionarioestado: TWideStringField;
    QryFuncionarioativo: TWideStringField;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBComboBox1: TDBComboBox;
    DscFuncionario: TDataSource;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public
    procedure setFuncionario(AId_funcionario: integer);
    procedure addFuncionario;
  end;

var
  FrmFuncionario: TFrmFuncionario;

implementation

{$R *.dfm}

 uses
   untDtm;

{ TFrmFuncionario }

procedure TFrmFuncionario.addFuncionario;
begin
  Caption:= 'Criar novo cadastro';
  QryFuncionario.CreateDataSet;
  QryFuncionario.Insert;
end;

procedure TFrmFuncionario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFrmFuncionario.FormDestroy(Sender: TObject);
begin
   FrmFuncionario:= nil;
end;

procedure TFrmFuncionario.setFuncionario(AId_funcionario: integer);
begin
   Caption:= 'Editar cadastro';
  with QryFuncionario do
  begin
    Close;
    Sql.Add('where f.id_funcionario = :id_funcionario');
    ParamByName('id_funcionario').AsInteger:= AId_funcionario;
    Open;
    Edit;
  end;
end;

procedure TFrmFuncionario.SpeedButton1Click(Sender: TObject);
begin
 if Application.MessageBox('Deseja salvar as alterações realizadas?', 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
    Dtm.conexao.StartTransaction;
    try
    begin
      QryFuncionario.Post;
      Dtm.conexao.Commit;
    end;
    except
       on E : Exception do
       begin
        Dtm.conexao.Rollback;
        ShowMessage(E.ClassName+' gerou a seguinte mensagem de erro: '+E.Message);
       end;
    end;
    Close;
 end;
end;

procedure TFrmFuncionario.SpeedButton2Click(Sender: TObject);
begin
 if Application.MessageBox('Deseja descartar as alterações realizadas?', 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
   Close;
 end;
end;

end.
