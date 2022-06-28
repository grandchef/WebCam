unit UMain;

interface

{$DEFINE USEPNG}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Videocap, VideoDisp, XPMan, Buttons
  {$IFDEF USEPNG}, PNGImage {$ENDIF}, ExtDlgs;

type
  TForm1 = class(TForm)
    VideoCap1: TVideoCap;
    Panel1: TPanel;
    BtnCap: TButton;
    XPManifest1: TXPManifest;
    GroupBox1: TGroupBox;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    BtnSal: TButton;
    procedure BtnCapClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnCapClick(Sender: TObject);
var
  bmp: TBitmap;
  wDC: HDC;
begin
  if BtnCap.Caption = 'Iniciar' then
  begin
    VideoCap1.VideoPreview := true;
    BtnCap.Caption := 'Capturar';
  end
  else
  begin
    VideoCap1.VideoPreview := False;
    BtnCap.Caption := 'Iniciar';
    bmp := TBitmap.Create;
    bmp.Height := Image1.Height;
    bmp.Width := Image1.Width;
    wDc := GetWindowDC(VideoCap1.Handle);
    BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, wDC, 35, 0, SRCCOPY);
    ReleaseDC(VideoCap1.Handle, wDC);
    Image1.Picture.Bitmap := bmp;
    bmp.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
  sl: TStringList;
begin
  sl := GetDriverList;
  ComboBox1.Items.Assign(sl);
  if sl.Count > 0 then
  begin
    BtnCap.Enabled := true;
    VideoCap1.DriverIndex := 0;
    ComboBox1.ItemIndex := 0;
  end;
  sl.Free;
  bmp:= TBitmap.Create;
  bmp.Width := Image1.Width;
  bmp.Height := Image1.Height;
  bmp.Canvas.Brush.Color := Color;
  bmp.Canvas.Brush.Style := bsSolid;
  bmp.Canvas.FillRect(bmp.Canvas.ClipRect);
  bmp.Canvas.TextOut(
    (bmp.Width - bmp.Canvas.TextWidth('(None)')) div 2,
    (bmp. Height - bmp.Canvas.TextHeight('(None)')) div 2,
    '(None)');
  Image1.Picture.Assign(bmp);
  bmp.Free;
end;

procedure TForm1.BtnSalClick(Sender: TObject);
var
  img: {$IFDEF USEPNG} TPNGObject {$ELSE} TBitmap {$ENDIF};
begin
  img := {$IFDEF USEPNG}TPNGObject{$ELSE}TBitmap{$ENDIF}.Create;
  img.Assign(Image1.Picture.Bitmap);
  with TSavePictureDialog.Create(Self) do
  begin
    DefaultExt := {$IFDEF USEPNG}'*.png'{$ELSE}'*.bmp'{$ENDIF};
    Filter := {$IFDEF USEPNG}'Portable Netwok Graphic(*.png)|*.png'
              {$ELSE}'Bitmap file(*.bmp)|*.bmp'{$ENDIF};
    if Execute then
      img.SaveToFile(FileName);
    Free;
  end;
  img.Free;
end;

end.
