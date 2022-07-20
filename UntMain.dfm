object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 319
  ClientWidth = 1112
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  DesignSize = (
    1112
    319)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 1096
    Height = 303
    Anchors = [akLeft, akTop, akRight]
    DataSource = DscDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = PopupMenu
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id_funcionario'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'endereco'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cidade'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'estado'
        Width = 100
        Visible = True
      end>
  end
  object PopupMenu: TPopupMenu
    Left = 384
    Top = 112
    object Adicionar1: TMenuItem
      Caption = 'Adicionar'
    end
    object ALterar1: TMenuItem
      Caption = 'Alterar'
    end
  end
  object QryDados: TFDQuery
    Connection = DtmConexao.conexao
    SQL.Strings = (
      'Select * from funcionarios')
    Left = 464
    Top = 112
    object QryDadosid_funcionario: TIntegerField
      DisplayLabel = 'C'#243'digo funcion'#225'rio'
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryDadosnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object QryDadosendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 60
    end
    object QryDadoscidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 60
    end
    object QryDadosestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Origin = 'estado'
      Size = 2
    end
    object QryDadosativo: TWideStringField
      FieldName = 'ativo'
      Origin = 'ativo'
      Visible = False
      Size = 3
    end
  end
  object DscDados: TDataSource
    DataSet = QryDados
    Left = 544
    Top = 120
  end
end
