unit calcpas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterCpp, SynHighlighterPas, Forms,
  Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Button1: TButton;
    Button2: TLabel;
    CheckBox1: TCheckBox;
    edit: TEdit;
    Button3: TLabel;
    Image1: TImage;
    StaticText1: TStaticText;
    Timer1: TTimer;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  i,so,e,code:longint;
s,tmps:string;
num,mauso:array[0..100000] of longint;
ok,count,checktp,checktru,checkcong,nhanchia,checkerror,nhan,chia:boolean;
asd:string;

implementation
{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  s:=s+'1';
  if count then count:=false;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
checkcong:=false;
checktru:=false;
  s:=s+'2';
  if count then count:=false;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin

  checkcong:=false;
checktru:=false;
  s:=s+'3';
  if count then count:=false;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  checktp:=false;
  if not checktru then s:=s+'-';
  checktru:=true;
  if count then count:=false;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  checktp:=false;
  if not checkcong then s:=s+'+';
  checkcong:=true;
  if count then count:=false;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'4';
  if count then count:=false;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'7';
  if count then count:=false;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'8';
  if count then count:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if not checktp then
        begin
        s:=s+'.';
        checktp:=true;
        end;

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.checked=true then
          edit.enabled:=true
  else
          edit.enabled:=false;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  checkerror:=false;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
   delete(s,length(s),1);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if not count then Button2.caption:=s;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'5';
  if count then count:=false;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'6';
  if count then count:=false;
end;

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
  checkcong:=false;
checktru:=false;
  s:=s+'9';
  if count then count:=false;
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
procedure xoakhoangtrang;
var tmp,temp:string;
check:boolean;
begin
check:=false;
tmp:=s;
s:='';
for i:=1 to length(tmp) do
        begin
        if (tmp[i]<>' ') or ((s[i]='0') and (s[i-1]<>'0')) then s:=s+tmp[i];
        if (tmp[i]='*') or (tmp[i]='/') then nhanchia:=true;
        if tmp[i]='*' then nhan:=true;
        if tmp[i]='/' then chia:=true;
        end;
temp:=tmp;
        for i:=1 to length(temp) do
        begin
        if (temp[i]='0') and not check then
                begin
                delete(temp,i,1);
                check:=true;
                end;
        if (temp[i]<'0') or (temp[i]>'z') then check:=false;
        end;
tmp:=temp;
end;
procedure xulithapphan;
var s:string;
begin
s:=tmps;
//muon tam bien checktp vi luoi khai bao =V
for i:=1 to length(s) do
        if s[i]=',' then checktp:=true;
if checktp then
        begin
        checktp:=false;
        for i:=1 to length(s) do
                if s[i+1]=',' then
                        begin

                        end;
        end;
end;

procedure demso(s:string);
var text,res:string;
begin
i:=0;so:=0;
repeat
inc(i);
if (s[i]='+') or (s[i]='-') or (s[i]='*') or (s[i]='/')then
        begin
        res:=s[i];
        inc(so);
        text:='';
        repeat
        text:=text+s[i+1];
        inc(i);
        until (s[i+1]>'z') or (s[i+1]<'0') or (i+1>length(s));
        val(text,num[so],code);
        if code<>0 then checkerror:=true;
        if res='-' then num[so]:=num[so]-num[so]*2;
        end;
until i=length(s);
end;
function tinh:longint;
var t:longint;

begin
t:=0;
for i:=1 to so do
        begin
        t:=t+num[i];
        end;
exit(t);
end;
procedure timbcnn;
var tmp,tmpms:integer;
begin
tmp:=0;
for i:=1 to length(s) do
        if s[i]='/' then
                begin
                inc(tmp);
                mauso[tmp]:= num[tmp+1];
                end;
for i:=1 to tmp do

end;

procedure khumau;
begin
for i:=1 to length(s) do

end;

function tinh2:real;
var
tmp,j:integer;
n,t:int64;
text:string;
begin
t:=0;
tmp:=0;
if chia then
        begin
        timbcnn;
        khumau;
        end;
tmp:=0;
if nhan then
for i:=1 to length(s) do
        begin
        if (s[i]='+') or (s[i]='-') then inc(tmp);
        if s[i]='*' then
           begin
           n:=(num[tmp]*num[tmp+1]);
           num[tmp]:=n;
           for j:=tmp+1 to so do
                   num[j]:=num[j+1];
           dec(so);
           end;
        str(n,text);
        {insert(text,s,i-1);
        delete(s,i+length(text),3); }
        end;
t:=0;
for i:=1 to so do
        begin
        t:=t+num[i];
        end;
exit(t);
end;
begin
if s='' then exit;
if (s[1]<>'-') and (s[1]<>'0') then insert('+',s,1);
tmps:=s;xulithapphan;
xoakhoangtrang;
demso(s);
if checkerror then button3.caption:='SYNTAX ERROR' else
if not nhanchia then Button3.caption:=inttostr(tinh) else
        begin
        button3.caption:=inttostr(trunc(tinh2));
        end;
checkerror:=false;
checkcong:=false;
checktru:=false;
nhan:=false;
chia:=false;
s:='';
so:=0;
count:=true;
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
  checktp:=false;
  s:=s+'/';
  if count then count:=false;
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
begin
  checktp:=false;
  s:=s+'*';

  if count then count:=false;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if (s='') or (s[length(s)]<>'0') then s:=s+'0';
  checkcong:=false;
checktru:=false;
  if count then count:=false;
end;

end.

