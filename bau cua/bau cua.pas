uses crt,mouse,mmsystem,sysutils;
var mouseevent:tmouseevent;
  i,j,xm,ym,lastx,lasty,x,y,coin,count,money,solanchon,e,color,botmoney:longint;
  a:array[0..90,0..90] of char;
  f:text;
  text,t,lastt,temp,folder,lastt2:string;
  choose:array[1..2] of string;
  r:array[1..3] of longint;
  key:char;
  sound,check:boolean;
  con:array[1..6] of string = ('huou','bau','ga','ca','cua','tom');
procedure error;
begin
  window(10,4,70,21);
  write('OOPS, An error occurred while running this program or could not find the important file. Please reinstall this program! Press ENTER key to exit.');
  playsound('sound\beep.wav',0,SND_ASYNC);
  repeat
    key:=readkey;
  until key=#13;
  halt;
end;
procedure login;
var ok:boolean;
  tk,mk:string;
  tkr,mkr,cor,user:array[0..10000] of string;
  e:integer;
begin
  assign(f,'user.dat');
{$I-}reset(f);{$I-}
  if IOresult<>0 then error;
  i:=0;
  while not eoln(f) do
  begin
    inc(i);
    readln(f,user[i]);
  end;
  close(f);
  j:=i;
  for i:=1 to j do
  begin
    tkr[i]:=copy(user[i],1,pos(' ',user[i])-1);
    delete(user[i],1,pos(' ',user[i]));
    mkr[i]:=copy(user[i],1,pos(' ',user[i])-1);
    delete(user[i],1,pos(' ',user[i]));
    cor[i]:=copy(user[i],1,length(user[i]));
  end;
  repeat
    ok:=false;
    gotoxy(37,10);write('LOGIN');
    gotoxy(30,11);write('User name: ');
    gotoxy(30,12);write('Password: ');
    gotoxy(41,11);readln(tk);
    gotoxy(40,12);readln(mk);
    for i:=1 to j do
    if (tk=tkr[i]) and (mk=mkr[i]) then
    begin
      ok:=true;val(cor[i],money,e);
    end;
    if e<>0 then error;
    clrscr;
  until ok;
  clrscr;
  write('Ban co muon bat chuc nang auto login ko?');
  repeat
    key:=readkey
  until (upcase(key)='Y') or (upcase(key)='N');
  if upcase(key)='Y' then
  begin
    assign(f,'setting.conf');
    rewrite(f);
    write(f,'1');
    close(f);
  end;
end;
procedure playmusic(c:pchar;loop:boolean);
begin
  if sound then
  if fileExists(folder+c) then
  begin
    if loop then playsound(c,0,SND_ASYNC or SND_LOOP)
    else playsound(c,0,SND_ASYNC);
  end
  else error;
end;
procedure mute;
begin
  playsound(nil,0,SND_ASYNC);
end;
procedure clearfill(x,y:integer);
var tmpx,tmpy:integer;
begin
  tmpx:=x;tmpy:=y;
  textbackground(black);
  repeat
    gotoxy(x,y);
    write(a[y,x]);
    if a[y,x+1]<>'1' then inc(x) else
    begin
      x:=tmpx;inc(y);
    end;
  until a[y,x]='1';
end;
procedure fillcolor(x,y,color:integer);
var tmpx,tmpy:integer;
begin
  tmpx:=x;tmpy:=y;
  textbackground(color);
  repeat
    gotoxy(x,y);
    write(a[y,x]);
    if a[y,x+1]<>'1' then inc(x) else
    begin
      x:=tmpx;inc(y);
    end;
  until a[y,x]='1';
end;
procedure start;
begin
  count:=0;
  gotoxy(30,25);
  write('Dang lac: ');
  repeat
    inc(count);
    gotoxy(40,25);
    randomize;
    r[1]:=random(6)+1;
    write(con[r[1]],' ');
    r[2]:=random(6)+1;
    write(con[r[2]],' ');
    r[3]:=random(6)+1;
    write(con[r[3]]);
    write('     ');
    lastx:=2;lasty:=2;
    for i:=1 to 3 do
    begin
      lastx:=x;lasty:=y;
      case con[r[i]] of
        'huou': //
        begin
          x:=2;y:=2;
        end;
        'bau': //
        begin
          x:=26;y:=2;
        end;
        'ga': //
        begin
          x:=55;y:=2;
        end;
        'ca': //
        begin
          x:=2;y:=13;
        end;
        'cua': //
        begin
          x:=26;y:=13;
        end;
        'tom': //
        begin
          x:=55;y:=13;
        end;
      end;
      if (con[r[i]]=choose[1]) or (con[r[i]]=choose[2]) then fillcolor(x,y,lightblue) else fillcolor(x,y,red);
    end;
    delay(200);
    if count<5 then for i:=1 to 3 do
    begin
      lastx:=x;lasty:=y;
      case con[r[i]] of
        'huou': //
        begin
          x:=2;y:=2;
        end;
        'bau': //
        begin
          x:=26;y:=2;
        end;
        'ga': //
        begin
          x:=55;y:=2;
        end;
        'ca': //
        begin
          x:=2;y:=13;
        end;
        'cua': //
        begin
          x:=26;y:=13;
        end;
        'tom': //
        begin
          x:=55;y:=13;
        end;
      end;
      clearfill(x,y);
    end;
  until count=5;
  textbackground(black);
  check:=false;
  for i:=1 to 2 do
  for j:=1 to 3 do
  if con[r[j]]=choose[i] then check:=true;
  if check then
  begin
    playmusic('sound\true.wav',false);
    gotoxy(33,13);
    write('YOU WIN + ',coin,'$');
    inc(money,coin);
    dec(botmoney,coin);
    if botmoney<1 then botmoney:=0;
    if botmoney=0 then
    begin
      delay(1000);
      clrscr;
      gotoxy(20,12);
      write('You have beaten the bot! congratuation!');
      readln;
      halt;
    end;
  end
  else
  begin
    playmusic('sound\false.wav',false);
    gotoxy(27,13);
    write('YOU LOSE, BOT MONEY+ ',coin,'$');
    dec(money,coin);
    inc(botmoney,coin);
  end;
  delay(1000);
  for i:=1 to 3 do
  begin
    lastx:=x;lasty:=y;
    case con[r[i]] of
      'huou': //
      begin
        x:=2;y:=2;
      end;
      'bau': //
      begin
        x:=26;y:=2;
      end;
      'ga': //
      begin
        x:=55;y:=2;
      end;
      'ca': //
      begin
        x:=2;y:=13;
      end;
      'cua': //
      begin
        x:=26;y:=13;
      end;
      'tom': //
      begin
        x:=55;y:=13;
      end;
    end;
    clearfill(x,y);
  end;

end;

procedure drawscreen;
begin
  assign(f,'ban.txt');
  reset(f);
  for i:=1 to 22 do
  begin
    readln(f,text);
    for j:=1 to 80 do
    if text[j]<>'0' then
    begin
      gotoxy(j,i);
      if text[j]<>'1' then write(text[j]) else write(char(219));
      a[i,j]:=text[j];
    end;
  end;
  close(f);
end;
procedure play;
begin
  if pollmouseevent(mouseevent) then getmouseevent(mouseevent);
  xm:=getmousex+1;
  ym:=getmousey+1;
  lastt:=t;
  lastx:=x;lasty:=y;
  if (xm>1) and (ym>1) and (xm<26) and (ym<12)  then t:='huou' else
  if (xm>26) and (ym>1) and (xm<55) and (ym<12)  then t:='bau' else
  if (xm>55) and (ym>1) and (xm<81) and (ym<12)  then t:='ga' else
  if (xm>1) and (ym>13) and (xm<26) and (ym<22)  then t:='ca' else
  if (xm>26) and (ym>13) and (xm<55) and (ym<22)  then t:='cua' else
  if (xm>55) and (ym>13) and (xm<81) and (ym<22)  then t:='tom';
  case t of
    'huou': //
    begin
      x:=2;y:=2;
    end;
    'bau': //
    begin
      x:=26;y:=2;
    end;
    'ga': //
    begin
      x:=55;y:=2;
    end;
    'ca': //
    begin
      x:=2;y:=13;
    end;
    'cua': //
    begin
      x:=26;y:=13;
    end;
    'tom': //
    begin
      x:=55;y:=13;
    end;
  end;
  if (t<>lastt) then
  begin
    if choose[1]<>lastt then clearfill(lastx,lasty);
    fillcolor(x,y,green);
    textbackground(black);
    gotoxy(2,24);
    write('Ban dang chon ',t,'  ');
  end;
  if (getmousebuttons=mouseleftbutton) then
  begin
    donemouse;
    inc(solanchon);
    choose[solanchon]:=t;
    playmusic('sound\choose.wav',false);
    initmouse;
  end;
  if solanchon=2 then
  begin
    solanchon:=0;
    donemouse;
    textbackground(black);
    textcolor(14);
    gotoxy(20,23);
    write('Ban da chon ',choose[1],',',choose[2],' de cuoc     ');
    gotoxy(20,24);
    write('moi ban nhap tien dat coc (tren ',money div 4-1,'$): ');
    repeat
      readln(text);
      val(text,coin,e);
      gotoxy(57,24);
      write('     ');
      gotoxy(57,24);
      if (coin>money) or (coin<money div 4) or (e<>0) then playmusic('sound\beep.wav',false);
    until (coin<=money) and (coin>=money div 4) and (e=0);
    delay(500);
    for i:=1 to 2 do
    begin
      case choose[i] of
        'huou': //
        begin
          x:=2;y:=2;
        end;
        'bau': //
        begin
          x:=26;y:=2;
        end;
        'ga': //
        begin
          x:=55;y:=2;
        end;
        'ca': //
        begin
          x:=2;y:=13;
        end;
        'cua': //
        begin
          x:=26;y:=13;
        end;
        'tom': //
        begin
          x:=55;y:=13;
        end;
      end;
      clearfill(x,y);
    end;
    start;
    gotoxy(65,24);write('Bot money: ',botmoney,'$   ');
    gotoxy(65,23);write('MONEY: ',money,'$    ');
    gotoxy(26,13);write('                          ');
    gotoxy(20,23);write('                                     ');
    gotoxy(20,24);write('                                     ');
    gotoxy(30,25);write('                                     ');
    initmouse;
    for i:=1 to 2 do
    choose[i]:='';
  end;
end;

begin
  login;
  money:=100;
  botmoney:=500;
  clrscr;
  sound:=true;
  folder:=getcurrentDir+'\';
  x:=2;y:=2;lastx:=2;lasty:=2;
  cursoroff;
  initmouse;
  drawscreen;
  gotoxy(65,23);write('MONEY: ',money,'$');
  gotoxy(65,24);write('Bot money: ',botmoney,'$');
  repeat
    play
  until (money<1);
  donemouse;
  playmusic('sound\game_over.wav',false);
  delay(500);clrscr;
  gotoxy(35,12);write('YOU LOSE');
  delay(3000);
end.
