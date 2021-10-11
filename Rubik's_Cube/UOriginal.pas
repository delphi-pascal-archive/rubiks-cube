unit UOriginal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,UConst,UDraw,URubik;

type
  TFOriginal = class(TForm)
    Button2: TButton;
    Button24: TButton;
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button24Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FOriginal: TFOriginal;

implementation

uses UVue3D;

{$R *.dfm}

procedure TFOriginal.PaintBox1Paint(Sender: TObject);
begin
 DrawCube(PaintBox1,original);
end;

procedure TFOriginal.Button2Click(Sender: TObject);
begin
 original:=CubeComplete;
 DrawCube(PaintBox1,original);
 FVue3D.paintbox3.Refresh;
end;

procedure TFOriginal.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 PlaceCouleur(original,point(x,y));
 DrawCube(PaintBox1,original);
 FVue3D.paintbox3.Refresh;
end;

procedure TFOriginal.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if  not (ssLeft in Shift) then exit;
 PlaceCouleur(original,point(x,y));
 DrawCube(PaintBox1,original);
 FVue3D.paintbox3.Refresh;
end;

procedure TFOriginal.Button24Click(Sender: TObject);
var
 i:integer;
begin
 original:=CubeComplete;
 for i:=0 to 50 do rotateface(TUnitRubik(original),random(6)+1,random(3)+1);
 DrawCube(FOriginal.PaintBox1,original);
end;

end.
