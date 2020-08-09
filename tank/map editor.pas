uses crt,mouse;
var f:text;
  xy:array[0..90,0..90] of integer;
  ch:char;
  i,j,x,y,lastx,lasty:integer;
  paint,click:boolean;
  mouseE:tmouseevent;
  a:array[0..100,0..100] of char;
begin
  initmouse;
  for i := 1 to 25 do for j:=1 to 80 do xy[j,i]:=0;
  repeat
    x := getmousex;y:=getmousey;
    if x>78 then x:=78;
    if y>24 then y:=24;
    gotoxy(lastx,lasty);write(' ');
    if a[lasty,lastx]<>'' then
    begin
      gotoxy(lastx,lasty);textcolor(green);write(a[lasty,lastx]);
    end;
    textcolor(14);gotoxy(x+1,y+1);write(char(178));lastx:=x+1;lasty:=y+1;
    if getmousebuttons=mouseleftbutton then
    begin
      a[y+1,x+1]:=char(219);textcolor(green);gotoxy(x+1,y+1);write(char(219));click:=true;
    end;
    if getmousebuttons=mouserightbutton then break;
    getmouseevent(mouseE);
    if keypressed then
    begin
      ch := readkey;
      case ch of
        'q': //
        begin
          if paint=false then paint:=true else paint:=false;
        end;
        'w': //
        begin
          xy[wherex,wherey]:=2;write(char(5));
        end;
        #72: //
        begin
          gotoxy(wherex,wherey-1);
        end;
        #77: //
        begin
          gotoxy(wherex+1,wherey);
        end;
        #80: //
        begin
          gotoxy(wherex,wherey+1);
        end;
        #75: //
        begin
          gotoxy(wherex-1,wherey);
        end;
      end;
      if wherex=80 then gotoxy(wherex-1,wherey);
      if wherey>23 then gotoxy(wherex,wherey-1);
      if paint then
      begin
        write(char(219));gotoxy(wherex-1,wherey);xy[wherex,wherey]:=1;
      end;
    end;
  until ch='e';
  assign(f,'map.txt');
  rewrite(f);
  for i:=1 to 25 do
  begin
    for j := 1 to 80 do if a[i,j]=char(219) then write(f,1) else write(f,0);
    writeln(f,'');
  end;
  close(f);
end.
