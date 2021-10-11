object Form1: TForm1
  Left = 219
  Top = 124
  Width = 1000
  Height = 810
  Caption = 'Rubik'#39's Cube'
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 992
    Height = 50
    Align = alTop
    TabOrder = 0
    object Panel1: TPanel
      Left = 10
      Top = 5
      Width = 40
      Height = 41
      Caption = 'X'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel2: TPanel
      Tag = 1
      Left = 59
      Top = 5
      Width = 41
      Height = 41
      Caption = 'U'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel3: TPanel
      Tag = 2
      Left = 108
      Top = 5
      Width = 41
      Height = 41
      Caption = 'F'
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel4: TPanel
      Tag = 3
      Left = 158
      Top = 5
      Width = 40
      Height = 41
      Caption = 'R'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel5: TPanel
      Tag = 4
      Left = 207
      Top = 5
      Width = 40
      Height = 41
      Caption = 'B'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel6: TPanel
      Tag = 5
      Left = 256
      Top = 5
      Width = 41
      Height = 41
      Caption = 'L'
      Color = 33023
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Panel7: TPanel
      Tag = 6
      Left = 305
      Top = 5
      Width = 41
      Height = 41
      Caption = 'D'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = Panel1Click
      OnDblClick = Panel7DblClick
    end
    object Button1: TButton
      Left = 354
      Top = 5
      Width = 208
      Height = 41
      Caption = 'Rechercher la solution'
      TabOrder = 7
      OnClick = Button1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 96
    object Fichier1: TMenuItem
      Caption = 'Fichier'
      object Quitter1: TMenuItem
        Caption = 'Quitter'
        OnClick = Quitter1Click
      end
    end
  end
end
