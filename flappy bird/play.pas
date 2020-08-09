uses crt,dos;
var gvt,flyingtime,time,x,y,bk,xx,yy,run,r,i,score,s1,s2,s3,s4,level,highlight:longint;
  ch:char;
  fly,t:boolean;
  f,f1:text;
  first,second,third,fourth,name:string;
procedure detail;
begin
  gotoxy(57,5);write('Score: ',score);
  gotoxy(57,8);write('Bang xep hang');
  if highlight=1 then textcolor(red) else textcolor(14);
  gotoxy(55,10);write('1st: ',first,' .. ',s1);
  if highlight=2 then textcolor(red) else textcolor(14);
  gotoxy(55,11);write('2nd: ',second,' .. ',s2);
  if highlight=3 then textcolor(red) else textcolor(14);
  gotoxy(55,12);write('3rd: ',third,' .. ',s3);
  if highlight=4 then textcolor(red) else textcolor(14);
  gotoxy(55,13);write('4th: ',fourth,' .. ',s4);
  textcolor(yellow);
  gotoxy(58,17);write('NAME :',name);
  textcolor(white);
end;
procedure rank;
begin
  if s1<score then
  begin
    highlight:=1; fourth:=third;third:=second;second:=first;first:=name;s4:=s3;s3:=s2;s2:=s1;s1:=score;
  end
  else
  if s2<score then
  begin
    highlight:=2;fourth:=third;third:=second;second:=name;s4:=s3;s3:=s2;s2:=score;
  end
  else
  if s3<score then
  begin
    highlight:=3;fourth:=third;third:=name;s4:=s3;s3:=score;
  end
  else
  if s4<score then
  begin
    highlight:=4;fourth:=name;s4:=score;
  end;
end;
procedure writefile;
begin
  assign(f,'bangxephang.txt');
  rewrite(f);
  for i:=1 to 8 do
  case i of
    1:writeln(f,first);
    2:writeln(f,s1);
    3:writeln(f,second);
    4:writeln(f,s2);
    5:writeln(f,third);
    6:writeln(f,s3);
    7:writeln(f,fourth);
    8:writeln(f,s4);
  end;
  close(f);
end;
procedure readfile;
begin
  i := 0;
  assign(f,'bangxephang.txt');
  reset(f);
  while not eof(f) do
  begin
    inc(i);
    case i of
      1:readln(f,first);
      2:readln(f,s1);
      3:readln(f,second);
      4:readln(f,s2);
      5:readln(f,third);
      6:readln(f,s3);
      7:readln(f,fourth);
      8:readln(f,s4);
    end;
  end;
  close(f);
end;
procedure drawboard;
begin
  textcolor(white);
  gotoxy(1,3);
  write(char(201));
  for i:=1 to 78 do
  write(char(205));
  write(char(187));
  for i:=1 to 20 do
  writeln(char(186));
  write(char(200));
  for i:=1 to 78 do
  write(char(205));
  write(char(188));
  for i:=3 to 22 do
  begin
    gotoxy(80,i+1);
    writeln(char(186));
  end;
  gotoxy(40,3);write(char(203));
  for i:=4 to 23 do
  begin
    gotoxy(40,i);
    write(char(186));
  end;
  gotoxy(40,24);write(char(202));
  inc(level,5);
  detail;
end;
procedure ran;
begin
  randomize;
  r := random(14)+4;
end;
procedure drawx(x:longint);
begin
  textcolor(green);
  for i:=4 to r do
  begin
    gotoxy(x,i);
    write(char(177),char(219),char(219),char(219),char(177),' ');
  end;
  gotoxy(x-1,r);write(char(177),char(177),char(177),char(177),char(177),char(177),char(177),' ');
  for i:=23 downto r+6 do
  begin
    gotoxy(x,i);
    write(char(177),char(219),char(219),char(219),char(177),' ');
  end;
  gotoxy(x-1,i);write(char(177),char(177),char(177),char(177),char(177),char(177),char(177),' ');
end;

procedure create;
begin
  inc(run);
  if run>1 then
  begin
    run:=0;dec(xx,1);
  end;
  if xx=10 then
  begin
    clrscr;drawboard;xx:=30;ran;
  end;
  drawx(xx);
  if xx=15 then
  begin
    dec(level);inc(score);
  end
  ;if level=-1 then level:=0;
  if t then
  begin
    gotoxy(x-12,y-1);
    textcolor(white);
    write('Press Space (#32) to fly');
    ch := readkey;if ch=#32 then
    begin
      time:=3;fly:=true;
    end;
    clrscr;
    drawboard;
    t := false;
  end;
end;
procedure play;
procedure loss;
begin
  rank;detail;
  writefile;
  textcolor(15);
  gotoxy((80-13)div 2,13);
  write('Your Score: ',score);
  delay(500);
  gotoxy(34,14);
  write('AGAIN? (Y/N)');
  ch := ' ';
  repeat
    ch := readkey;
  until (upcase(ch)='Y') or (upcase(ch)='N');
  if upcase(ch)='Y' then
  begin
    clrscr; exec('play.exe','16000');swapvectors;
  end;
  halt
end;
procedure colision;
begin
  if y>25 then loss;
  if y<1 then loss;
end;
begin
  colision;
  inc(bk);
  if bk>(100-level) then
  begin
    bk:=0;create;
  end;
  gotoxy(x,y-1);write(' ');
  gotoxy(x,y+1);write(' ');
  gotoxy(x,y);
  textcolor(14);
  write(char(2));
  if (x=xx) or ((x-1)=xx) or ((x-2)=xx) or ((x-3)=xx) or ((x-4)=xx)
  then
  if (y>r) and (y<(r+6)) then else loss;
  inc(gvt);
  if gvt>180 then if fly=false then
  begin
    gvt:=0;inc(y);
  end;
  if keypressed then
  begin
    ch := ' ';
    ch := readkey;
    case ch of
      #32: //
      begin
        fly:=true;time:=3;
      end;
      #27:halt;
      #13: //
      repeat
        ch:=readkey
      until ch=#13;
    end;
  end;
  inc(flyingtime);
  if flyingtime>150 then if time>0 then
  begin
    flyingtime:=0;dec(time);dec(y);
  end
  else fly:=false;
end;
begin
  level := 0;
  textbackground(1);
  clrscr;
  assign(f1,'nickname.txt');
  reset(f1);
  read(f1,name);
  close(f1);
  if name = 'admin' then else
  if name='' then
  begin
    Write('Enter your NICKNAME: ');readln(name);clrscr;assign(f1,'nickname.txt');rewrite(f1);write(f1,name);close(f1);
  end;
  readfile;
  drawboard;
  ran;
  xx := 30;
  x  := 20;
  y  := 13;
  t  := true;
  repeAT
    play
  UNTIL 1=2
end.
