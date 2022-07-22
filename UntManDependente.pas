unit UntManDependente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  TFrmManDependente = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    QryDependente: TFDQuery;
    DscDependentes: TDataSource;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    QryDependentenome: TWideStringField;
    QryDependenteid_reponsavel: TIntegerField;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public
    procedure addDependente(AIdResponsavel: integer);
    procedure setDependente(AIdDependente: integer);
  end;

var
  FrmManDependente: TFrmManDependente;

implementation

{$R *.dfm}
 uses
   UntDtm;
procedure TFrmManDependente.addDependente(AIdResponsavel: integer);
begin
  Caption:= 'Cadastrar';
  with QryDependente do
  begin
    CreateDataSet;
    Insert;
    FieldByName('id_reponsavel').asinteger:= AIdResponsavel;
  end;
end;

procedure TFrmManDependente.setDependente(AIdDependente: integer);
begin
  Caption:= 'Editar cadastro';
  with QryDependente do
  begin
    Close;
    Sql.Add('where id_dependente = :id_dependente');
    ParamByName('id_dependente').AsInteger:= AIdDependente;
    Open;
    Edit;
  end;
end;

procedure TFrmManDependente.SpeedButton1Click(Sender: TObject);
begin
 if Application.MessageBox('Deseja salvar as alterações realizadas?', 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
    Dtm.conexao.StartTransaction;
    try
    begin
      QryDependente.Post;
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

procedure TFrmManDependente.SpeedButton2Click(Sender: TObject);
begin
 if Application.MessageBox('Deseja descartar as alterações realizadas?', 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
 begin
   Close;
 end;
end;

end.
