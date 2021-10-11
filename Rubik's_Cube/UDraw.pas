unit UDraw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin,strutils,UConst, Menus;


procedure Rotate3d(var C:TCube3D;rx,ry,rz:single);
procedure Rotate3dFace(var C:TCube3D;face:integer;rotation:single);
procedure DrawCube3d(P:TPaintBox;c:TRubik;C3D:TCube3D);
procedure DrawCube(P:TPaintBox;c:TRubik);
procedure PlaceCouleur(var cube:TRubik;pt:tpoint);



var
  original:TRubik;
  destination:TRubik;
  CouleurCourante:integer=0;
  Cube3D:TCube3D;
  axeX:T3dPoint=(-1,0,0);
  axeY:T3dPoint=(0,-1,0);
  axeZ:T3dPoint=(0,0,-1);



implementation


procedure PlaceCouleur(var cube:TRubik;pt:tpoint);
var
 i,j:integer;
begin
 for i:=1 to 6 do for j:=0 to 8 do
 if j<>4 then
    begin
     if PtInRect(Rect(CFacePlace[i,j].x*CCubeSize,CFacePlace[i,j].Y*CCubeSize,
                        CFacePlace[i,j].x*CCubeSize+CCubeSize-3,CFacePlace[i,j].Y*CCubeSize+CCubeSize-3),pt) then
      begin
       cube[i,j]:=couleurcourante;
      end;
    end;
end;




function RotationPoint(p:t3dpoint;vect:t3dpoint;r:single):t3dpoint;
var
 s,u,v,w,x,y,z:single;
 co,si:single;
begin
 u:=vect[0]; v:=vect[1]; w:=vect[2];
 x:=p[0]; y:=p[1]; z:=p[2];
 s:=u*x+v*y+w*z;
 co:=cos(r);
 si:=sin(r);
 result[0]:=(u*s)*(1-co)+x*co+(-w*y+v*z)*si;
 result[1]:=(v*s)*(1-co)+y*co+(+w*x-u*z)*si;
 result[2]:=(w*s)*(1-co)+z*co+(-v*x+u*y)*si;
end;




procedure Rotate3dFace(var C:TCube3D;face:integer;rotation:single);
var
 i,j,k,f,ii,jj:integer;
 tmp:tcube3d;
 axe:t3dpoint;
begin
 case face of
   1:axe:=axey;
   6:axe:=axey;
   2:axe:=axez;
   4:axe:=axez;
   3:axe:=axex;
   5:axe:=axex;
 end;
 for i:=0 to 20 do for j:=0 to 4 do
  begin
   k:=C3dFaceRotation[face,i]*5+j;
   for jj:=1 to 4 do c[k,jj]:=RotationPoint(c[k,jj],axe,rotation);
  end;
end;


procedure Rotate3d(var C:TCube3D;rx,ry,rz:single);
var
 i,j:integer;
 px1,py1,pz1:single;
begin
 axex:=RotationPoint(axex,reperex,rx); axex:=RotationPoint(axex,reperey,ry); axex:=RotationPoint(axex,reperez,rz);
 axey:=RotationPoint(axey,reperex,rx); axey:=RotationPoint(axey,reperey,ry); axey:=RotationPoint(axey,reperez,rz);
 axez:=RotationPoint(axez,reperex,rx); axez:=RotationPoint(axez,reperey,ry); axez:=RotationPoint(axez,reperez,rz);

 for i:=0 to 269 do
  for j:=1 to 4 do
   begin
     c[i,j]:=RotationPoint(c[i,j],reperex,rx);
     c[i,j]:=RotationPoint(c[i,j],reperey,ry);
     c[i,j]:=RotationPoint(c[i,j],reperez,rz);
   end;
end;


procedure DrawCube(P:TPaintBox;c:TRubik);
var
 i,j,k:integer;
 tmp:tbitmap;
begin
 tmp:=tbitmap.Create;
 tmp.Width:=p.Width;
 tmp.Height:=p.Height;
 tmp.Canvas.Brush.color:=clbtnface;
 tmp.canvas.FillRect(p.ClientRect);

 tmp.Canvas.Brush.color:=clAppWorkSpace;
 tmp.Canvas.Rectangle(0*CCubeSize,3*CCubeSize,3*CCubeSize-1,6*CCubeSize-1);
 tmp.Canvas.Rectangle(3*CCubeSize,3*CCubeSize,6*CCubeSize-1,6*CCubeSize-1);
 tmp.Canvas.Rectangle(6*CCubeSize,3*CCubeSize,9*CCubeSize-1,6*CCubeSize-1);
 tmp.Canvas.Rectangle(9*CCubeSize,3*CCubeSize,12*CCubeSize-1,6*CCubeSize-1);

 tmp.Canvas.Rectangle(0*CCubeSize,0*CCubeSize,3*CCubeSize-1,3*CCubeSize-1);
 tmp.Canvas.Rectangle(0*CCubeSize,6*CCubeSize,3*CCubeSize-1,9*CCubeSize-1);
 for i:=1 to 6 do
  for j:=0 to 2 do
   for k:=0 to 2 do
    begin
     tmp.Canvas.Brush.color:=CCouleur[TUnitRubik(c)[i,j,k]];
     tmp.Canvas.Rectangle(CPlace[i,j,k].x*CCubeSize+1,
                        CPlace[i,j,k].Y*CCubeSize+1,
                        CPlace[i,j,k].x*CCubeSize+CCubeSize-2,
                        CPlace[i,j,k].Y*CCubeSize+CCubeSize-2);
    end;
 p.Canvas.Draw(0,0,tmp);
 tmp.Free;
end;



// RENDU 3D RENDU 3D RENDU 3D RENDU 3D RENDU 3D RENDU 3D RENDU 3D RENDU 3D RENDU
type
 T2DArray=array[0..3] of tpoint;
 TPolyOrder=record order:integer;z:single;color:tcolor;pt:T2DArray; end;

function Pt3dTo2D(x,y,z:single;dx,dy:integer):tpoint;
begin
 z:=z+10;
 result.x:=round((x*8/z)*20)+dx;
 result.y:=-round((y*8/z)*20)+dy;
end;

var
 PolyOrder:array[0..269] of TPolyOrder;

procedure DrawCube3d(P:TPaintBox;c:TRubik;C3D:TCube3D);
var
 i,j:integer;
 pt:T2DArray;
 dx,dy:integer;
 ux,uy:single;
 vx,vy:single;
 tmp:tbitmap;
 polytmp:TPolyOrder;
begin
 tmp:=tbitmap.Create;
 tmp.Width:=p.Width;
 tmp.Height:=p.Height;
 tmp.Canvas.Brush.color:=clbtnface;
 tmp.canvas.FillRect(p.ClientRect);
 dx:=tmp.Width div 2;
 dy:=tmp.Height div 2;

 for i:=0 to 269 do
  begin
   PolyOrder[i].order:=-1;
   for j:=0 to 3 do pt[j]:=Pt3dTo2D(C3D[i,j+1,0],C3D[i,j+1,1],C3D[i,j+1,2],dx,dy);
   ux:=pt[0].X-pt[1].X;
   uy:=pt[0].y-pt[1].y;
   vx:=pt[2].X-pt[1].X;
   vy:=pt[2].y-pt[1].y;

   // ne dessine pas les faces arrières
   //if ux*vy-uy*vx>=0 then continue;


   PolyOrder[i].pt:=pt;
   PolyOrder[i].z:=(C3D[i,1,2]+C3D[i,2,2]+C3D[i,3,2]+C3D[i,4,2])/4;
   PolyOrder[i].order:=i;
   if i mod 5=4 then PolyOrder[i].color:=CCouleur[c[(i div 5) div 9+1,((i div 5) mod 9)]]
                else PolyOrder[i].color:=clblack;
   // les faces arrières sont noirs
   if ux*vy-uy*vx>=0 then PolyOrder[i].color:=clblack;
  end;

 // tri des polygones à dessiner par ordre Z
 for i:=0 to 268 do if PolyOrder[i].order<>-1 then
 for j:=i+1 to 269 do if PolyOrder[j].order<>-1 then
  if PolyOrder[j].z>PolyOrder[i].z then
   begin
    polytmp:=PolyOrder[j];
    PolyOrder[j]:=PolyOrder[i];
    PolyOrder[i]:=polytmp;
   end;

 // affichage des polygones
 for i:=0 to 269 do
  if PolyOrder[i].order<>-1 then
   begin
    tmp.canvas.Brush.color:=PolyOrder[i].color;
    tmp.canvas.Polygon(PolyOrder[i].pt);
   end;

 p.Canvas.Draw(0,0,tmp);
 tmp.Free;
end;

end.
