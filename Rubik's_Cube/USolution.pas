unit USolution;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,UConst,UDraw, ExtCtrls;

type
  TFSolution = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FSolution: TFSolution;

implementation

{$R *.dfm}

end.
