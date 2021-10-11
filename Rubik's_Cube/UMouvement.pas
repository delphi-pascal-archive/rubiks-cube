unit UMouvement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,UConst,UDraw,URubik, Spin;

type
  TFMouvement = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Button9: TButton;
    Button8: TButton;
    Button7: TButton;
    Button6: TButton;
    Button26: TButton;
    Button17: TButton;
    Button16: TButton;
    Button15: TButton;
    Button14: TButton;
    Button13: TButton;
    Button12: TButton;
    Button11: TButton;
    Button10: TButton;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    procedure Button9Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FMouvement: TFMouvement;

implementation

uses UOriginal, UVue3D;

{$R *.dfm}

procedure TFMouvement.Button9Click(Sender: TObject);
var
 n:integer;
 tmp:tcube3d;
 i,v:integer;
begin
 n:=tbutton(sender).Tag;
 FVue3d.radiobutton1.Checked:=true;
 v:=spinedit1.Value;

   // animation 3D

 tmp:=cube3d;
 for i:=0 to 90 do
  begin
   Rotate3dface(cube3d,n mod 10+1,(((n div 10)*2-1)*i)*pi/180);
   FVue3D.paintbox3.Refresh;
   sleep(50-v*5);
   cube3d:=tmp;
  end;


 Rotateface(TUnitRubik(original),n mod 10+1,(n div 10)*2+1);
 DrawCube(FOriginal.PaintBox1,original);
 FVue3D.paintbox3.Refresh;
end;

var
 IsRunning:boolean=false;

procedure TFMouvement.Button26Click(Sender: TObject);
var
 f,i,ii,j,v:integer;
 s:string;
 tmp:tcube3d;
begin
 if IsRunning then
  begin
   Button26.caption:='Faire les mouvements';
   IsRunning:=false;
   exit;
  end;
 IsRunning:=true;
 Button26.caption:='Stopper les mouvements';
 FVue3d.radiobutton1.Checked:=true;
 s:=ansiuppercase(edit1.Text);
 i:=1;
 v:=spinedit1.Value;

 while i<=length(s) do
  begin
   application.ProcessMessages;
   if not IsRunning then exit;
   j:=1;
   if (i<length(s)) and (s[i+1]='''') then j:=3;
   if (i<length(s)) and (s[i+1]='²') then j:=2;
   case s[i] of
    'L':f:=Gauche;
    'R':f:=Droite;
    'B':f:=Arriere;
    'F':f:=Avant;
    'U':f:=Haut;
    'D':f:=Bas;
   else
    if j>1 then inc(i,2) else inc(i);
    continue;
   end;

   // animation 3D
     tmp:=cube3d;
     for ii:=0 to 90 do
      begin
       if not IsRunning then break;
       if v<5 then application.ProcessMessages;
       case j of
        1: Rotate3dface(cube3d,f,-ii*pi/180);
        2: Rotate3dface(cube3d,f,-ii*pi/90);
        3: Rotate3dface(cube3d,f,ii*pi/180);
       end;
       DrawCube3d(FVue3D.paintbox3,original,cube3d);
       sleep(50-v*5);
       cube3d:=tmp;
      end;

   RotateFace(TUnitRubik(original),f,j);
   DrawCube3d(FVue3D.paintbox3,original,cube3d);
   DrawCube(FOriginal.PaintBox1,original);
   if j>1 then inc(i,2) else inc(i);
  end;
 IsRunning:=false;
 Button26.caption:='Faire les mouvements';
end;

end.
