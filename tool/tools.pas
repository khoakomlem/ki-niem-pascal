program tools;
uses dos,crt,mouse,sysutils;
var a,b:array[-10..1000,-10..1000] of integer;
  mouseE:TmouseEvent;
  ch:char;
  x,y,code,lastx,lasty,i,j,x2,y2,x3,y3,k,j2,t,l,tmp,c,nhay,delays:integer;
  ok,chose,empty:boolean;
  f:text;
  str,temp:unicodestring;
  key:char;
procedure findx2x3y2y3;
begin
{find x2,y2}
  x3:=0;
  x2:=160;
  y2:=0;
  y3:=0;
  for i:=1 to 57 do
  for j:=1 to 160 do
  if a[i,j]<>32 then
  begin
    if j<x2 then x2:=j;
    if y2=0 then y2:=i;
    break;
  end;
{find x3,y3}
  for i:=57 downto 1 do
  for j:=160 downto 1 do
  if a[i,j]<>32 then
  begin
    if j>x3 then x3:=j;
    if y3=0 then y3:=i;
  end;
end;
function checkempty(y:integer):boolean;
begin
  checkempty:=false;
  for j:=1 to 160 do if a[y,j]<>32 then checkempty:=true;
  exit(checkempty);
end;
function cd(n:integer):string;
begin
  cd:=inttostr(n);
  exit(cd);
end;
procedure work;
procedure showmessage;
begin
  donemouse;
  window(50,20,110,37);
  writeln(char(15),' Your files have been saved at address: ',getcurrentDir+'/code.txt');
  writeln;
  writeln(char(15),' Hit the wrong button? Press [y] or [Y] to return back to work, hit [ENTER] to exit');
  writeln;
  textbackground(red);
  if empty then
  write(char(15),' The file is empty!');
  textbackground(black);
  repeat
    key:=readkey;
  until (upcase(key)='Y') or (key = #13);
  if upcase(key)='Y' then
  begin
    ok:=false;
    window(1,1,160,57);
    clrscr;
    gotoxy(1,57);textbackground(red);write('EXIT');textbackground(black);
    gotoxy(6,57);textbackground(red);write('CLEAR');textbackground(black);
    findx2x3y2y3;
    for i:=y2 to y3 do
    for j:=x2 to x3 do
    begin
      gotoxy(j,i);
      write(char(a[i,j]));
    end;
    key:=' ';
    work;
  end
  else
  halt;
end;
begin
  initmouse;
  lastx:=2;
  lasty:=2;
  repeat
    if x<>0 then lastx:=x;
    if y<>0 then lasty:=y;
    gotoxy(lastx,lasty);
    if b[lasty,lastx]=32 then write(char(a[lasty,lastx]));
    if b[lasty,lastx]<>32 then write(char(b[lasty,lastx]));
    if x<getmousex+1 then inc(x);
    if x>getmousex+1 then dec(x);
    if y>getmousey+1 then dec(y);
    if y<getmousey+1 then inc(y);
    if (x<=1) then x:=1;
    if (y<=1) then y:=1;
    if (x>=160) then x:=160;
    if (y>=56) then y:=56;
    gotoxy(x,y);
    write(char(code));
    if getmousebuttons=mouseleftbutton then
    begin
      if (getmousex+1>=6) and (getmousex+1<=11) and (getmousey+1=57) then
      begin
        gotoxy(6,57);textbackground(green);write('CLEAR');textbackground(black);
        delay(100);
        for i:=1 to 57 do
        for j:=1 to 160 do
        a[i,j]:=32;
        clrscr;
        gotoxy(1,57);textbackground(red);write('EXIT');textbackground(black);
        gotoxy(6,57);textbackground(red);write('CLEAR');textbackground(black);
      end else
      if (getmousex+1>=1) and (getmousex+1<=3) and (getmousey+1=57) then
      begin
        ok:=true;
        gotoxy(1,57);textbackground(green);write('EXIT');textbackground(black);
        delay(100);
      end else
      a[y,x]:=code;
    end;
    if getmousebuttons=mouserightbutton then
    begin
      clrscr;
      donemouse;
      findx2x3y2y3;
      i:=10;
      chose:=false;
      c:=0;
      gotoxy(10,10);
      repeat
        inc(i);
        for j:=10 to 150 do
        if odd(i) then
        begin
          inc(c);
          gotoxy(j,i);
          write(char(c));
          b[i,j]:=c;
        end;
      until c>=255;
      initmouse;
      repeat
        y:=getmousey+1;
        x:=getmousex+1;
        if pollmouseevent(mouseE) then getmouseevent(mouseE);
        if (x>=10) and (x<=150) and ((y=11) or (y=13)) and (getmousebuttons=mouseleftbutton) then
        begin
          chose:=true;
          code:=b[y,x];
        end;
      until chose;
      donemouse;
      clrscr;
      for i:=11 to 13  do
      for j:=10 to 150 do b[i,j]:=32;
      gotoxy(75,57);
      textbackground(red);
      textcolor(14);
      write('--> Wait 2 second. . . <--');
      textbackground(black);
      textcolor(white);
      for i:=y2 to y3 do
      for j:=x2 to x3 do
      begin
        gotoxy(j,i);
        write(char(a[i,j]));
      end;
      gotoxy(75,57);write('                           ');
      gotoxy(1,57);textbackground(red);write('EXIT');textbackground(black);
      gotoxy(6,57);textbackground(red);write('CLEAR');textbackground(black);
      initmouse;
		// this small code will fix the error
      getmouseevent(mouseE);
      repeat
        inc(delays);
        if delays>1000 then delays:=1000;
      until (delays=1000);
      delays:=0;
      y:=getmousey+1;
      x:=getmousex+1;
		// end of small code, if you del this code you'll an error when holding the target on ASCII table :D
    end;
    if pollmouseevent(mouseE) then getmouseevent(mouseE);
  until ok;
  donemouse;
//check emty
  empty:=true;
  for i:=1 to 57 do
  for j:=2 to 160 do
  if a[i,j]<>32 then empty:=false;

//writing

  findx2x3y2y3;
  assign(f,getcurrentDir+'/code.txt');
  rewrite(f);
  for i:=y2 to y3 do
  begin
    inc(l);
    for j:=x2 to x3 do if a[i,j]<>32 then
    begin
      k:=j-x2+1;t:=j;break;
    end;
    for j:=x3 downto x2 do if a[i,j]<>32 then
    begin
      tmp:=j;break;
    end;
    str:='gotoxy(x+'+cd(k)+',y+'+cd(l)+');write('+char(39)+' '+char(39)+',';
    if checkempty(i) then
    begin
      for j:=t to tmp do
      begin
        if a[i,j]<>32 then str:=str+'char('+cd(a[i,j])+'),'
        else
        begin
          if (a[i,j]=32) and (a[i,j-1]=32) then str:=str+' ' else str:=str+char(39)+' ';
          if a[i,j+1]<>32 then str:=str+char(39)+',';
        end;
      end;
      if a[i,j+1]<>32 then str:=str+'char('+cd(a[i,j+1])+'),'+char(39)+' '+char(39)
      else
      begin
        if (a[i,j+1]=32) and (a[i,j]=32) then str:=str+' '+char(39) else str:=str+char(39)+' '+char(39);
      end;
      writeln(f,str+');');
    end;
  end;
  clrscr;
  if empty then rewrite(f);
  close(f);
  showmessage;
end;
begin
//prepare
  executeProcess('cmd','/c mode con: cols=160 lines=57');
  window(1,1,160,57);
  clrscr;
  highvideo;
  cursoroff;
  for i:=1 to 300 do for j:=1 to 300 do
  begin
    a[i,j]:=32;b[i,j]:=32;
  end;
  code:=178;
//
  gotoxy(1,57);textbackground(red);write('EXIT');textbackground(black);
  gotoxy(6,57);textbackground(red);write('CLEAR');textbackground(black);
//main
  work;
end.
