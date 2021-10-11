unit URubik;

interface

uses UConst,UDraw,SysUtils,StrUtils,graphics;

procedure RotateFace(var cube:TUnitRubik;face,rotation:integer);
procedure AppliqueFormule(var cube:TRubik;s:string);
function trouveCote(cube:TFaceRubik;c:integer;sens:byte=0):integer;
function trouveAngle(cube:TFaceRubik;a:integer):integer;
procedure placeCotesBlancs(var cube:TRubik);
procedure placeAnglesBlancs(var cube:TRubik);
procedure placeCotesRang2(var cube:TRubik);
procedure PlaceCotesJaunes(var cube:TRubik);
procedure OrienteCotesJaunes(var cube:TRubik);
procedure PlaceCoinsJaunes(var cube:TRubik);
procedure OrienteCoinsJaunes(var cube:TRubik);
function filtre(var s:string;cube:TFaceRubik;can:tcanvas):string;
function CompteMouvements(s:string):integer;
function VerifCube(original:TFaceRubik;var s:string):boolean;


var
 solu:string='';

implementation


function CompteMouvements(s:string):integer;
var
 i,j:integer;
begin
 result:=0;
 s:=ansiuppercase(s);
 i:=1;
 while i<=length(s) do
  begin
   j:=1;
   if (i<length(s)) and (s[i+1]='''') then j:=3;
   if (i<length(s)) and (s[i+1]='²') then j:=2;
   case s[i] of
    'L',    'R',    'B',    'F',    'U',    'D':inc(result);
   end;
   if j>1 then inc(i,2) else inc(i);
  end;
end;


function MemeCubes(c1,c2:TRubik):boolean;
var
 i:integer;
begin
 result:=false;
 for i:=0 to 53 do if TLinRubik(c1)[i]<>TLinRubik(c2)[i] then exit;
 result:=true;
end;



procedure RotateFace(var cube:TUnitRubik;face,rotation:integer);
var
 i,j,k:integer;
 tmp:TUnitRubik;
begin

 if rotation=0 then exit;
 if rotation>1 then RotateFace(cube,face,rotation-1);
 tmp:=cube;
 case face of
 Haut   : // face  blanche
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[1,j,i]:=cube[1,2-i,j];
   for i:=0 to 2 do tmp[2,0,i]:=cube[3,0,i];
   for i:=0 to 2 do tmp[3,0,i]:=cube[4,0,i];
   for i:=0 to 2 do tmp[4,0,i]:=cube[5,0,i];
   for i:=0 to 2 do tmp[5,0,i]:=cube[2,0,i];
  end;
 Bas    : // face  jaune
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[6,j,i]:=cube[6,i,2-j];
   for i:=0 to 2 do tmp[2,2,i]:=cube[3,2,i];
   for i:=0 to 2 do tmp[3,2,i]:=cube[4,2,i];
   for i:=0 to 2 do tmp[4,2,i]:=cube[5,2,i];
   for i:=0 to 2 do tmp[5,2,i]:=cube[2,2,i];
  end;
 Gauche : // face  orange
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[5,j,i]:=cube[5,i,2-j];
   for i:=0 to 2 do tmp[1,i,0]:=cube[2,i,0];
   for i:=0 to 2 do tmp[2,i,0]:=cube[6,i,0];
   for i:=0 to 2 do tmp[6,i,0]:=cube[4,2-i,2];
   for i:=0 to 2 do tmp[4,2-i,2]:=cube[1,i,0];
  end;
 Droite : // face 4 rouge
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[3,j,i]:=cube[3,2-i,j];
   for i:=0 to 2 do tmp[1,i,2]:=cube[2,i,2];
   for i:=0 to 2 do tmp[2,i,2]:=cube[6,i,2];
   for i:=0 to 2 do tmp[6,i,2]:=cube[4,2-i,0];
   for i:=0 to 2 do tmp[4,2-i,0]:=cube[1,i,2];
  end;
 Avant  : // face 3 vert
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[2,j,i]:=cube[2,i,2-j];
   for i:=0 to 2 do tmp[1,2,i]:=cube[3,i,0];
   for i:=0 to 2 do tmp[3,i,0]:=cube[6,0,2-i];
   for i:=0 to 2 do tmp[6,0,2-i]:=cube[5,2-i,2];
   for i:=0 to 2 do tmp[5,2-i,2]:=cube[1,2,i];
  end;
 Arriere: // face 1 bleu
  begin
   for j:=0 to 2 do for i:=0 to 2 do tmp[4,j,i]:=cube[4,2-i,j];
   for i:=0 to 2 do tmp[1,0,i]:=cube[3,i,2];
   for i:=0 to 2 do tmp[3,i,2]:=cube[6,2,2-i];
   for i:=0 to 2 do tmp[6,2,2-i]:=cube[5,2-i,0];
   for i:=0 to 2 do tmp[5,2-i,0]:=cube[1,0,i];
  end;
 MilieuHori: // entre haut et bas
  begin
   for i:=0 to 2 do tmp[2,1,i]:=cube[3,1,i];
   for i:=0 to 2 do tmp[3,1,i]:=cube[4,1,i];
   for i:=0 to 2 do tmp[4,1,i]:=cube[5,1,i];
   for i:=0 to 2 do tmp[5,1,i]:=cube[2,1,i];
  end;
 MilieuPro : // entre avant et arriere
  begin
   for i:=0 to 2 do tmp[1,1,i]:=cube[3,i,1];
   for i:=0 to 2 do tmp[3,i,1]:=cube[6,1,2-i];
   for i:=0 to 2 do tmp[6,1,2-i]:=cube[5,2-i,1];
   for i:=0 to 2 do tmp[5,2-i,1]:=cube[1,1,i];
  end;
 MilieuVert: // entre gauche et droite
  begin
   for i:=0 to 2 do tmp[1,i,1]:=cube[2,i,1];
   for i:=0 to 2 do tmp[2,i,1]:=cube[6,i,1];
   for i:=0 to 2 do tmp[6,i,1]:=cube[4,2-i,1];
   for i:=0 to 2 do tmp[4,2-i,1]:=cube[1,i,1];
  end;
 end;
 cube:=tmp;
end;



procedure AppliqueFormule(var cube:TRubik;s:string);
var
 i,j:integer;
begin
 s:=ansiuppercase(s);
 solu:=solu+s+'/';
 i:=1;
 while i<=length(s) do
  begin
   j:=1;
   if (i<length(s)) and (s[i+1]='''') then j:=3;
   if (i<length(s)) and (s[i+1]='²') then j:=2;
   case s[i] of
    'L':RotateFace(TUnitRubik(cube),Gauche,j);
    'R':RotateFace(TUnitRubik(cube),Droite,j);
    'B':RotateFace(TUnitRubik(cube),Arriere,j);
    'F':RotateFace(TUnitRubik(cube),Avant,j);
    'U':RotateFace(TUnitRubik(cube),Haut,j);
    'D':RotateFace(TUnitRubik(cube),Bas,j);
   end;
   if j>1 then inc(i,2) else inc(i);
  end;
end;



function RotationCote(cube:TFaceRubik;c,ref:integer):integer;
var
 i:integer;
begin
 result:=0;
 for i:=0 to 23 do if c=CPlaceCote[i,4] then
  begin
   if cube[CPlaceCote[i,0],CPlaceCote[i,1]]=ref then result:=1 else
   if cube[CPlaceCote[i,2],CPlaceCote[i,3]]=ref then result:=2;
  end;
end;

// Recherche du coté c dans cube
function trouveCote(cube:TFaceRubik;c:integer;sens:byte=0):integer;
var
 i:integer;
 c1,c2:integer;
begin
 result:=0;
 case sens of
 0:
 begin
  for i:=0 to 23 do if c=CPlaceCote[i,4] then
   begin
    c1:=destination[CPlaceCote[i,0],CPlaceCote[i,1]];
    c2:=destination[CPlaceCote[i,2],CPlaceCote[i,3]];
   end;

  for i:=0 to 23 do
   if (cube[CPlaceCote[i,0],CPlaceCote[i,1]]= c1) and
      (cube[CPlaceCote[i,2],CPlaceCote[i,3]]= c2)
   then result:=CPlaceCote[i,4];
 end;
 1:
 begin
  for i:=0 to 23 do if c=CPlaceCote[i,4] then
   begin
    c1:=cube[CPlaceCote[i,0],CPlaceCote[i,1]];
    c2:=cube[CPlaceCote[i,2],CPlaceCote[i,3]];
   end;

  for i:=0 to 23 do
   if (destination[CPlaceCote[i,0],CPlaceCote[i,1]]= c1) and
      (destination[CPlaceCote[i,2],CPlaceCote[i,3]]= c2)
   then result:=CPlaceCote[i,4];
 end
 end;
end;

function trouveAngle(cube:TFaceRubik;a:integer):integer;
var
 i:integer;
 c1,c2,c3:integer;
begin
 result:=0;
 for i:=0 to 23 do
  if a=CPlaceAngle[i,6] then
   begin
    c1:=destination[CPlaceAngle[i,0],CPlaceAngle[i,1]];
    c2:=destination[CPlaceAngle[i,2],CPlaceAngle[i,3]];
    c3:=destination[CPlaceAngle[i,4],CPlaceAngle[i,5]];
   end;

 for i:=0 to 23 do
  if (cube[CPlaceAngle[i,0],CPlaceAngle[i,1]]= c1) and
     (cube[CPlaceAngle[i,2],CPlaceAngle[i,3]]= c2) and
     (cube[CPlaceAngle[i,4],CPlaceAngle[i,5]]= c3)
  then result:=CPlaceAngle[i,6];
end;

function VerifCube(original:TFaceRubik;var s:string):boolean;
begin
 result:=false;
 s:='';
 if trouveCote(original,12)=0 then s:=s+'Il manque le côté Blanche/Vert'+#13#10;
 if trouveCote(original,13)=0 then s:=s+'Il manque le côté Blanche/Rouge'+#13#10;
 if trouveCote(original,14)=0 then s:=s+'Il manque le côté Blanche/Bleu'+#13#10;
 if trouveCote(original,15)=0 then s:=s+'Il manque le côté Blanche/Orange'+#13#10;

 if trouveCote(original,23)=0 then s:=s+'Il manque le côté Vert/Rouge'+#13#10;
 if trouveCote(original,34)=0 then s:=s+'Il manque le côté Rouge/Bleu'+#13#10;
 if trouveCote(original,45)=0 then s:=s+'Il manque le côté Bleu/Orange'+#13#10;
 if trouveCote(original,52)=0 then s:=s+'Il manque le côté Orange/Vert'+#13#10;

 if trouveCote(original,62)=0 then s:=s+'Il manque le côté Jaune/Vert'+#13#10;
 if trouveCote(original,63)=0 then s:=s+'Il manque le côté Jaune/Rouge'+#13#10;
 if trouveCote(original,64)=0 then s:=s+'Il manque le côté Jaune/Bleu'+#13#10;
 if trouveCote(original,65)=0 then s:=s+'Il manque le côté Jaune/Orange'+#13#10;

 if trouveAngle(original,123)=0 then s:=s+'Il manque le coin Blanc/Vert/Rouge'+#13#10;
 if trouveAngle(original,134)=0 then s:=s+'Il manque la coin Blanc/Rouge/Bleu'+#13#10;
 if trouveAngle(original,145)=0 then s:=s+'Il manque la coin Blanc/Bleu/Orange'+#13#10;
 if trouveAngle(original,152)=0 then s:=s+'Il manque la coin Blanc/Orange/Vert'+#13#10;

 if trouveAngle(original,632)=0 then s:=s+'Il manque la coin Jaune/Vert/Rouge'+#13#10;
 if trouveAngle(original,643)=0 then s:=s+'Il manque la coin Jaune/Rouge/Bleu'+#13#10;
 if trouveAngle(original,654)=0 then s:=s+'Il manque la coin Jaune/Bleu/Orange'+#13#10;
 if trouveAngle(original,625)=0 then s:=s+'Il manque la coin Jaune/Orange/Vert'+#13#10;

 result:=s='';
end;

// Placements des cotés du centre blanc
procedure placeCotesBlancs(var cube:TRubik);
begin
    // coté blanc/vert
		case trouveCote(cube,12) of
			 12 : ;
			 13 : AppliqueFormule(cube,'U');
			 14 : AppliqueFormule(cube,'U²');
			 15 : AppliqueFormule(cube,'U''');
			 21 : AppliqueFormule(cube,'F''RU');
			 23 : AppliqueFormule(cube,'RU');
			 25 : AppliqueFormule(cube,'LU''');
			 26 : AppliqueFormule(cube,'FRU');
			 31 : AppliqueFormule(cube,'R''F');
			 32 : AppliqueFormule(cube,'F');
			 34 : AppliqueFormule(cube,'BU²');
			 36 : AppliqueFormule(cube,'RF');
			 41 : AppliqueFormule(cube,'UR''F');
			 43 : AppliqueFormule(cube,'R''U');
			 45 : AppliqueFormule(cube,'L''U''');
			 46 : AppliqueFormule(cube,'BR''U');
			 51 : AppliqueFormule(cube,'L''F''');
			 52 : AppliqueFormule(cube,'F''');
			 54 : AppliqueFormule(cube,'B''U²');
			 56 : AppliqueFormule(cube,'LF''');
			 62 : AppliqueFormule(cube,'F²');
			 63 : AppliqueFormule(cube,'DF²');
			 64 : AppliqueFormule(cube,'B²U²');
			 65 : AppliqueFormule(cube,'L²U''');
		end;

		// Placement du coté Blanc/Rouge avec sauvegarde de la position Blanc/Vert
    case trouveCote(cube,13) of
			 13 : ;
			 14 : AppliqueFormule(cube,'FUF''');
			 15 : AppliqueFormule(cube,'FU²F''');
			 23 : AppliqueFormule(cube,'R');
			 25 : AppliqueFormule(cube,'U²LU²');
			 26 : AppliqueFormule(cube,'D''R''U''BU');
			 31 : AppliqueFormule(cube,'RU''BU');
			 32 : AppliqueFormule(cube,'UFU''');
			 34 : AppliqueFormule(cube,'U''BU');
			 36 : AppliqueFormule(cube,'R''U''BU');
			 41 : AppliqueFormule(cube,'B''R''');
			 43 : AppliqueFormule(cube,'R''');
			 45 : AppliqueFormule(cube,'B²R''');
			 46 : AppliqueFormule(cube,'BR''');
			 51 : AppliqueFormule(cube,'L''UF''U''');
			 52 : AppliqueFormule(cube,'UF''U''');
			 54 : AppliqueFormule(cube,'L²UF''U''');
			 56 : AppliqueFormule(cube,'LUF''U''');
			 62 : AppliqueFormule(cube,'D''R²');
			 63 : AppliqueFormule(cube,'R²');
			 64 : AppliqueFormule(cube,'DR²');
			 65 : AppliqueFormule(cube,'D²R²');
			end;

		// Placement du coté Blanc/Bleu avec sauvegarde des positions Blanc/Vert et Blanc/Rouge
		case trouveCote(cube,14) of
			 14 :  ;
			 15 :  AppliqueFormule(cube,'LU''L''U');
			 23 :  AppliqueFormule(cube,'URU''');
			 25 :  AppliqueFormule(cube,'U''LU');
			 26 :  AppliqueFormule(cube,'DL''B''');
			 32 :  AppliqueFormule(cube,'U²FU²');
			 34 :  AppliqueFormule(cube,'B');
			 36 :  AppliqueFormule(cube,'UR''U''B');
			 41 :  AppliqueFormule(cube,'B''UR''U''');
			 43 :  AppliqueFormule(cube,'UR''U''');
			 45 :  AppliqueFormule(cube,'U''L''U');
			 46 :  AppliqueFormule(cube,'BUR''U''');
			 51 :  AppliqueFormule(cube,'LB''');
			 52 :  AppliqueFormule(cube,'L²B''');
			 54 :  AppliqueFormule(cube,'B''');
			 56 :  AppliqueFormule(cube,'L''B''');
			 62 :  AppliqueFormule(cube,'D²B²');
			 63 :  AppliqueFormule(cube,'D''B²');
			 64 :  AppliqueFormule(cube,'B²');
			 65 :  AppliqueFormule(cube,'DB²');
		end;
		
		// Placement du dernier coté Blanc/Orange avec sauvegarde des positions Blanc/Vert, Blanc/Rouge et Blanc/Bleu
		case trouveCote(cube,15) of
			 15 : ;
			 23 :  AppliqueFormule(cube,'U²RU²');
			 25 :  AppliqueFormule(cube,'L');
			 26 :  AppliqueFormule(cube,'U''F''UL');
			 32 :  AppliqueFormule(cube,'U''FU');
			 34 :  AppliqueFormule(cube,'UBU''');
			 36 :  AppliqueFormule(cube,'DU''F''UL');
			 43 :  AppliqueFormule(cube,'U²R''U²');
			 45 :  AppliqueFormule(cube,'L''');
			 46 :  AppliqueFormule(cube,'UB''U''L''');
			 51 :  AppliqueFormule(cube,'L''U''F''U');
			 52 :  AppliqueFormule(cube,'U''F''U');
			 54 :  AppliqueFormule(cube,'UB''U''');
			 56 :  AppliqueFormule(cube,'LU''F''U');
			 62 :  AppliqueFormule(cube,'DL²');
			 63 :  AppliqueFormule(cube,'D²L²');
			 64 :  AppliqueFormule(cube,'D''L²');
			 65 :  AppliqueFormule(cube,'L²');
		end;
end;

// Placements des angles du centre blanc
procedure placeAnglesBlancs(var cube:TRubik);
begin

		// Placement de l'angle Blanc/Vert/Rouge

		case (trouveAngle(cube,123)) of
			 123 : ;
			 231 : AppliqueFormule(cube,'F''D''FDRFR''F''');
			 312 : AppliqueFormule(cube,'R''DRD''FRF''R''');
			 134 : AppliqueFormule(cube,'B''DBRFR''F''');
			 341 : AppliqueFormule(cube,'RD''R''D²RFR''F''');
			 413 : AppliqueFormule(cube,'B''DBFRF''R''');
			 145 : AppliqueFormule(cube,'LD²L''RFR''F''');
			 451 : AppliqueFormule(cube,'BD²B''RFR''F''');
			 514 : AppliqueFormule(cube,'LD²L''FRF''R''');
			 152 : AppliqueFormule(cube,'L''D''LFRF''R''');
			 521 : AppliqueFormule(cube,'L''D''LRFR''F''');
			 215 : AppliqueFormule(cube,'FDF''D²FRF''R''');
			 263 : AppliqueFormule(cube,'RFR''F''');
			 364 : AppliqueFormule(cube,'DRFR''F''');
			 465 : AppliqueFormule(cube,'D²RFR''F''');
			 562 : AppliqueFormule(cube,'D''RFR''F''');
			 326 : AppliqueFormule(cube,'FRF''R''');
			 436 : AppliqueFormule(cube,'DFRF''R''');
			 546 : AppliqueFormule(cube,'D²FRF''R''');
			 256 : AppliqueFormule(cube,'D''FRF''R''');
			 632 : AppliqueFormule(cube,'F''DFD²RFR''F''');
			 643 : AppliqueFormule(cube,'DF''DFD²RFR''F''');
			 654 : AppliqueFormule(cube,'D²F''DFD²RFR''F''');
			 625 : AppliqueFormule(cube,'D''F''DFD²RFR''F''');
		end;

		// Placement de l'angle Blanc/Rouge/Bleu avec sauvegarde de la position Blanc/Vert/Rouge
    case (trouveAngle(cube,134)) of
			 134 : ;
			 341 : AppliqueFormule(cube,'RD''R''DBR''B''R');
			 413 : AppliqueFormule(cube,'B''DBD''R''BRB''');
			 145 : AppliqueFormule(cube,'LDL''BR''B''R');
			 451 : AppliqueFormule(cube,'BD''B''D²BR''B''R');
			 514 : AppliqueFormule(cube,'LDL''R''BRB''');
			 152 : AppliqueFormule(cube,'L''D²LR''BRB''');
			 521 : AppliqueFormule(cube,'L''D²LBR''B''R');
			 215 : AppliqueFormule(cube,'FD²F''R''BRB''');
			 263 : AppliqueFormule(cube,'D''BR''B''R');
			 364 : AppliqueFormule(cube,'BR''B''R');
			 465 : AppliqueFormule(cube,'DBR''B''R');
			 562 : AppliqueFormule(cube,'D²BR''B''R');
			 326 : AppliqueFormule(cube,'D''R''BRB''');
			 436 : AppliqueFormule(cube,'R''BRB''');
			 546 : AppliqueFormule(cube,'DR''BRB''');
			 256 : AppliqueFormule(cube,'D²R''BRB''');
			 632 : AppliqueFormule(cube,'D''RDR''D²BR''B''R');
			 643 : AppliqueFormule(cube,'RDR''D²BR''B''R');
			 654 : AppliqueFormule(cube,'DRDR''D²BR''B''R');
			 625 : AppliqueFormule(cube,'D²RDR''D²BR''B''R');
		end;
		
		// Placement de l'angle Blanc/Bleu/Orange avec sauvegarde des positions Blanc/Vert/Rouge et Blanc/Rouge/Bleu
    case (trouveAngle(cube,145)) of
			 145 : ;
			 451 : AppliqueFormule(cube,'BD''B''DL''B''LB');
			 514 : AppliqueFormule(cube,'LDL''D''B''L''BL');
			 152 : AppliqueFormule(cube,'FDF''L''B''LB');
			 521 : AppliqueFormule(cube,'L''D''LD²L''B''LB');
			 215 : AppliqueFormule(cube,'FDF''B''L''BL');
			 263 : AppliqueFormule(cube,'D²L''B''LB');
			 364 : AppliqueFormule(cube,'D''L''B''LB');
			 465 : AppliqueFormule(cube,'L''B''LB');
			 562 : AppliqueFormule(cube,'DL''B''LB');
			 326 : AppliqueFormule(cube,'D²B''L''BL');
			 436 : AppliqueFormule(cube,'D''B''L''BL');
			 546 : AppliqueFormule(cube,'B''L''BL');
			 256 : AppliqueFormule(cube,'DB''L''BL');
			 632 : AppliqueFormule(cube,'D²LD''L''D²B''L''BL');
			 643 : AppliqueFormule(cube,'D''LD''L''D²B''L''BL');
			 654 : AppliqueFormule(cube,'LD''L''D²B''L''BL');
			 625 : AppliqueFormule(cube,'DLD''L''D²B''L''BL');
		end;

		// Placement de l'angle Blanc/Orange/Vert avec sauvegarde des positions Blanc/Vert/Rouge, Blanc/Rouge/Bleu et Blanc/Bleu/Orange
		case (trouveAngle(cube,152)) of
			 152 : ;
			 521 : AppliqueFormule(cube,'L''D''LDF''LFL''');
			 215 : AppliqueFormule(cube,'FDF''D''LF''L''F');
			 263 : AppliqueFormule(cube,'DF''LFL''');
			 364 : AppliqueFormule(cube,'D²F''LFL''');
			 465 : AppliqueFormule(cube,'D''F''LFL''');
			 562 : AppliqueFormule(cube,'F''LFL''');
			 326 : AppliqueFormule(cube,'DLF''L''F');
			 436 : AppliqueFormule(cube,'D²LF''L''F');
			 546 : AppliqueFormule(cube,'D''LF''L''F');
			 256 : AppliqueFormule(cube,'LF''L''F');
			 632 : AppliqueFormule(cube,'DFD''F''D²LF''L''F');
			 643 : AppliqueFormule(cube,'D²FD''F''D²LF''L''F');
			 654 : AppliqueFormule(cube,'D''FD''F''D²LF''L''F');
			 625 : AppliqueFormule(cube,'FD''F''D²LF''L''F');
    end;
end;


procedure placeCotesRang2(var cube:TRubik);
begin
		// Placement du coté Vert/Rouge
		case trouveCote(cube,23) of
			23 : ;
			32 : AppliqueFormule(cube,'R''DRD''F''D''FDR''D²RD²F''D''F');
			34 : AppliqueFormule(cube,'B''DBD''RD''R''D''F''D²FD²R''DR');
			43 : AppliqueFormule(cube,'B''DBD''RD''R''D²R''D²RD²F''D''F');
			45 : AppliqueFormule(cube,'LDL''D''BD''B''F''D²FD²R''DR');
			54 : AppliqueFormule(cube,'LDL''D''BD''B''D''R''D²RD²F''D''F');
			52 : AppliqueFormule(cube,'FDF''D''L''D''LDF''D²FD²R''DR');
			25 : AppliqueFormule(cube,'FDF''D''L''D''LR''D²RD²F''D''F');
			26 : AppliqueFormule(cube,'D''R''D²RD²F''D''F');
			62 : AppliqueFormule(cube,'F''D²FD²R''DR');
			36 : AppliqueFormule(cube,'R''D²RD²F''D''F');
			63 : AppliqueFormule(cube,'DF''D²FD²R''DR');
			46 : AppliqueFormule(cube,'DR''D²RD²F''D''F');
			64 : AppliqueFormule(cube,'D²F''D²FD²R''DR');
			56 : AppliqueFormule(cube,'D²R''D²RD²F''D''F');
			65 : AppliqueFormule(cube,'D''F''D²FD²R''DR');
		end;
		
		// Placement du coté Rouge/Bleu avec sauvegarde de la position Vert/Rouge
		case trouveCote(cube,34) of
			34 : ;
			43 : AppliqueFormule(cube,'B''DBD''RD''R''DB''D²BD²RD''R''');
			45 : AppliqueFormule(cube,'LDL''D''BD''B''D''RD²R''D²B''DB');
			54 : AppliqueFormule(cube,'LDL''D''BD''B''D²B''D²BD²RD''R''');
			52 : AppliqueFormule(cube,'FDF''D''L''D''LRD²R''D²B''DB');
			25 : AppliqueFormule(cube,'FDF''D''L''D''LD''B''D²BD²RD''R''');
			26 : AppliqueFormule(cube,'D²B''D²BD²RD''R''');
			62 : AppliqueFormule(cube,'D''RD²R''D²B''DB');
			36 : AppliqueFormule(cube,'D''B''D²BD²RD''R''');
			63 : AppliqueFormule(cube,'RD²R''D²B''DB');
			46 : AppliqueFormule(cube,'B''D²BD²RD''R''');
			64 : AppliqueFormule(cube,'DRD²R''D²B''DB');
			56 : AppliqueFormule(cube,'DB''D²BD²RD''R''');
			65 : AppliqueFormule(cube,'D²RD²R''D²B''DB');
		end;

		// Placement du coté Bleu/Orange avec sauvegarde des positions Vert/Rouge et Rouge/Bleu
		case trouveCote(cube,45) of
			45 : ;
			54 : AppliqueFormule(cube,'LDL''D''BD''B''DLD²L''D²BD''B''');
			52 : AppliqueFormule(cube,'FDF''D''L''D''LD''BD²B''D²LDL''');
			25 : AppliqueFormule(cube,'FDF''D''L''D''LD²LD²L''D²BD''B''');
			26 : AppliqueFormule(cube,'DLD²L''D²BD''B''');
			62 : AppliqueFormule(cube,'D²BD²B''D²LDL''');
			36 : AppliqueFormule(cube,'D²LD²L''D²BD''B''');
			63 : AppliqueFormule(cube,'D''BD²B''D²LDL''');
			46 : AppliqueFormule(cube,'D''LD²L''D²BD''B''');
			64 : AppliqueFormule(cube,'BD²B''D²LDL''');
			56 : AppliqueFormule(cube,'LD²L''D²BD''B''');
			65 : AppliqueFormule(cube,'DBD²B''D²LDL''');
		end;
		
		// Placement du coté Orange/Vert avec sauvegarde des positions Vert/Rouge, Rouge/Bleu et Bleu/Orange
		case trouveCote(cube,52) of
			52 : ;
			25 : AppliqueFormule(cube,'FDF''D''L''D''LDFD²F''D²L''D''L');
			26 : AppliqueFormule(cube,'FD²F''D²L''D''L');
			62 : AppliqueFormule(cube,'DL''D²LD²FDF''');
			36 : AppliqueFormule(cube,'DFD²F''D²L''D''L');
			63 : AppliqueFormule(cube,'D²L''D²LD²FDF''');
			46 : AppliqueFormule(cube,'D²FD²F''D²L''D''L');
			64 : AppliqueFormule(cube,'D''L''D²LD²FDF''');
			56 : AppliqueFormule(cube,'D''FD²F''D²L''D''L');
			65 : AppliqueFormule(cube,'L''D²LD²FDF''');
		end;
	end;

const
QuoiFaire0:array[1..24,1..7] of integer=
((2345, 0, 0,0,0,0,0),(2354, 4, 1,1,4,9,0),(2435, 2, 1,4,0,0,0)
,(2453, 3, 4,1,1,0,0),(2534, 3, 9,4,1,0,0),(2543, 3, 4,9,4,0,0)
,(3245, 2, 4,1,0,0,0),(3254, 4, 4,9,4,9,0),(3425, 3, 9,4,9,0,0)
,(3452, 1, 1,0,0,0,0),(3524, 3, 4,4,1,0,0),(3542, 3, 1,1,4,0,0)
,(4235, 4, 1,4,4,1,0),(4253, 2, 9,4,0,0,0),(4325, 5, 4,9,4,1,1)
,(4352, 2, 4,4,0,0,0),(4523, 2, 1,1,0,0,0),(4532, 2, 4,9,0,0,0)
,(5234, 1, 9,0,0,0,0),(5243, 3, 1,4,9,0,0),(5324, 1, 4,0,0,0,0)
,(5342, 4, 9,4,1,1,0),(5423, 3, 1,4,4,0,0),(5432, 4, 4,9,4,1,0));
//4 2->4 3->3 4->5 5->2
//9 2->3 3->4 4->5 5->2
//1 2<-3 3<-4 4<-5 5<-2

procedure PlaceCotesJaunes(var cube:TRubik);
var
 c2,c3,c4,c5:integer;
begin
 c2:=RotationCote(cube,62,6);
 c3:=RotationCote(cube,63,6);
 c4:=RotationCote(cube,64,6);
 c5:=RotationCote(cube,65,6);

 // 1 = coin dans le bon sens

 case c2*1000+c3*100+c4*10+c5 of
  2222: begin AppliqueFormule(cube,'RF''D''FDR''/D²/RD''F''DFR'''); end;
  2121: begin AppliqueFormule(cube,'D/RF''D''FDR''');            end;
  1212: begin AppliqueFormule(cube,'RF''D''FDR''');              end;   //
  1122: begin AppliqueFormule(cube,'D²/RD''F''DFR''');           end;
  1221: begin AppliqueFormule(cube,'D/RD''F''DFR''');           end;
  2211: begin AppliqueFormule(cube,'RD''F''DFR''');              end;   //
  2112: begin AppliqueFormule(cube,'D''/RD''F''DFR''');            end;  //
  1111:; // rien, c'est OK
 else solu:=solu+'Erreur...';
 end;
end;

const
QuoiFaire1:array[1..24,1..7] of integer=
((2345, 0, 0,0,0,0,0),(2354, 4, 1,1,4,9,0),(2435, 2, 1,4,0,0,0)
,(2453, 3, 4,1,1,0,0),(2534, 3, 9,4,1,0,0),(2543, 3, 4,9,4,0,0)
,(3245, 2, 4,1,0,0,0),(3254, 4, 4,9,4,9,0),(3425, 3, 9,4,9,0,0)
,(3452, 1, 1,0,0,0,0),(3524, 3, 4,4,1,0,0),(3542, 3, 1,1,4,0,0)
,(4235, 4, 1,4,4,1,0),(4253, 2, 9,4,0,0,0),(4325, 5, 4,9,4,1,1)
,(4352, 2, 4,4,0,0,0),(4523, 2, 1,1,0,0,0),(4532, 2, 4,9,0,0,0)
,(5234, 1, 9,0,0,0,0),(5243, 3, 1,4,9,0,0),(5324, 1, 4,0,0,0,0)
,(5342, 4, 9,4,1,1,0),(5423, 3, 1,4,4,0,0),(5432, 4, 4,9,4,1,0));
//4 2->4 3->3 4->5 5->2
//9 2->3 3->4 4->5 5->2
//1 2<-3 3<-4 4<-5 5<-2


procedure OrienteCotesJaunes(var cube:TRubik);
var
 c2,c3,c4,c5:integer;
 i,n:integer;
begin
 c2:=trouveCote(cube,62) mod 10;
 c3:=trouveCote(cube,63) mod 10;
 c4:=trouveCote(cube,64) mod 10;
 c5:=trouveCote(cube,65) mod 10;
 n:=0;

 for i:=1 to 24 do if QuoiFaire1[i,1]=c2*1000+c3*100+c4*10+c5 then n:=i;
 if n<1 then exit;
 for i:=1 to QuoiFaire1[n,2] do
 begin
  case QuoiFaire1[n,i+2] of
   4: AppliqueFormule(cube,'F''D²FDF''DF');
   9: AppliqueFormule(cube,'D''');
   1: AppliqueFormule(cube,'D');
  end;
 end;
end;


const
QuoiFaire2:array[1..12,1..4] of integer=
((1234, 0, 0,0),(1342, 2, 2,2),(1423, 1, 2,0)
,(2143, 2, 4,1),(2314, 2, 3,3),(2431, 2, 4,4)
,(3124, 1, 3,0),(3241, 2, 1,1),(3412, 2, 4,3)
,(4132, 1, 4,0),(4213, 1, 1,0),(4321, 2, 3,4));

procedure PlaceCoinsJaunes(var cube:TRubik);
var
 c1,c2,c3,c4:integer;
 i,n:integer;
begin
 c1:=trouveAngle(cube,625);
 c2:=trouveAngle(cube,632);
 c3:=trouveAngle(cube,643);
 c4:=trouveAngle(cube,654);
 case c1 of
 625,652,265,256,562,526:c1:=1;
 632,623,362,326,263,236:c1:=2;
 643,634,463,436,364,346:c1:=3;
 654,645,564,546,465,456:c1:=4;
 end;
 case c2 of
 625,652,265,256,562,526:c2:=1;
 632,623,362,326,263,236:c2:=2;
 643,634,463,436,364,346:c2:=3;
 654,645,564,546,465,456:c2:=4;
 end;
 case c3 of
 625,652,265,256,562,526:c3:=1;
 632,623,362,326,263,236:c3:=2;
 643,634,463,436,364,346:c3:=3;
 654,645,564,546,465,456:c3:=4;
 end;
 case c4 of
 625,652,265,256,562,526:c4:=1;
 632,623,362,326,263,236:c4:=2;
 643,634,463,436,364,346:c4:=3;
 654,645,564,546,465,456:c4:=4;
 end;

 n:=0;
 for i:=1 to 24 do if QuoiFaire2[i,1]=c1*1000+c2*100+c3*10+c4 then n:=i;
 if n<1 then exit;
 for i:=1 to QuoiFaire2[n,2] do
 begin
  case QuoiFaire2[n,i+2] of
   1: AppliqueFormule(cube,'B''D''F''DBD''FD');
   2: AppliqueFormule(cube,'R''D''L''DRD''LD');
   3: AppliqueFormule(cube,'FD''BDF''D''B''D');
   4: AppliqueFormule(cube,'LD''RDL''D''R''D');
  end;
 end;
end;

//



const
QuoiFaire3:array[1..27,1..5] of integer=
(
(1111, 0 , 0,0,0),(1123, 2 , 4,4,0),(1132, 1 , 4,0,0),
(1213, 2 , 2,5,0),(1222, 3 , 3,3,4),(1231, 2 , 3,3,0),
(1312, 2 , 3,4,0),(1321, 1 , 3,0,0),(1333, 3 , 3,4,4),
(2113, 1 , 5,0,0),(2122, 3 , 4,4,5),(2131, 2 , 4,5,0),
(2212, 3 , 2,5,5),(2221, 3 , 2,2,3),(2233, 3 , 3,3,5),
(2311, 2 , 2,2,0),(2323, 2 , 3,5,0),(2332, 3 , 2,2,4),
(3112, 2 , 5,5,0),(3121, 2 , 2,3,0),(3133, 3 , 4,5,5),
(3211, 1 , 2,0,0),(3223, 3 , 2,4,4),(3232, 2 , 2,4,0),
(3313, 3 , 2,2,5),(3322, 3 , 3,5,5),(3331, 3 , 2,3,3));

{
c1 625 256 562
c2 632 326 263
c3 643 436 364
c4 654 546 465
}

procedure OrienteCoinsJaunes(var cube:TRubik);
var
 c1,c2,c3,c4:integer;
 i,n:integer;
begin
 c1:=trouveAngle(cube,625);
 c2:=trouveAngle(cube,632);
 c3:=trouveAngle(cube,643);
 c4:=trouveAngle(cube,654);
 case c1 of 625:c1:=1;  256:c1:=3;  562:c1:=2; end;
 case c2 of 632:c2:=1;  326:c2:=3;  263:c2:=2; end;
 case c3 of 643:c3:=1;  436:c3:=3;  364:c3:=2; end;
 case c4 of 654:c4:=1;  546:c4:=3;  465:c4:=2; end;

 n:=0;
 for i:=1 to 27 do if QuoiFaire3[i,1]=c1*1000+c2*100+c3*10+c4 then n:=i;
 if n<1 then exit;
 for i:=1 to QuoiFaire3[n,2] do
 begin
  case QuoiFaire3[n,i+2] of
   2: AppliqueFormule(cube,'F''D²FDF''DFB''D²BD''B''D''B');
   3: AppliqueFormule(cube,'RD²R''DRDR''LD²L''D''LD''L''');
   4: AppliqueFormule(cube,'BD²B''DBDB''FD²F''D''FD''F''');
   5: AppliqueFormule(cube,'L''D²LDL''DLR''D²RD''R''D''R');
  end;
 end;

end;




function RubikToStr(c:TLinRubik):string;
var
 i:integer;
begin
 result:='';
 for i:=0 to 53 do result:=result+inttostr(c[i]);
end;

// Supressions de deux mouvements opposés consécutifs
function filtre(var s:string;cube:TFaceRubik;can:tcanvas):string;
var
 tmp:TLinRubik;
 tab:array of string;
 i,j,n,p:integer;
 f:string;
begin
 result:='';
 can.FillRect(can.ClipRect);
 for i:=0 to ConvertNumber-1 do s:=AnsiReplaceText(s,StrFrom_To[i*2],StrFrom_To[i*2+1]);
 tmp:=TLinRubik(cube);
 n:=CompteMouvements(s);
 setlength(tab,n+1);
 p:=1;
 tab[0]:=RubikToStr(tmp);
 for j:=0 to 53 do can.Pixels[0,j]:=CCouleur[tmp[j]];
 for i:=1 to n do
  begin
   f:=s[p];
   inc(p);
   if (p<=length(s)) and (s[p]='''') then begin f:=f+''''; inc(p); end;
   if (p<=length(s)) and (s[p]='²') then begin f:=f+'²'; inc(p); end;
   AppliqueFormule(tfacerubik(tmp),f);
   for j:=0 to 53 do can.Pixels[i,j]:=CCouleur[tmp[j]];
   tab[i]:=RubikToStr(tmp);
  end;
 for j:=n downto 1 do
  for i:=0 to j-1 do
   if tab[j]=tab[i] then result:=result+'('+inttostr(j)+'/'+inttostr(i)+')';
end;

end.

