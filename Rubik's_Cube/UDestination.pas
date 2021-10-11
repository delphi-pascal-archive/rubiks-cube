unit UDestination;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,UConst,UDraw,URubik;

type
  TFDestination = class(TForm)
    Button3: TButton;
    Button25: TButton;
    PaintBox2: TPaintBox;
    procedure PaintBox2Paint(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button25Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FDestination: TFDestination;

implementation

uses UVue3D;

{$R *.dfm}

procedure TFDestination.PaintBox2Paint(Sender: TObject);
begin
 DrawCube(PaintBox2,destination);
end;

procedure TFDestination.Button3Click(Sender: TObject);
begin
 destination:=CubeComplete;
 DrawCube(PaintBox2,destination);
 FVue3D.paintbox3.Refresh;
end;

procedure TFDestination.PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if  not (ssLeft in Shift) then exit;
 PlaceCouleur(destination,point(x,y));
 DrawCube(PaintBox2,destination);
 FVue3D.paintbox3.Refresh;
end;

procedure TFDestination.PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 PlaceCouleur(destination,point(x,y));
 DrawCube(PaintBox2,destination);
 FVue3D.paintbox3.Refresh;
end;

procedure TFDestination.Button25Click(Sender: TObject);
var
 i:integer;
begin
 destination:=CubeComplete;
 for i:=0 to 50 do rotateface(TUnitRubik(destination),random(6)+1,random(3)+1);
 DrawCube(PaintBox2,destination);
end;

end.
