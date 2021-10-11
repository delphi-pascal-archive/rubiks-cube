object FDestination: TFDestination
  Left = 289
  Top = 485
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Destination'
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
  object PaintBox2: TPaintBox
    Left = 8
    Top = 40
    Width = 360
    Height = 270
    OnMouseDown = PaintBox2MouseDown
    OnMouseMove = PaintBox2MouseMove
    OnPaint = PaintBox2Paint
  end
  object Button3: TButton
    Left = 8
    Top = 8
    Width = 49
    Height = 25
    Caption = 'RAZ'
    TabOrder = 0
    OnClick = Button3Click
  end
  object Button25: TButton
    Left = 64
    Top = 8
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 1
    OnClick = Button25Click
  end
end
