unit UntDependente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmDependentes = class(TForm)
    DBGrid1: TDBGrid;
    sb_editar: TSpeedButton;
    QryDependentes: TFDQuery;
    DscDependetes: TDataSource;
    QryDependentesid_dependente: TIntegerField;
    QryDependentesnome: TWideStringField;
    QryDependentesid_reponsavel: TIntegerField;
    SpeedButton1: TSpeedButton;
    sb_excluir: TSpeedButton;
    sb_exporta: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure sb_excluirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sb_editarClick(Sender: TObject);
    procedure sb_exportaClick(Sender: TObject);
  private
    var
      FResponsavel: integer;
      procedure atualizaerTela;
      function nomeResponsavel: String;
    { Private declarations }
  public
    { Public declarations }
    procedure getDependente(AIdResponsavel: integer);
  end;

var
  FrmDependentes: TFrmDependentes;

implementation

{$R *.dfm}
uses
  UntDtm, UntUtil, UntManDependente;
{ TFrmDependentes }

procedure TFrmDependentes.atualizaerTela;
begin
  if QryDependentes.RecordCount > 0 then
  begin
    sb_editar.Visible:= true;
    sb_excluir.Visible:= true;
    sb_exporta.Visible:= true;
  end
  else
  begin
    sb_editar.Visible:= false;
    sb_excluir.Visible:= false;
    sb_exporta.Visible:= false;
  end;
end;

procedure TFrmDependentes.getDependente(AIdResponsavel: integer);
begin
  FResponsavel:= AIdResponsavel;
  with QryDependentes do
  begin
    Close;
    ParamByName('id_responsavel').AsInteger:= FResponsavel;
    Open;
  end;
  atualizaerTela;
end;

function TFrmDependentes.nomeResponsavel: String;
var
  LQryResponsavel: TFDQuery;
begin
  LQryResponsavel := TFDQuery.Create(nil);
  try
     with LQryResponsavel do
     begin
       Connection:= Dtm.conexao;
       Close;
       Sql.Add('Select nome from funcionarios where id_funcionario = :id_funcionario');
       ParamByName('id_funcionario').AsInteger:= FResponsavel;
       Open;
       Result:= Fields[0].AsString;
     end;
  finally
    LQryResponsavel.Free;
  end;
end;

procedure TFrmDependentes.SpeedButton1Click(Sender: TObject);
begin
   FrmManDependente:= TFrmManDependente.create(nil);
  try
    FrmManDependente.addDependente(FResponsavel);
    FrmManDependente.ShowModal;
  finally
    FrmManDependente.Free;
  end;
  QryDependentes.Refresh;
  atualizaerTela
end;

procedure TFrmDependentes.sb_excluirClick(Sender: TObject);
var
  LMessage: String;
begin
  LMessage:= 'Tem certeza que deseja excluir ' + QryDependentesnome.AsString+ '?';
  if Application.MessageBox(PChar(LMessage), 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
  begin
    TUtil.excluirDependentes(QryDependentesid_dependente.AsInteger);
    QryDependentes.Refresh;
    atualizaerTela;
  end;
end;

procedure TFrmDependentes.sb_exportaClick(Sender: TObject);
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
      QryDependentes.First;
      Writeln(LConteudoArquivo,'+-- Lista de Dependente de: ' + nomeResponsavel + ' --+');
      Writeln(LConteudoArquivo,'----------------------------');
      while not QryDependentes.Eof do
      begin
        Writeln(LConteudoArquivo,'');
        Writeln(LConteudoArquivo, ' Nome: ' + QryDependentesnome.AsString);
        QryDependentes.Next;
      end;
      Writeln(LConteudoArquivo,'----------------------------');
      CloseFile(LConteudoArquivo);
    end;
  end;

end;

procedure TFrmDependentes.sb_editarClick(Sender: TObject);
begin
   FrmManDependente:= TFrmManDependente.create(nil);
  try
    FrmManDependente.setDependente(QryDependentesid_dependente.AsInteger);
    FrmManDependente.ShowModal;
  finally
    FrmManDependente.Free;
  end;
  QryDependentes.Refresh;
  atualizaerTela;
end;

end.
