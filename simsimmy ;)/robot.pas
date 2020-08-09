uses crt,dos;
var i,j,k,r,dung,soquest,max,solandahoi,temp,x,y:longint;
  ch:char;
  f:text;
  maxx:array[-10..1000000] of integer;
  hoi,lasthoi,ln,kt:string;
  quest,question1,q:array[1..100000] of string;
  ans,ans1,a:array[1..1000000] of string;
  break1:boolean;
procedure kiemtracapnhat;
begin
  assign(f,'update\kiem tra.txt');
  reset(f);
  readln(f,kt);
  if kt='0' then
  begin
    clrscr;exit;
  end;
  rewrite(f);   write(f,1);
  close(f);
  gotoxy(20,11);
  write('Hien tai dang co ban cap nhat moi, tai ve? (y/n)');
  repeat
    ch := readkey;
  until (upcase(ch)='Y') or (upcase(ch)='N');
  if upcase(ch)='N' then
  begin
    clrscr; exit;
  end;
  clrscr;
  for i:=1 to 79 do
  begin
    delay(100);
    textcolor(15);
    gotoxy(35,12);
    write('DOWNLOADING . . . ',i,'%');
    textcolor(yellow);
    gotoxY(i,11);
    write(char(178));
  end;
  i := 0;k:=0;
    ///doc
  assign(f,'update\question.txt');
  reset(f);
  while not eoln(f) do
  begin
    inc(i);
    readln(f,q[i]);
  end;
  close(f);
  assign(f,'update\answer.txt');
  reset(f);
  while not eoln(f) do
  begin
    inc(k);
    readln(f,a[k]);
  end;
  close(f);
    ///replace
  assign(f,'question2.txt');
  append(f);
  for j := 1 to i do writeln(f,q[j]);
  close(f);
  assign(f,'answer2.txt');
  append(f);
  for j := 1 to k do writeln(f,a[j]);
  close(f);
  write(char(178));
  gotoxy(35,12);
  write('DOWNLOADING . . . ',100,'%');
  assign(f,'update\question.txt');
  rewrite(f);
  close(f);
  assign(f,'update\answer.txt');
  rewrite(f);
  close(f);
  assign(f,'update\kiem tra.txt');
  rewrite(f);
  write(f,0);
  close(f);
  i := 0;k:=0;
  clrscr;
end;
procedure screen;
begin
  gotoxy(1,1);
  writeln('Neu robot tra loi sai thi ban nhap "error" de day robot!"/exit" de thoat');
  gotoxy(60,2);write('Do chinh xac: ',i,'%  ');
end;
procedure rep;
begin
  write('...');
  delay(400);
  gotoxy(1,wherey);clreol;
end;
procedure xuat;
var i:longint;
begin
  rep;
  i := 0;
  assign(f,'answer2.txt');
  reset(f);
  while not eoln(f) do
  begin
    inc(i);
    readln(f,ans[i]);
  end;
  close(f);
  textcolor(14);
  writeln(ans[dung]);
  textcolor(15);
end;
procedure readquest;
var i:longint;
begin
  i := 0;
  assign(f,'question2.txt');
  reset(f);
  while not eoln(f) do
  begin
    inc(i);
    readln(f,quest[i]);
  end;
  soquest := i;
  close(f);
end;
procedure xuli;

procedure learn;
procedure xuli1;
var i:longint;
begin
  assign(f,'question1.txt');
  reset(f);i:=0;
  while not eoln(f) do
  begin
    inc(i);
    readln(f,question1[i]);
  end;
  close(f);
  for i:=i downto 1 do
  if hoi=question1[i] then
  begin
    assign(f,'answer1.txt');
    reset(f);
    j := 0;
    while j<=i do
    begin
      inc(j);
      readln(f,ans1[j]);
    end;
    writeln(ans1[i]);
    temp := i;
    exit;
  end;
end;
begin
  rep;
  writeln('Ban se day toi chu?');
  readln(hoi);
  xuli1;
  if ans1
  [temp]='thanks' then
  begin
    rep;
    writeln('Khi ai do noi "',lasthoi,'" thi minh se noi gi?');
    readln(ln);
    assign(f,'question2.txt');
    append(f);
    writeln(f,lasthoi);
    close(f);
    assign(f,'answer2.txt');
    append(f);
    writeln(f,ln);
    close(f);
    /// write update
    assign(f,'update\question.txt');
    append(f);
    writeln(f,lasthoi);
    close(f);
    assign(f,'update\answer.txt');
    append(f);
    writeln(f,ln);
    close(f);
    rep;
    writeln('Cam on ban !, ban hoi tiep ik');
  end;
  y := wherey;x:=1;
end;
begin
  if length(hoi)=0 then
  begin
    writeln('?');exit;
  end;
  if hoi='error' then
  begin
    learn;exit;
  end;
  readquest;
  for i:=soquest downto 1 do
  begin
    r := 0;
    for j:=1 to length(quest[i]) do
    for k:=1 to length(hoi) do
    if quest[i][j]=hoi[k] then
    begin
      inc(r);break;
    end;
    if length(quest[i])>=length(hoi) then r := (r*100) div length(quest[i]) else r:=(r*100) div length(hoi);
    if maxx[r]=0 then maxx[r]:=i;
  end;
  for i:=10000 downto 0 do if maxx[i]>0 then break;
  if i<60 then
  begin
    learn;exit;
  end
  else
  begin
    dung:=maxx[i];xuat;y:=wherey;x:=1;screen;i:=maxx[i];
  end;
  for i:=10000 downto 0 do maxx[i]:=0;
    ///xu li tiep
   { for i:=soquest downto 1 do
    begin
        r := 0;
        for j:=length(hoi) downto 1 do
        for k:=length(quest[i]) downto 1 do
        if quest[i][k]=hoi[j] then inc(r);
        if length(quest[i])>=length(hoi) then r := (r*100) div length(quest[i]) else r:=(r*100) div length(hoi);
        if r=max then begin dung:=i;xuat;y:=wherey;x:=1;break;end;
    end;}
end;
begin
  clrscr;
  kiemtracapnhat;
  textcolor(15);
  gotoxy(1,2);writeln('Hi there');
  readquest;
  screen;
  gotoxy(1,3);
  repeat
    begin
      readln(hoi);if hoi='' then continue;
      if wherey>18 then
      begin
        clrscr;screen;gotoxy(1,2);
      end;
      x := wherex;y:=wherey;
      if hoi='/exit' then halt;
      if hoi='/eraser' then
      begin
        assign(f,'question2.txt');rewrite(f);close(f);assign(f,'answer2.txt');rewrite(f);close(f);
      end;
      if hoi<>'error' then lasthoi := hoi;
      readquest;
      xuli;
      gotoxy(60,2);write('Do chinh xac:');
      gotoxy(x,y);
    end;
  until 1=2;
end.
