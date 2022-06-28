unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, Videocap, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZConnection, MySQLBackup, MBkpUtils, PNGImage;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    ImgResg: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    VideoCap1: TVideoCap;
    Button3: TButton;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    Image1: TImage;
    ComboBox1: TComboBox;
    XPManifest1: TXPManifest;
    Button1: TButton;
    Button2: TButton;
    ZConnection1: TZConnection;
    Qry: TZQuery;
    MySQLBackup1: TMySQLBackup;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
  sl: TStringList;
begin
  ZConnection1.Connect;
  sl := GetDriverList;
  ComboBox1.Items.Assign(sl);
  if sl.Count > 0 then
  begin
    Button3.Enabled := true;
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

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp: TBitmap;
  wDC: HDC;
begin
  if Button3.Caption = 'Iniciar' then
  begin
    VideoCap1.VideoPreview := true;
    Button3.Caption := 'Capturar';
  end
  else
  begin
    VideoCap1.VideoPreview := False;
    Button3.Caption := 'Iniciar';
    bmp := TBitmap.Create;
    bmp.Height := Image1.Height;
    bmp.Width := Image1.Width;
    wDc := GetWindowDC(VideoCap1.Handle);
    BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, wDC, 35, 0, SRCCOPY);
    ReleaseDC(VideoCap1.Handle, wDC);
    Image1.Picture.Bitmap := bmp;
    {bmp.SaveToFile('foto.bmp');}
    bmp.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Ms: TMemoryStream;
  png: TPNGObject;
begin
  Ms := TMemoryStream.Create;
  png := TPNGObject.Create;
  png.Assign(Image1.Picture.Bitmap);
  png.SaveToStream(Ms);
  png.Free;
  Ms.Position := 0;
  Qry.SQL.Text := 'INSERT INTO img (data) VALUES (0x' + StreamToString(Ms) + ')';
  Qry.ExecSQL;
  Ms.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  MySQLBackup1.StartBackup;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  MySQLBackup1.StartRestore;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Ms: TMemoryStream;
  png: TPNGObject;
begin
  Qry.SQL.Text := 'SELECT Data FROM img WHERE ID = ' + Edit1.Text;
  Qry.Open;
  if Qry.RecordCount = 1 then
  begin
    Ms := TMemoryStream.Create;
    TBlobField(Qry.FieldByName('Data')).SaveToStream(Ms);
    Ms.Position := 0;
    png := TPNGObject.Create;
    png.LoadFromStream(Ms);
    Ms.Free;
    ImgResg.Picture.Assign(png);
    png.Free;
  end
  else
    MessageBox(Handle, 'Não encontrou!', 'test', MB_ICONINFORMATION);
  Qry.Close;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  ImgResg.Picture.SaveToFile('test.png');
end;

end.
