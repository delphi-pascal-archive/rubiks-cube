object FOriginal: TFOriginal
  Left = 445
  Top = 123
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Original'
  ClientHeight = 313
  ClientWidth = 372
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
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 40
    Width = 360
    Height = 270
    Color = clAppWorkSpace
    ParentColor = False
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnPaint = PaintBox1Paint
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 49
    Height = 25
    Caption = 'RAZ'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button24: TButton
    Left = 64
    Top = 8
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 1
    OnClick = Button24Click
  end
end
