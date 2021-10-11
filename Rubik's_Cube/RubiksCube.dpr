program RubiksCube;

uses
  Forms,
  UMain in 'UMain.pas' {Form1},
  UConst in 'UConst.pas',
  UOriginal in 'UOriginal.pas' {FOriginal},
  UDestination in 'UDestination.pas' {FDestination},
  UVue3D in 'UVue3D.pas' {FVue3D},
  UMouvement in 'UMouvement.pas' {FMouvement},
  USolution in 'USolution.pas' {FSolution},
  UDraw in 'UDraw.pas',
  URubik in 'URubik.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFOriginal, FOriginal);
  FOriginal.Top:=1;     FOriginal.left:=1;
  Application.CreateForm(TFDestination, FDestination);
  FDestination.Top:=1;  FDestination.left:=382;
  Application.CreateForm(TFVue3D, FVue3D);
  FVue3D.Top:=1;        FVue3D.left:=764;

  Application.CreateForm(TFSolution, FSolution);
  FSolution.Top:=342;     FSolution.left:=1;

  Application.CreateForm(TFMouvement, FMouvement);
  FMouvement.Top:=342;    FMouvement.left:=422;

  Application.Run;
end.
