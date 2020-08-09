uses crt,dos;
var x,y,speed:integer;ch:char;
  f:text;levelstr:string;
procedure writefile;
begin
  assign(f,'setting.txt');
  rewrite(f);
  writeln(f,'Speed =',speed);
  writeln(f,'Time =',200);
  writeln(f,'//example:"speed =12"(no space)(2000: default game savedlevel)');
  write(f,'//if the game have crashed then change the time play ( [time =10]    {time = 1 second} )');
  close(f);
end;
procedure choose;
begin
  clrscr;
  gotoxy(1,1);write(char(27),' Press ESC to return');
  textcolor(white);
  gotoxy(34,12);
  writeln('  1 VS 1 (pro)');
  gotoxy(34,13);
  writeln(' 1 VS 2(master)');
  gotoxy(31,y);write('->');gotoxy(51,y);write('<-');
  repeat
    begin
      ch:=readkey;
    end;
  until (ch=#80) or (ch=#72) or (ch=#13) or (ch=#27);
  if ch=#72 then
  begin
    y:=y-1;if y<12 then y:=13;
  end;
  if ch=#80 then
  begin
    y:=y+1;if y>13 then y:=12;
  end;
  if ch=#27 then
  begin
    y:=10;exit;
  end;
  IF ch=#13 then
  begin
    clrscr;
    case y of
      12: //
      begin
        y:=12;clrscr;swapvectors;exec('1 vs 1.exe','');swapvectors;
      end;
      13: //
      begin
        y:=12;clrscr;swapvectors;exec('1 vs 2.exe','');swapvectors;
      end;
    end;
  end;
  choose;
end;
procedure menu;
begin
  clrscr;
  gotoxy(1,1);write(char(27),' Press ESC to exit');
  textcolor(white);
  gotoxy(34,10);
  writeln('    PLAY    ');
  gotoxy(34,11);
  writeln('    SPEED    ');
    {gotoxy(34,12);
    writeln('    SKIN    ');}
  gotoxy(34,13);
  writeln('    QUIT    ');
  gotoxy(35,y);write('->');gotoxy(44,y);write('<-');
  repeat
    begin
      ch:=readkey;
    end;
  until (ch=#80) or (ch=#72) or (ch=#13) or(ch=#27);
  if ch=#72 then
  begin
    y:=y-1;if y<10 then y:=13;
  end;
  if ch=#80 then
  begin
    y:=y+1;if y>13 then y:=10;
  end;
  if ch=#27 then halt;
  IF ch=#13 then
  begin
    clrscr;
    case y of
      10: //
      begin
        y:=12;choose;
      end;
      13:halt;
      11: //
      begin
        write('Enter your speed (Default:6000) : ');readln(speed);writefile;
      end;
    end;
  end;
  menu;
end;
begin
  y := 10;
  menu;
end.
