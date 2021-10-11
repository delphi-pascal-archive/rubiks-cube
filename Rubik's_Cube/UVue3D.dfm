object FVue3D: TFVue3D
  Left = 261
  Top = 96
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Vue 3D'
  ClientHeight = 272
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox3: TPaintBox
    Left = 8
    Top = 32
    Width = 200
    Height = 200
    OnMouseDown = PaintBox3MouseDown
    OnMouseMove = PaintBox3MouseMove
    OnPaint = PaintBox3Paint
  end
  object Label1: TLabel
    Left = 8
    Top = 240
    Width = 196
    Height = 13
    Caption = 'Clic Gauche => Rotation autour de X et Y'
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 158
    Height = 13
    Caption = 'Clic Droit => Rotation autour de Z'
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 8
    Width = 89
    Height = 17
    Caption = 'Original'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 112
    Top = 8
    Width = 89
    Height = 17
    Caption = 'Destination'
    TabOrder = 1
    OnClick = RadioButton1Click
  end
end
