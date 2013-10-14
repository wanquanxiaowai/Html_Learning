unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Info:array[-1..72,-1..180] of 0..3;

implementation

{$R *.dfm}

procedure PrintToFile;
var
  i,j:integer;
  f:textfile;
begin
  assignfile(f,'1.txt');
  rewrite(f);

  for i:=0 to 179 do
    begin
      for j:=0 to 71 do
        write(f,Info[j,i]);

    writeln(f);
    end;
  closefile(f);
end;

procedure FloodFill(x,y:integer);
begin
  Info[x,y]:=2;
  if Info[x-1,y]=1 then FloodFill(x-1,y);
  if Info[x+1,y]=1 then FloodFill(x+1,y);
  if Info[x,y-1]=1 then FloodFill(x,y-1);
  if Info[x,y+1]=1 then FloodFill(x,y+1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp:TBitmap;
  i,j:integer;


begin
  bmp:=TBitmap.create;
  bmp.loadfromfile('000.bmp');

  for i:=-1 to 72 do
    for j:=-1 to 180 do
      Info[i,j]:=3;  //3 IS WALL£»

  for i:=0 to 71 do
    for j:=0 to 179 do
       if bmp.canvas.Pixels[i,j]=clblack then Info[i,j]:=1 else Info[i,j]:=0;

  bmp.free;
  for i:=0 to 179 do
      if Info[71,i]=1 then FloodFill(72,i);

  PrintToFile;
end;

end.
