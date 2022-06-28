object Form1: TForm1
  Left = 260
  Top = 202
  Width = 699
  Height = 600
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImgResg: TImage
    Left = 312
    Top = 40
    Width = 113
    Height = 121
    AutoSize = True
  end
  object Edit1: TEdit
    Left = 328
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 273
    Caption = 'Imagem'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 216
      Width = 56
      Height = 13
      Caption = 'Dispositivos'
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 16
      Width = 113
      Height = 177
      Caption = 'Pr'#233'-visualiza'#231#227'o'
      TabOrder = 0
      object Panel1: TPanel
        Left = 8
        Top = 16
        Width = 97
        Height = 121
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        object VideoCap1: TVideoCap
          Left = -35
          Top = 0
          Width = 171
          Height = 128
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
      object Button3: TButton
        Left = 6
        Top = 144
        Width = 99
        Height = 25
        Caption = 'Iniciar'
        Enabled = False
        TabOrder = 1
        OnClick = Button3Click
      end
    end
    object GroupBox3: TGroupBox
      Left = 144
      Top = 16
      Width = 113
      Height = 145
      Caption = 'Capturado'
      TabOrder = 1
      object Panel2: TPanel
        Left = 8
        Top = 16
        Width = 97
        Height = 121
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 93
          Height = 117
          Align = alClient
          Center = True
        end
      end
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 234
      Width = 241
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 328
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 416
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Procurar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 360
    Top = 448
    Width = 75
    Height = 25
    Caption = 'backup'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 448
    Top = 448
    Width = 75
    Height = 25
    Caption = 'restaurar'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 440
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = Button6Click
  end
  object XPManifest1: TXPManifest
    Left = 280
    Top = 32
  end
  object ZConnection1: TZConnection
    Protocol = 'mysql-5'
    HostName = 'localhost'
    Port = 3306
    Database = 'test'
    User = 'root'
    Password = 'Pass45ActMZSW'
    Left = 224
    Top = 328
  end
  object Qry: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 272
    Top = 328
  end
  object MySQLBackup1: TMySQLBackup
    Title = 'test'
    UserName = 'root'
    Password = 'Pass45ActMZSW'
    DataBase = 'test'
    HostName = 'localhost'
    Filter = 'Arquivo de backup(*.bkp)|*.bkp'
    DefaultExt = '*.bkp'
    Left = 336
    Top = 368
  end
end
