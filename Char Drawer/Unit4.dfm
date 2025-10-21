object Form4: TForm4
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'New draw'
  ClientHeight = 190
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 244
    Height = 174
    Caption = ' Edit X/Y '
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Area size:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 56
      Width = 13
      Height = 13
      Caption = 'X:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 48
      Top = 88
      Width = 13
      Height = 13
      Caption = 'Y:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 152
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 72
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Cansel'
      TabOrder = 1
      TabStop = False
      OnClick = Button2Click
    end
    object SpinEdit1: TSpinEdit
      Left = 67
      Top = 51
      Width = 121
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 200
      MinValue = 10
      TabOrder = 2
      Value = 25
    end
    object SpinEdit2: TSpinEdit
      Left = 67
      Top = 83
      Width = 121
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 200
      MinValue = 10
      TabOrder = 3
      Value = 25
    end
  end
end
