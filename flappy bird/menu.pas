uses crt,dos;
var x,y:longint;
  ch:char;
begin
  clrscr;textbackground(green);
  y := 10;
  repeat
    begin
      clrscr;
      textcolor(white);
      gotoxy(34,10);
      writeln('    PLAY    ');
    {   gotoxy(34,11);
    writeln('    SHOP    ');
    gotoxy(34,12);
    writeln('    SKIN    ');}
      gotoxy(34,13);
      writeln('    QUIT    ');
      gotoxy(35,y);write('->');gotoxy(43,y);write('<-');
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72) or (ch=#13);
      if ch=#72 then
      begin
        y:=y-1;if y<10 then y:=13;
      end;
      if ch=#80 then
      begin
        y:=y+1;if y>13 then y:=10;
      end;
      IF ch=#13 then
      begin
        clrscr;
        case y of
          10: //
          begin
            clrscr;exec('play.exe','16000');swapvectors;
          end;{11:shop;12:skin;}
          13:halt
        end;
      end;
    end;
  until 1=2;
end.
