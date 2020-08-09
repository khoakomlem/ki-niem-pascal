uses crt;
var colorid,a1,s1,d1,money,change,price,i,i1,count,dk,tim,x,y,build,build2,damage,boss,wood,trudamage,slow,double,critical,boss2,tank,speed,die,fast,xboss,yboss,level,fast2:longint;
  ch:char;
  st,detail,color:string;
  a,s,d:boolean;
procedure menu;
procedure skin;
begin
  repeat
    begin
      clrscr;
      case colorid of
        0:color:='Black';
        1:color:='Blue';
        2:color:='Green';
        3:color:='Glaucous';
        4:color:='Red';
        5:color:='Violet';
        6:color:='Brown';
        7:color:='Light gray';
        8:color:='Dark gray';
        9:color:='Light blue';
        10:color:='Light up';
        11:color:= 'Light gray';
        12:color:='Light red';
        13:color:='Bright purple';
        14:color:='Gold';
        15:color:='White';
      end;
      gotoxy(32,1);write('BACKGROUND COLOR');
      gotoxy((80-length(color)) div 2,12);write(color);
      ch := readkey;
      case ch of
        #75:dec(colorid);
        #77:inc(colorid);
      end;
      if colorid>15 then colorid:=0;
      if colorid<0 then colorid:=15;
      clrscr;textbackground(colorid);
    end;
  until ch=#13;
end;
procedure shop;

begin
  change := 1;
  clrscr;
  repeat
    begin
      gotoxy(1,1);write(char(27),' Press ESC to Exit');
      gotoxy(30,1);
      write('WELCOME TO THE SHOP!');
      gotoxy(28,2);write('Your bag: a:',a1,'  b:',s1,'  c:',d1,'          ');
      gotoxy(20,11);
      write(char(17));
      gotoxy(50,11);
      write(char(16));
      case change of
        1: //
        begin
          detail:='- 75% tank of the monster';price := 20;st:='a';
        end;
        2: //
        begin
          detail:='- 75% speed of the monster';price:=50;st:='s';
        end;
        3: //
        begin
          detail:='+Double your current damage';price:=100;st:='d';
        end;
      end;
      gotoxy((80-length(detail)) div 2,8);
      write(detail);
      gotoxy(32,10);write('Your money: ',money);
      gotoxy(30,11);
      write('Unlock [',st,'] - <',price,'>');
    end;
    ch := readkey;        clrscr;
    clrscr;
    case ch of
      #77: //
      begin
        inc(change);if change >3 then change:=1;
      end;
      #75: //
      begin
        dec(change);if change <1 then change:=3;
      end;
      #13: //
      begin
        gotoxy(30,13); if (money-price)>-1 then
        begin
          write('successfully purchase!'); dec(money,price);
          case change of 1:
            begin
              inc(a1);a:=true;
            end
            ;2: //
            begin
              inc(s1);s:=true;
            end
            ;3: //
            begin
              inc(d1);d:=true;
            end;
          end;
        end
        else write('purchase failed');
      end;
    end;
  until ch = #27;
end;
procedure build3;
begin
  textcolor(white);
  gotoxy(x-1,y+1);
  randomize;
  case build of
    1 : //
    begin
      write('~@~');dec(wood,3);slow:=slow+random(7);slow:=slow+1;inc(damage,random(5)+1);
    end;
    2: //
    begin
      write('<#>');dec(wood,4);double:=random(8);damage:=damage+((double+5)*2);
    end;
    3: //
    begin
      write('O+O');dec(wood,5);damage:=damage+random(20)+10;Dec(tank,random(10));
    end;
    4: //
    begin
      write('^_^');dec(wood,6);dec(tank,10);inc(slow,10);inc(damage,10);
    end;
  end;
  if build<>0 then x:=x+10;
end;
procedure drawmap;
begin
  gotoxy(1,1);
  write('money: ',money,'$');
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
  textcolor(green);
  for i1:=4 to 5 do
  for i:=2 to 79 do
  begin
    gotoxy(i,i1);
    write(char(219));
    gotoxy(i,i1+18);
    write(char(219));
  end;
  for i:=77 to 79 do
  for i1:=4 to 16 do
  begin
    gotoxy(i,i1);
    write(char(219));
  end;
  for i1:=16 to 17 do
  for i:=79 downto 12 do
  begin
    gotoxy(i,i1);
    write(char(219));
  end;
  for i1:=2 to 3 do
  for i:=11 to 22 do
  begin
    gotoxy(i1,i);
    write(char(219));
  end;
  for i:=2 to 68 do
  for i1:=10 to 11 do
  begin
    gotoxy(i,i1);
    write(char(219));
  end;
  textcolor(red);
  for i1:=1 to 3 do
  for i:=21 downto 18 do
  begin
    gotoxy(78,i);
    write(char(176));
  end;
  i1 := -5;
  textcolor(green);
  for i:=1 to 8 do
  begin
    i1 := i1 +10;
    gotoxy(i1,5);
    write(char(15));
    gotoxy(i1,23);
    write(char(15));
  end;
  i1 := 5;
  for i:=1 to 6 do
  begin
    i1 := i1+10;
    gotoxy(i1,11);
    write(char(15));
    gotoxy(i1,17);
    write(char(15));
  end;
  gotoxy(5,11);
  write(char(15));
  gotoxy(75,17);
  write(char(15));
  i := 7;
end;
procedure monster;
begin
  if (speed+slow)<2 then
  begin
    speed:=0;speed:=speed-slow;inc(speed);
  end;
  if count=(speed+slow) then
  begin
    if (xboss<>72) and (yboss=7) then
    begin
      xboss:=xboss+1;dk:=2;
    end;
    if (xboss=72) and (yboss<13) then yboss:=yboss+1;
    if (yboss=13) and (xboss>7) then xboss:=xboss-1;
    if dk=1 then
    if (xboss=7) and (yboss<19) then yboss:=yboss+1;
    if (yboss=19) and (xboss<81) then xboss:=xboss+1;
    if xboss=79 then
    begin
      tim:=tim-1;xboss:=2;yboss:=7;count:=0;
    end;
    if tim=0 then menu;
    count := 0;
    dk  := 1;
  end;
  textcolor(yellow);
  gotoxy(xboss,yboss);
  write(' ',char(2),' ');
  gotoxy(xboss,yboss-1);write('   ');
  gotoxy(xboss,yboss+1);write('   ');
end;
procedure play;
begin
  gotoxy(32,25);write('a: ',a1,'  s: ',s1,'  d: ',d1);
  delay(fast);
  gotoxy(1,1); write('Wood: ',wood,char(5),'    ');
  gotoxy(15,2);write('Press BackSpace when fulled');
  gotoxy(15,1);write('My Damage: ',damage,'  ');
  gotoxy(35,1);write('BOSS : ',boss,'    ');
  gotoxy(50,1);write('Money: ',money+die);
  gotoxy(70,1);write('Fast x',fast2,'  ');
  gotoxy(45,2);write('Running speed:',100-speed-slow,'  ');
  gotoxy(70,2);write('Tank:',tank,'  ');
  gotoxy(2,2);write(tim,char(3));
  if boss<1 then
  begin
    tank:=tank+random(10)+1;count:=0;dec(speed,random(3)+3);wood:=wood+random(3)+2;boss2:=boss2+10+tank;boss:=boss+boss2;boss:=boss+100;xboss:=2;yboss:=7;inc(die);inc(money);
  end
  else monster;
  trudamage := trudamage+1;
  if trudamage=200 then
  begin
    boss := boss-(damage-tank);trudamage:=0;
  end;
  count := count+1;
  textcolor(white);
  gotoxy(x,y);
  write(char(31));
  if keypressed then
  begin
    ch:=' ';ch:=readkey;
    gotoxy(x,y);
    textcolor(green);
    write(char(219));
    case upcase(ch) of
      'Q': //
      begin
        if ((wood-3)>=0) then build:=1;build3;
      end;
      'W': //
      begin
        if ((wood-4)>=0) then build:=2;build3;
      end;
      'E': //
      begin
        if ((wood-5)>=0) then build:=3;build3;
      end;
      'R': //
      begin
        if ((wood-6)>=0) then build:=4;build3;
      end;
    end;
    build := 0;
  end;
  if keypressed then
  begin
    ch:=' ';ch:=readkey;
    case upcase(ch) of
      'X': //
      begin
        fast2:=fast2*2;dec(fast,5);if fast<0 then fast:=10;if fast2>8 then fast2:=2;
      end;
      'A': //
      begin
        dec(a1);if a then dec(tank,(tank*75) div 100) else inc(a1);if a1=0 then a:=false;
      end;
      'S': //
      begin
        dec(s1);if s then inc(slow,15) else inc(s1);if s1=0 then s:=false;
      end;
      'D': //
      begin
        dec(d1);if d then inc(damage,damage div 2)          else inc(d1);if d1=0 then d:=false;
      end;
      #13: //
      begin
        gotoxy(24,12);textcolor(White);write('PAUSED, press ENTER to continue');
        repeat
          ch:=readkey;
        until ch=#13;gotoxy(24,12);write('                               ');
      end;
      #32:if build2=1 then
      begin
        inc(level,20);damage:=0;wood:=wood+50+level;build2:=0;x:=5;y:=4;damage:=0;clrscr;drawmap;
      end;
      #27:menu;
    end;
  end;
  if (x>75) and (y=4) then
  begin
    x:=5;y:=10;play;
  end;
  if (x>65) and (y=10) then
  begin
    x:=15;y:=16;play;
  end;
  if (x>75) and (y=16) then
  begin
    x:=5;y:=22;play;
  end;
  if (x>75) and (y=22) then
  begin
    build2:=1;
  end;
  if y<4 then y:=4;
  if y>22 then y:=22;
  if (x=75) and (y=10)then x:=65;
  if (x=5) and (y=16)then x:=15;
  play;
end;
procedure restore;
begin
  slow   := 0;
  count  := 0;
  speed  := 15;
  tank   := 0;
  wood   := 10;
  tim    := 3;
  damage := 0;
  level  := 0;
  boss   := 50;
  xboss  := 2;
  yboss  := 7;
  boss2  := 0;
  i1     := 6;
  i      := 10;
  x      := 5;
  y      := 4;
end;
begin
  clrscr;
  y := 10;
  clrscr;
  repeat
    begin
      textcolor(white);
      gotoxy(34,10);
      writeln('    PLAY    ');
      gotoxy(34,11);
      writeln('    SHOP    ');
      gotoxy(34,12);
      writeln('    SKIN    ');
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
        case y of 10:
          begin
            restore;y:=4;drawmap;play;
          end
          ;11:shop;12:skin;13:halt;
        end;
      end;
    end;
  until 1=2;
end;
begin
  textbackground(colorid);
  textcolor(white);clrscr;
  write('Press the buttons |Q|(-2$)  |W|(-4$)  |E|(-5$)  |R|(-6$) to build a tower, press [X] to double your game speed');
  write('Q: slow the monster ,   W: Increase your dammage a lot ,   E:Increase your dammage very much if you lucky haha ');
  writeln('Press ENTER to continue . . .');
  readln;clrscr;
  fast2   := 2;
  fast    := 10;
  boss2   := 0;
  build   := 0;
  wood    := 10;
  speed   := 15;
  damage  := 0;
  boss    := 50;
  x       := 5;y:=4;
  tim     := 3;
  xboss   := 2;
  yboss   := 7;
  i1      := 6;
  i       := 10;
  money   := 0;
  colorid := 0;
  menu;
  readln
end.
