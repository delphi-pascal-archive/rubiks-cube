unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin,strutils, UConst, Menus, UDraw, URubik;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Quitter1: TMenuItem;
    Panel8: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Panel7DblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

uses USolution, UOriginal, UVue3D, UMouvement;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
 i:integer;
begin
 DoubleBuffered:=true;
 original:=CubeComplete;
 for i:=0 to 50 do rotateface(TUnitRubik(original),random(6)+1,random(2)*2+1);
 destination:=CubeComplete;
 Cube3D:=CCube3D;
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
 couleurcourante:=tpanel(sender).Tag;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 s:string;
 tmp:tfacerubik;
begin
 FSolution.memo1.Clear;

 if not VerifCube(original,s) then
  begin
   FSolution.memo1.Lines.add('Le cube à été démonté ou trafiqué :');
   FSolution.memo1.Lines.add(s);
   exit;
  end;

 solu:='';
 tmp:=original;

 // rang 1
 placeCotesBlancs(tmp);
    FSolution.memo1.Lines.Add('---> placeCotesBlancs');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=solu;solu:='';
 placeAnglesBlancs(tmp);
    FSolution.memo1.Lines.Add('---> placeAnglesBlancs');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';
 // rang 2
 placeCotesRang2(tmp);
    FSolution.memo1.Lines.Add('---> placeCotesRang2');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';
 // rang 3
 PlaceCotesJaunes(tmp);
    FSolution.memo1.Lines.Add('---> PlaceCotesJaunes');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';

 OrienteCotesJaunes(tmp);
    FSolution.memo1.Lines.Add('---> OrienteCotesJaunes');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';
 PlaceCoinsJaunes(tmp);
    FSolution.memo1.Lines.Add('---> PlaceCoinsJaunes');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';
 OrienteCoinsJaunes(tmp);
    FSolution.memo1.Lines.Add('---> OrienteCoinsJaunes');
    FSolution.memo1.Lines.Add(AnsiReplaceText(solu,'/',#13#10));s:=s+solu;solu:='';

 FSolution.caption:='mouvements '+inttostr(CompteMouvements(s));
 filtre(s,original,FSolution.image1.canvas);
 foriginal.PaintBox1.Refresh;
 FSolution.caption:=FSolution.caption+' (mouvements après filtre '+inttostr(CompteMouvements(s))+')';
 FSolution.memo1.Lines.Add('');
 FSolution.memo1.Lines.Add('---> Filtre');
 FSolution.memo1.Lines.Add(s);
 fmouvement.edit1.text:=s;
end;


procedure TForm1.Quitter1Click(Sender: TObject);
begin
 close;
end;

procedure TForm1.Panel7DblClick(Sender: TObject);
begin
 couleurcourante:=tpanel(sender).Tag;
end;

end.
