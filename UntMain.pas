unit UntMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    DbgDados: TDBGrid;
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
    sb_exportar_todos: TSpeedButton;
    sb_editar: TSpeedButton;
    sb_exporta_todos: TSpeedButton;
    sb_exportar_selecionado: TSpeedButton;
    sb_sorteador: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sb_adicionarClick(Sender: TObject);
    procedure sb_excluirClick(Sender: TObject);
    procedure sb_exportar_todosClick(Sender: TObject);
    procedure sb_exporta_todosClick(Sender: TObject);
    procedure sb_exportar_selecionadoClick(Sender: TObject);
    procedure sb_sorteadorClick(Sender: TObject);
  private
    function maiorIdFuncionario: Integer;
    function validarGanhador(AIdGanhador: integer): String;
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

function TFrmMain.maiorIdFuncionario: Integer;
var
  LMaiorId: integer;
begin
  LMaiorId:= 0;
  with QryDados do
  begin
    First;
    while not eof do
    begin
      if fieldByName('id_funcionario').asinteger > LMaiorId then
      begin
        LMaiorId:= fieldByName('id_funcionario').asinteger;
      end;
      Next;
    end;
  end;
  Result:= LMaiorId;
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
 if Application.MessageBox(PChar('Tem certeza que deseja excluir ' + QryDadosnome.AsString+ '?'), 'Alerta',MB_ICONQUESTION + MB_YESNO + MB_SYSTEMMODAL) = mrYes then
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

procedure TFrmMain.sb_exportar_todosClick(Sender: TObject);
begin
   FrmDependentes:= TFrmDependentes.create(nil);
  try
    FrmDependentes.getDependente(QryDadosid_funcionario.AsInteger);
    FrmDependentes.ShowModal;
  finally
    FrmFuncionario.Free;
  end;
end;

procedure TFrmMain.sb_exportar_selecionadoClick(Sender: TObject);
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

procedure TFrmMain.sb_exporta_todosClick(Sender: TObject);
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

procedure TFrmMain.sb_sorteadorClick(Sender: TObject);
var
  LIdGanhador: integer;
  LNomeGanhador: string;
  LSortear: Boolean;
begin
  Randomize;
  LSortear:= True;
  while LSortear do
  begin
    LIdGanhador:= Random(maiorIdFuncionario+1);
    LNomeGanhador:= validarGanhador(LIdGanhador);
    if LNomeGanhador <> '' then
    begin
     showmessage('Sorteado foi: ' + LNomeGanhador);
     LSortear:= False;
    end;
  end;
end;

function TFrmMain.validarGanhador(AIdGanhador: integer): String;
begin
  Result:='';
  with QryDados do
  begin
  First;
    while not eof do
    begin
      if fieldByName('id_funcionario').asinteger = AIdGanhador then
      begin
        Result:= fieldByName('nome').asstring;
      end;
      Next;
    end;
  end;
end;

end.
