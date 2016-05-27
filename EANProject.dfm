object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'EAN'
  ClientHeight = 564
  ClientWidth = 460
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
    Left = 324
    Top = 375
    Width = 67
    Height = 33
    Caption = 'Quit'
    TabOrder = 0
    OnClick = bQuitClick
  end
  object rbArithmeticGroup: TRadioGroup
    Left = 96
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
    Left = 96
    Top = 8
    Width = 263
    Height = 105
    TabOrder = 2
    object labAlpha: TLabel
      Left = 16
      Top = 17
      Width = 31
      Height = 13
      Caption = 'Alpha:'
    end
    object labBeta: TLabel
      Left = 141
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
      OnKeyPress = edAlphaBethaKeyPress
    end
    object edBeta: TEdit
      Left = 173
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 1
      OnKeyPress = edAlphaBethaKeyPress
    end
    object edMaxIter: TEdit
      Left = 173
      Top = 36
      Width = 57
      Height = 21
      TabOrder = 2
      OnKeyPress = edMaxIterKeyPress
    end
    object edEpsilon: TEdit
      Left = 59
      Top = 52
      Width = 32
      Height = 21
      TabOrder = 3
    end
    object edN: TEdit
      Left = 109
      Top = 76
      Width = 54
      Height = 21
      TabOrder = 4
      Text = '0'
      OnKeyPress = edMaxIterKeyPress
      OnKeyUp = edNKeyUp
    end
    object edEpsilon2: TEdit
      Left = 109
      Top = 52
      Width = 28
      Height = 21
      TabOrder = 5
    end
    object edAlpha2: TEdit
      Left = 90
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 6
    end
    object edBeta2: TEdit
      Left = 210
      Top = 13
      Width = 31
      Height = 21
      TabOrder = 7
    end
  end
  object panelResult: TPanel
    Left = 16
    Top = 414
    Width = 436
    Height = 138
    TabOrder = 3
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
      Left = 39
      Top = 108
      Width = 3
      Height = 13
    end
  end
  object bRun: TButton
    Left = 55
    Top = 375
    Width = 69
    Height = 33
    Caption = 'Run'
    TabOrder = 4
    OnClick = bRunClick
  end
  object Data: TStringGrid
    Left = 124
    Top = 199
    Width = 201
    Height = 163
    ColCount = 2
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssVertical
    TabOrder = 5
    ColWidths = (
      64
      64)
    RowHeights = (
      24
      24)
  end
  object bClear: TButton
    Left = 188
    Top = 376
    Width = 75
    Height = 32
    Caption = 'Clear'
    TabOrder = 6
    OnClick = bClearClick
  end
  object rbIntervalGroup: TRadioGroup
    Left = 240
    Top = 119
    Width = 119
    Height = 74
    Caption = 'Interval choice:'
    Items.Strings = (
      'Enter number'
      'Enter range')
    TabOrder = 7
    OnClick = rbIntervalGroupClick
  end
end
