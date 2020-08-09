uses crt,dos;
var x,y,xbot,ybot,xbot2,ybot2:array[1..1000] of longint;
  snake,bot,out,savetext,bot2,levelstr:string;
  i,path,pathbot,xr,yr,count,level,
  kt,timeturnback,time,e,
  doduongr,savedlevel,savedtime,
  pathbot2,timeturnback2,doduongr2,
  botmove,rmove:longint;
  ch:char;
  ate,alive,alive2:boolean;
  f:text;
/////////////////////////////////////////////////////
procedure fix;
begin
  for i:=1 to 200 do
  begin
    if alive=false then
    begin
      xbot[i]:=1;
      ybot[i]:=1;
    end;
    if alive2=false then
    begin
      xbot2[i]:=1;
      xbot2[i]:=1;
    end;
  end;
end;
procedure information;
begin
  gotoxy(35,2);write('(me) ',path-1,' VS ',pathbot+pathbot2-2,' (bot)');gotoxy(70,3);write('Speed: ',level);
end;
procedure writefile;
begin
  assign(f,'setting.txt');
  rewrite(f);
  writeln(f,'speed =',savedlevel);
  writeln(f,'Time =',savedtime);
  writeln(f,'//example:"speed =12"(no space)(2000: default game savedlevel)');
  write(f,'//if the game have crashed then change the time play ( [time =10]    {time = 1 second} )');
  close(f);
end;
procedure readfile;
begin
  assign(f,'setting.txt');
  reset(f);
  readln(f,savetext);
  delete(savetext,1,pos('=',savetext));
  val(savetext,savedlevel,e);
  level := savedlevel;
  readln(f,savetext);
  delete(savetext,1,pos('=',savetext));
  val(savetext,savedtime,e);
  time := savedtime;
  close(f);
end;
procedure lose;
begin
  if (path>=(pathbot+pathbot2)) and (out<>'lose') then
  begin
    gotoxy(30,12);write('YOU WIN! NEXT WAVE? (Y/N)');
  END
  else
  begin
    gotoxy(30,12);write('YOU LOSE! PLAY AGAIN? (Y/N)');
  END;
  REPEAT
    CH := READKEY
  UNTIL (UPCASE(ch)='Y') or (upcase(ch)='N');
  if upcase(ch)='Y' then
  begin
    writefile;clrscr;swapvectors;exec('1 vs 2.exe','16000');swapvectors;
  end;
  writefile;
  halt;
end;
procedure checklose;
begin
  inc(kt);
  if kt>5 then
  begin
    if x[path]>80 then x[path]:=1;
    if x[path]<1 then x[path]:=80;
    if y[path]>25 then y[path]:=1;
    if y[path]<1 then y[path]:=25;
    for i:=1 to path-2 do
    if (x[path]=x[i]) and (y[path]=y[i]) then
    begin
      out:='lose';lose;
    end;
    for i:=1 to pathbot do
    if ((x[path]=xbot[i]) and (y[path]=ybot[i])) or ((x[path]=xbot2[i]) and (y[path]=ybot2[i])) then
    begin
      out:='lose';lose;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////

procedure doduong2;
begin
  randomize;
  doduongr2 := random(5);
  case doduongr2 of
    0,1:for i:=1 to path do
    begin
      if ((xbot2[pathbot2]+2=x[i]) or (xbot2[pathbot2]+1=x[i])) and (ybot2[pathbot2]=y[i]) then bot2:='up';
      if ((xbot2[pathbot2]-2=x[i]) or (xbot2[pathbot2]-1=x[i])) and (ybot2[pathbot2]=y[i]) then bot2:='down';
      if ((ybot2[pathbot2]+2=y[i]) or (ybot2[pathbot2]+1=y[i])) and (xbot2[pathbot2]=x[i]) then bot2:='left';
      if ((ybot2[pathbot2]-2=y[i]) or (ybot2[pathbot2]-1=y[i])) and (xbot2[pathbot2]=x[i]) then bot2:='right';
    end;
  end;
end;

procedure checkdiebot2;
begin
  inc(kt);
  if kt>10 then
  begin
    for i:=1 to path do
    if (xbot2[pathbot2]=x[i]) and (ybot2[pathbot2]=y[i]) then
    begin
      clrscr;gotoxy(xr,yr);write(char(3));dec(pathbot2);alive2:=false;fix;information;
    end;
  end;
end;
procedure snakebot2;
begin
  if alive2 then
  begin

    if xbot2[pathbot2]>xr then bot2:='left';
    if ybot2[pathbot2]>yr then bot2:='up';
    if ybot2[pathbot2]<yr then bot2:='down';
    if xbot2[pathbot2]<xr then bot2:='right';
    doduong2;
    case bot2 of
      'up':dec(ybot2[pathbot2]);
      'down':inc(ybot2[pathbot2]);
      'left':dec(xbot2[pathbot2]);
      'right':inc(xbot2[pathbot2]);
    end;
    gotoxy(xbot2[1],ybot2[1]);write(' ');
    for i := 1 to pathbot2-1 do
    begin
      xbot2[i]:=xbot2[i+1];ybot2[i]:=ybot2[i+1];
    end;
    textcolor(15);gotoxy(xbot2[pathbot2],ybot2[pathbot2]);write('@');
    checkdiebot2;
    if (xbot2[pathbot2]=xr) and (ybot2[pathbot2]=yr) then
    begin
      dec(level,savedlevel div 20);if level<1000 then level:=1000;ate:=true;inc(pathbot2);xbot2[pathbot2]:=wherex-1;ybot2[pathbot2]:=wherey;information;
    end;
  end
  else
  begin
    inc(timeturnback2);
    if timeturnback2>10 then
    begin
      if pathbot2<3 then pathbot2:=3;gotoxy(xr,yr);write(char(2));alive2:=true;timeturnback2:=0;information;
    end;
  end;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure snakebot;
procedure doduong;
begin
  randomize;
  doduongr := random(5);
  case doduongr of
    0,1:for i:=1 to path do
    begin
      if ((xbot[pathbot]+2=x[i]) or (xbot[pathbot]+1=x[i])) and (ybot[pathbot]=y[i]) then bot:='up';
      if ((xbot[pathbot]-2=x[i]) or (xbot[pathbot]-1=x[i])) and (ybot[pathbot]=y[i]) then bot:='down';
      if ((ybot[pathbot]+2=y[i]) or (ybot[pathbot]+1=y[i])) and (xbot[pathbot]=x[i]) then bot:='left';
      if ((ybot[pathbot]-2=y[i]) or (ybot[pathbot]-1=y[i])) and (xbot[pathbot]=x[i]) then bot:='right';
    end;
  end;
end;
procedure checkdiebot;
begin
  inc(kt);
  if kt>10 then
  begin
    if xbot[pathbot]>80 then alive:=false;
    if xbot[pathbot]<1 then alive:=false;
    if ybot[pathbot]>25 then alive:=false;
    if ybot[pathbot]<1 then alive:=false;
    for i:=1 to path do
    if (xbot[pathbot]=x[i]) and (ybot[pathbot]=y[i]) then
    begin
      clrscr;gotoxy(xr,yr);write(char(3));dec(pathbot);alive:=false;fix;information;
    end;
  end;
  if alive=false then fix;
end;
begin
  if alive then
  begin

    if xbot[pathbot]>xr then bot:='left';
    if ybot[pathbot]>yr then bot:='up';
    if ybot[pathbot]<yr then bot:='down';
    if xbot[pathbot]<xr then bot:='right';
    doduong;
    case bot of
      'up':dec(ybot[pathbot]);
      'down':inc(ybot[pathbot]);
      'left':dec(xbot[pathbot]);
      'right':inc(xbot[pathbot]);
    end;
    gotoxy(xbot[1],ybot[1]);write(' ');
    for i := 1 to pathbot-1 do
    begin
      xbot[i]:=xbot[i+1];ybot[i]:=ybot[i+1];
    end;
    textcolor(15);gotoxy(xbot[pathbot],ybot[pathbot]);write('0');gotoxy(xbot[pathbot-2],ybot[pathbot-2]);write('X');
    checkdiebot;
    if (xbot[pathbot]=xr) and (ybot[pathbot]=yr) then
    begin
      dec(level,savedlevel div 20);if level<1000 then level:=1000;ate:=true;inc(pathbot);xbot[pathbot]:=wherex-1;ybot[pathbot]:=wherey;information;
    end;
  end
  else
  begin
    inc(timeturnback);
    if timeturnback>10 then
    begin
      dec(pathbot);if pathbot<3 then pathbot:=3;gotoxy(xr,yr);write(char(2));alive:=true;timeturnback:=0;information;
    end;
  end;
end;
procedure meat;
begin
  randomize;
  xr    := random(78)+3;
  yr    := random(22)+3;
  for i := 1 to path do if (xr=x[i]) and (yr=y[i]) then meat;
  for i := 1 to pathbot do if (xr=xbot[i]) and (yr=ybot[i]) then meat;
  gotoxy(xr,yr);write(char(3));
  ate := false;
end;
procedure play;
begin
  if ate then meat;
  if keypressed then
  begin
    ch := readkey;
    case ch of
      #72:if snake<>'down' then snake:='up';
      #80:if snake<>'up' then snake:='down';
      #75:if snake<>'right' then snake:='left';
      #77:if snake<>'left' then snake:='right';
      #27: //
      begin
        writefile;halt;
      end;
      #13:readln;
    end
  end;
  if count>level then
  begin
    dec(time);
    gotoxy(65,2);write('TIME LESS: ',time div 10,',',time mod 10,'s ');
    if time=0 then lose;
    count := 0;
    gotoxy(x[1],y[1]);write(' ');
    for i := 1 to path-1 do
    begin
      x[i]:=x[i+1];y[i]:=y[i+1];
    end
    ;rmove:=random(2);inc(botmove);if botmove>rmove then
    begin
      botmove:=0;snakebot;snakebot2;
    end;
    case snake of
      'up':dec(y[path]);
      'down':inc(y[path]);
      'left':dec(x[path]);
      'right':inc(x[path]);
    end;
    checklose;
    textcolor(green);gotoxy(x[path-1],y[path-1]);write('O');textcolor(14);gotoxy(x[path],y[path]);write(char(2));
  end;
  if (x[path] = xr) and (y[path]=yr) then
  begin
    ate:=true;dec(level,savedlevel div 20);if level<1000 then level:=1000;inc(path);x[path]:=wherex-1;y[path]:=wherey;information;
  end;
  inc(count);
end;
begin
  readfile;
  alive    := true;alive2:=true;
  pathbot  := 4;
  pathbot2 := 4;
  for i    := 1 to 5 do
  begin
    xbot[i]:=i;ybot[i]:=5;xbot2[i]:=i;ybot2[i]:=20;
  end;
  ate      := true;
  for i    := 1 to 5 do
  begin
    x[i]:=i;y[i]:=2;
  end;
  path     := 5;
  snake    := 'right';
  bot      := 'left';
  information;
  repeat
    play
  until 1=2;
end.
