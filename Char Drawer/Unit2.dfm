object Form2: TForm2
  Left = 457
  Top = 108
  Caption = 'Preview'
  ClientHeight = 363
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    411
    363)
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 18
    Width = 390
    Height = 285
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Terminal'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitWidth = 386
    ExplicitHeight = 284
  end
  object Button1: TButton
    Left = 313
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
    ExplicitLeft = 309
    ExplicitTop = 318
  end
end
