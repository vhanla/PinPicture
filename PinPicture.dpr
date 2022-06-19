program PinPicture;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  Fmx.Types,
  main in 'main.pas' {Form2};

{$R *.res}

begin
//  ReportMemoryLeaksOnShutdown := True;

  GlobalUseHWEffects := true  ;
  GlobalUseDirect2D := False  ;
//  GlobalUseDirect2DSoftware := False    ;
  GlobalUseGDIPlusClearType := True    ;
  GlobalDisableFocusEffect := True   ;

  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
