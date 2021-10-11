unit UVue3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,UConst,UDraw;

type
  TFVue3D = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    PaintBox3: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure PaintBox3Paint(Sender: TObject);
    procedure PaintBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FVue3D: TFVue3D;

implementation

{$R *.dfm}

var
 tmx:integer;
 tmy:integer;

procedure TFVue3D.PaintBox3Paint(Sender: TObject);
begin
 if radiobutton1.Checked then
  DrawCube3d(paintbox3,original,cube3d)
 else
  DrawCube3d(paintbox3,destination,cube3d);
end;


procedure TFVue3D.PaintBox3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 tmx:=x;
 tmy:=y;
end;


procedure TFVue3D.PaintBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if (ssLeft in Shift) then Rotate3d(cube3d,(-y+tmy)*pi/180,(-x+tmx)*pi/180,0)
 else
 if (ssRight in Shift) then Rotate3d(cube3d,0,0,(-x+tmx)*pi/180);

 tmx:=x;
 tmy:=y;

 if radiobutton1.Checked then
  DrawCube3d(paintbox3,original,cube3d)
 else
  DrawCube3d(paintbox3,destination,cube3d);
end;



procedure TFVue3D.RadioButton1Click(Sender: TObject);
begin
 paintbox3.Refresh;
end;

procedure TFVue3D.FormCreate(Sender: TObject);
begin
 DoubleBuffered:=true;
end;

end.
