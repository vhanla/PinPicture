{
  TODO:
  - Effects consume a lot of memory, so it is disabled
}
unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, DragDrop,
  DropTarget, DragDropText, FMX.Layouts, FMX.ExtCtrls, FMX.Objects,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, Skia, Skia.FMX,
  FMX.Viewport3D, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Colors,
  FMX.Effects, FMX.Filter.Effects, FMX.ImageLayout;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Viewport3D1: TViewport3D;
    Layer3D1: TLayer3D;
    StyleBook1: TStyleBook;
    raDragArea: TRectangle;
    SpeedButton1: TSpeedButton;
    raSettings: TRectangle;
    raResizeArea: TRectangle;
    AlphaTrackBar1: TAlphaTrackBar;
    BWTrackBar1: TBWTrackBar;
    HueTrackBar1: THueTrackBar;
    HueAdjustEffect1: THueAdjustEffect;
    ToonEffect1: TToonEffect;
    BlurEffect1: TBlurEffect;
    ContrastEffect1: TContrastEffect;
    BWTrackBar2: TBWTrackBar;
    tbRAngleX: TTrackBar;
    tbRAngleY: TTrackBar;
    tbRAngleZ: TTrackBar;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    OpenDialog1: TOpenDialog;
    PaintBox1: TPaintBox;
    ImageLayout1: TImageLayout;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    CalloutRectangle1: TCalloutRectangle;
    Label1: TLabel;
    Label2: TLabel;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SkSvg1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure SkAnimatedImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure raDragAreaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure raResizeAreaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure HueTrackBar1Change(Sender: TObject);
    procedure AlphaTrackBar1Change(Sender: TObject);
    procedure BWTrackBar1Change(Sender: TObject);
    procedure BWTrackBar2Change(Sender: TObject);
    procedure BWTrackBar1DblClick(Sender: TObject);
    procedure HueTrackBar1DblClick(Sender: TObject);
    procedure BWTrackBar2DblClick(Sender: TObject);
    procedure AlphaTrackBar1DblClick(Sender: TObject);
    procedure tbRAngleXChange(Sender: TObject);
    procedure tbRAngleYChange(Sender: TObject);
    procedure tbRAngleZChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure raDragAreaMouseEnter(Sender: TObject);
    procedure raDragAreaMouseLeave(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure ImageLayout1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageLayout1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure tbRAngleXDblClick(Sender: TObject);
    procedure tbRAngleYDblClick(Sender: TObject);
    procedure tbRAngleZDblClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
    PrevWheelDelta: Extended;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses
  FMX.Platform.Win, Winapi.Messages, Winapi.Windows;

procedure TForm2.AlphaTrackBar1Change(Sender: TObject);
begin
//  Image1.Opacity := AlphaTrackBar1.Value/100;
  ImageLayout1.Opacity := AlphaTrackBar1.Value/100;
end;

procedure TForm2.AlphaTrackBar1DblClick(Sender: TObject);
begin
  AlphaTrackBar1.Value := 100;
end;

procedure TForm2.BWTrackBar1Change(Sender: TObject);
begin
  ContrastEffect1.Contrast := BWTrackBar1.Value / 100;
end;

procedure TForm2.BWTrackBar1DblClick(Sender: TObject);
begin
  BWTrackBar1.Value := 100;
end;

procedure TForm2.BWTrackBar2Change(Sender: TObject);
begin
  ContrastEffect1.Brightness := BWTrackBar2.Value / 100;
end;

procedure TForm2.BWTrackBar2DblClick(Sender: TObject);
begin
  BWTrackBar2.Value := 0;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  SpeedButton1.Opacity := 1;
  SpeedButton2.Opacity := 1;
  SpeedButton3.Opacity := 1;
  SpeedButton4.Opacity := 1;
  SpeedButton5.Opacity := 1;
  SpeedButton6.Opacity := 1;
  AlphaTrackBar1.Opacity := 1;
  raSettings.Opacity := 1;
  tbRAngleX.Opacity := 1;
  tbRAngleY.Opacity := 1;
  tbRAngleZ.Opacity := 1;
  raResizeArea.Opacity := 1;
  raDragArea.Opacity := 1;
  SetWindowLong(FmxHandleToHWND(Handle), GWL_EXSTYLE, GetWindowLong(FmxHandleToHWND(Handle), GWL_EXSTYLE) and not WS_EX_TRANSPARENT);

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//  FormStyle := TFormStyle.StayOnTop;

end;

procedure TForm2.HueTrackBar1Change(Sender: TObject);
begin
  HueAdjustEffect1.Hue := HueTrackBar1.Value / 100;
end;

procedure TForm2.HueTrackBar1DblClick(Sender: TObject);
begin
  HueTrackBar1.Value := 0;
end;

procedure TForm2.Image1DblClick(Sender: TObject);
begin
  raDragArea.Visible := not raDragArea.Visible;
  raResizeArea.Visible := not raResizeArea.Visible;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm2.Image1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
var
  zoom_center: TPointF;
  new_scale, old_scale: Single;
begin

{  zoom_center := Image1.Position.Point + PointF(Image1.Width / 2, Image1.Height / 2);

  if WheelDelta >= 0 then
  begin
    Image1.Width := Image1.Width + (WheelDelta);
    Image1.Height := Image1.Height + (WheelDelta);
  end
  else
  begin
    Image1.Width := Image1.Width - (WheelDelta);
    Image1.Height := Image1.Height - (WheelDelta);

  end;


  Image1.Position.X := zoom_center.X - Image1.Width / 2;
  Image1.Position.Y := zoom_center.Y - Image1.Height / 2;
  Exit;}
 if ssCtrl in Shift then
 begin
  zoom_center := ScreenToClient(Screen.MousePos) -  PaintBox1.Position.Point;

  old_scale := Image1.Scale.X;
  if WheelDelta >= 0 then
    new_scale := old_scale * (1 + (WheelDelta / 120) /5)
  else
    new_scale := old_scale / (1 - (WheelDelta / 120) /5);

  Image1.Scale.X := new_scale;
  Image1.Scale.Y := new_scale;
  Image1.Position.Point := zoom_center - (new_scale * (zoom_center - Image1.Position.Point) / old_scale);

 end;
end;

procedure TForm2.ImageLayout1DblClick(Sender: TObject);
begin
  raDragArea.Visible := not raDragArea.Visible;
  raResizeArea.Visible := not raResizeArea.Visible;
end;

procedure TForm2.ImageLayout1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if ssCtrl in Shift then
  begin
    ReleaseCapture;
    PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TForm2.raDragAreaMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm2.raDragAreaMouseEnter(Sender: TObject);
begin
//  raDragArea.Fill.Color := $64E0E0E0;
raDragArea.Fill.Color := $64181818;
end;

procedure TForm2.raDragAreaMouseLeave(Sender: TObject);
begin
  raDragArea.Fill.Color := $51181818;
end;

procedure TForm2.raResizeAreaMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, SC_SIZE or WMSZ_BOTTOMRIGHT, 0);
end;

procedure TForm2.SkAnimatedImage1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm2.SkSvg1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  PostMessage(FmxHandleToHWND(Handle), WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  if FormStyle = TFormStyle.Normal then
  begin
    FormStyle := TFormStyle.StayOnTop;
    SpeedButton1.Text := ''
  end
  else
  begin
    FormStyle := TFormStyle.Normal;
    SpeedButton1.Text := '';
  end;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  raSettings.Visible := not raSettings.Visible;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
  if raDragArea.Align = TAlignLayout.Top then
    raDragArea.Align := TAlignLayout.Bottom
  else
    raDragArea.Align := TAlignLayout.Top;
end;

procedure TForm2.SpeedButton5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
//    Image1.Bitmap.LoadFromFile(OpenDialog1.FileName);
    ImageLayout1.Image.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TForm2.SpeedButton6Click(Sender: TObject);
begin
// transparent all
  SpeedButton1.Opacity := 0;
  SpeedButton2.Opacity := 0;
  SpeedButton3.Opacity := 0;
  SpeedButton4.Opacity := 0;
  SpeedButton5.Opacity := 0;
  SpeedButton6.Opacity := 0;
  AlphaTrackBar1.Opacity := 0;
  raSettings.Opacity := 0;
  tbRAngleX.Opacity := 0;
  tbRAngleY.Opacity := 0;
  tbRAngleZ.Opacity := 0;
  raResizeArea.Opacity := 0;
  raDragArea.Opacity := 0;
  SetWindowLong(FmxHandleToHWND(Handle), GWL_EXSTYLE, GetWindowLong(FmxHandleToHWND(Handle), GWL_EXSTYLE) or WS_EX_TRANSPARENT);
end;

procedure TForm2.SpeedButton7Click(Sender: TObject);
begin
  CalloutRectangle1.Visible := not CalloutRectangle1.Visible;
end;

procedure TForm2.tbRAngleXChange(Sender: TObject);
begin
  Layer3D1.RotationAngle.X := tbRAngleX.Value;
end;

procedure TForm2.tbRAngleXDblClick(Sender: TObject);
begin
  tbRAngleX.Value := 340;
end;

procedure TForm2.tbRAngleYChange(Sender: TObject);
begin
  Layer3D1.RotationAngle.Y := tbRAngleY.Value;
end;

procedure TForm2.tbRAngleYDblClick(Sender: TObject);
begin
  tbRAngleY.Value := 0;
end;

procedure TForm2.tbRAngleZChange(Sender: TObject);
begin
  Layer3D1.RotationAngle.Z := tbRAngleZ.Value;
end;

procedure TForm2.tbRAngleZDblClick(Sender: TObject);
begin
  tbRAngleZ.Value := 0;
end;

end.
