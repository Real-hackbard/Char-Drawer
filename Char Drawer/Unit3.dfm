object Form3: TForm3
  Left = 1687
  Top = 220
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 183
  ClientWidth = 222
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    222
    183)
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 117
    Height = 24
    Caption = 'Char Drawer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 26
    Top = 55
    Width = 78
    Height = 13
    Caption = 'Type your Name'
  end
  object Button1: TButton
    Left = 125
    Top = 145
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
    ExplicitLeft = 119
    ExplicitTop = 137
  end
end
