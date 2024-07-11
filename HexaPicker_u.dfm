object frmHexaPicker: TfrmHexaPicker
  Left = 0
  Top = 0
  Caption = 'Hexadecimal color picker'
  ClientHeight = 144
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object shpColorshowcase: TShape
    Left = 232
    Top = 16
    Width = 97
    Height = 97
    Cursor = crHandPoint
    Shape = stCircle
    OnMouseDown = shpColorshowcaseMouseDown
  end
  object lblHash: TLabel
    Left = 22
    Top = 40
    Width = 12
    Height = 30
    Caption = '#'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtColorInput: TEdit
    Left = 40
    Top = 40
    Width = 161
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'edtColorInput'
    OnChange = edtColorInputChange
  end
  object bmbConfirmcolor: TBitBtn
    Left = 40
    Top = 104
    Width = 75
    Height = 25
    Caption = 'bmbConfirmcolor'
    TabOrder = 1
    OnClick = bmbConfirmcolorClick
  end
end
