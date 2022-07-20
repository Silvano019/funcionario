unit UntMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
 uses
   untDtm;
procedure TForm1.FormShow(Sender: TObject);
begin
  with QryDados do
  begin
    Close;
    Open;
  end;

end;

end.
