object Form1: TForm1
  Left = 505
  Top = 297
  BorderStyle = bsDialog
  Caption = 'Webcam'
  ClientHeight = 281
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 234
    Width = 56
    Height = 13
    Caption = 'Dispositivos'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 133
    Height = 209
    Caption = 'Pr'#233'-visualiza'#231#227'o'
    TabOrder = 0
    object Panel1: TPanel
      Left = 8
      Top = 16
      Width = 117
      Height = 155
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 0
      object VideoCap1: TVideoCap
        Left = -35
        Top = 0
        Width = 201
        Height = 151
        color = clBlack
        DriverOpen = False
        DriverIndex = -1
        VideoOverlay = False
        VideoPreview = False
        PreviewScaleToWindow = True
        PreviewScaleProportional = True
        PreviewRate = 30
        MicroSecPerFrame = 66667
        FrameRate = 15
        CapAudio = False
        VideoFileName = 'Video.avi'
        SingleImageFile = 'Capture.bmp'
        CapTimeLimit = 0
        CapIndexSize = 0
        CapToFile = False
        BufferFileSize = 0
      end
    end
    object BtnCap: TButton
      Left = 16
      Top = 176
      Width = 99
      Height = 25
      Caption = 'Iniciar'
      Enabled = False
      TabOrder = 1
      OnClick = BtnCapClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 152
    Top = 8
    Width = 132
    Height = 209
    Caption = 'Capturado'
    TabOrder = 1
    object Panel2: TPanel
      Left = 8
      Top = 16
      Width = 117
      Height = 155
      AutoSize = True
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 0
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 113
        Height = 151
        Center = True
      end
    end
    object BtnSal: TButton
      Left = 16
      Top = 176
      Width = 99
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = BtnSalClick
    end
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 252
    Width = 273
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object XPManifest1: TXPManifest
    Left = 136
    Top = 224
  end
end
