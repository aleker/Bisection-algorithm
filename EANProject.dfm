object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'EAN'
  ClientHeight = 557
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object bQuit: TButton
    Left = 367
    Top = 375
    Width = 67
    Height = 33
    Caption = 'Quit'
    TabOrder = 6
    OnClick = bQuitClick
  end
  object rbArithmeticGroup: TRadioGroup
    Left = 115
    Top = 119
    Width = 117
    Height = 74
    Caption = 'Arithmetic:'
    DoubleBuffered = False
    Items.Strings = (
      'Simple arithmetic'
      'Interval arithmetic')
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnClick = rbArithmeticGroupClick
  end
  object panelData: TPanel
    Left = 69
    Top = 8
    Width = 380
    Height = 105
    TabOrder = 0
    object labAlpha: TLabel
      Left = 16
      Top = 17
      Width = 31
      Height = 13
      Caption = 'Alpha:'
    end
    object labBeta: TLabel
      Left = 245
      Top = 17
      Width = 26
      Height = 13
      Caption = 'Beta:'
    end
    object labMaxIter: TLabel
      Left = 16
      Top = 36
      Width = 151
      Height = 13
      Caption = 'Maximum Number of Iterations:'
    end
    object labEpsilon: TLabel
      Left = 16
      Top = 55
      Width = 37
      Height = 13
      Caption = 'Epsilon:'
    end
    object labN: TLabel
      Left = 16
      Top = 79
      Width = 91
      Height = 13
      Caption = 'Polynomial degree:'
    end
    object labE: TLabel
      Left = 97
      Top = 55
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object edAlpha: TEdit
      Left = 53
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 0
      OnKeyPress = alphaBetaKeyPress
    end
    object edBeta: TEdit
      Left = 277
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 2
      OnKeyPress = alphaBetaKeyPress
    end
    object edMaxIter: TEdit
      Left = 173
      Top = 36
      Width = 44
      Height = 21
      TabOrder = 4
      OnKeyPress = edMaxIterKeyPress
    end
    object edEpsilon: TEdit
      Left = 59
      Top = 52
      Width = 32
      Height = 21
      TabOrder = 5
      OnKeyPress = alphaBetaKeyPress
    end
    object edN: TEdit
      Left = 109
      Top = 76
      Width = 54
      Height = 21
      TabOrder = 7
      Text = '0'
      OnKeyPress = edMaxIterKeyPress
      OnKeyUp = edNKeyUp
    end
    object edEpsilon2: TEdit
      Left = 109
      Top = 52
      Width = 28
      Height = 21
      TabOrder = 6
      OnKeyPress = edEpsilon2KeyPress
    end
    object edAlpha2: TEdit
      Left = 90
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 1
      OnKeyPress = alphaBetaKeyPress
    end
    object edBeta2: TEdit
      Left = 314
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 3
      OnKeyPress = alphaBetaKeyPress
    end
  end
  object panelResult: TPanel
    Left = 8
    Top = 414
    Width = 517
    Height = 131
    TabOrder = 7
    object labAlphaResult: TLabel
      Left = 53
      Top = 13
      Width = 3
      Height = 13
    end
    object labBetaResult: TLabel
      Left = 53
      Top = 32
      Width = 3
      Height = 13
    end
    object labBisection: TLabel
      Left = 16
      Top = 51
      Width = 46
      Height = 13
      Caption = 'Bisection:'
    end
    object labBisectionResult: TLabel
      Left = 68
      Top = 51
      Width = 3
      Height = 13
    end
    object labIterNumber: TLabel
      Left = 16
      Top = 89
      Width = 86
      Height = 13
      Caption = 'Iteration Amount:'
    end
    object labIterResult: TLabel
      Left = 108
      Top = 89
      Width = 3
      Height = 13
    end
    object labNewAlpha: TLabel
      Left = 16
      Top = 13
      Width = 31
      Height = 13
      Caption = 'Alpha:'
    end
    object labNewBeta: TLabel
      Left = 16
      Top = 32
      Width = 26
      Height = 13
      Caption = 'Beta:'
    end
    object labPolynResult: TLabel
      Left = 105
      Top = 70
      Width = 3
      Height = 13
    end
    object labPolynVal: TLabel
      Left = 16
      Top = 70
      Width = 83
      Height = 13
      Caption = 'Polynomial Value:'
    end
    object labSt: TLabel
      Left = 16
      Top = 108
      Width = 14
      Height = 13
      Caption = 'St:'
    end
    object labStResult: TLabel
      Left = 36
      Top = 108
      Width = 3
      Height = 13
    end
    object labAlphaWidth: TLabel
      Left = 382
      Top = 13
      Width = 3
      Height = 13
    end
    object labBetaWidth: TLabel
      Left = 382
      Top = 32
      Width = 3
      Height = 13
    end
    object labBisectionWidth: TLabel
      Left = 382
      Top = 51
      Width = 3
      Height = 13
    end
    object labPolynWidth: TLabel
      Left = 382
      Top = 70
      Width = 3
      Height = 13
    end
  end
  object bRun: TButton
    Left = 91
    Top = 375
    Width = 69
    Height = 33
    Caption = 'Run'
    TabOrder = 4
    OnClick = bRunClick
  end
  object Data: TStringGrid
    Left = 166
    Top = 199
    Width = 201
    Height = 163
    ColCount = 2
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssVertical
    TabOrder = 3
    OnKeyPress = DataKeyPress
    ColWidths = (
      64
      64)
    RowHeights = (
      24
      24)
  end
  object bClear: TButton
    Left = 228
    Top = 376
    Width = 75
    Height = 32
    Caption = 'Clear'
    TabOrder = 5
    OnClick = bClearClick
  end
  object rbIntervalGroup: TRadioGroup
    Left = 295
    Top = 119
    Width = 119
    Height = 74
    Caption = 'Interval choice:'
    Items.Strings = (
      'Enter number'
      'Enter range')
    TabOrder = 2
    OnClick = rbIntervalGroupClick
  end
end
