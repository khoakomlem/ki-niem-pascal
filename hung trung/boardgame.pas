uses crt;
var y,y2,xtrung,trung,dokho,mucdo,mucdo2,mucdo3,i,
  trungroi,x,c,color1,color2,color3,color4,color5,
  tien,diem,n,m,e,e2,tien2,k,tangtoc,p,mautrung,r,
  health,wave,time,muctieu1,muctieu2,tienthuong,
  level,time2,shooting,mauboss,dem,yboss,shoot,
  bossban,clear,mau,xboss,move,xmau,ptmau,ts,rank2
  ,ranking,dame,dame2,tank2,re:longint;
  ch:char;
  rank:string;
  firsttimeplay:boolean;
  f:text;
procedure menu;
procedure boss;
procedure saving;
begin
  assign(f,'SAVE GAME.txt');
  rewrite(f);
  write(f,tien,' ',diem,' ',wave,' ',ranking);
  close(f);
end;
procedure win;
begin
  clrscr;
  ptmau := 10;
  inc(tank2);
  dame2 := dame2+3;
  tienthuong := 1000;
  inc(ts);
  if (ts>3) and (rank2<>5) then
  begin
    ts:=1;inc(rank2);
  end;
  if rank2>5 then rank2:=5;
  case rank2 of
    0:rank:='DONG';
    1:rank:='BAC';
    2:rank:='VANG';
    3:rank:='BACK KIM';
    4:rank:='KIM CUONG';
    5:rank:='CAO THU';
  end;
  gotoxy(25,10);
  write('CONGRATUATION! YOU WIN, + ',tienthuong,'$');
  gotoxy(35,11);write(rank,': ',ts,'*');
  tien := tien+1000;
  ranking := rank2*3+ts;
  saving;
  delay(2500);
  clrscr;
end;
procedure lose;
begin
  clrscr;
  dec(ts);if (ts<0) and (rank='DONG') then ts:=1;
  if ts<0 then
  begin
    dec(rank2);ts:=3;
  end;
  ptmau := 10;
  mau := 0;
  mau := mau+tank2+dame2+100+dame;
  if rank2<0 then rank2:=0;
  case rank2 of
    0:rank:='DONG';
    1:rank:='BAC';
    2:rank:='VANG';
    3:rank:='BACK KIM';
    4:rank:='KIM CUONG';
    5:rank:='CAO THU';
  end;
  gotoxy(30,10);
  write('GAME OVER OC`s CHO`s!');
  gotoxy(35,11);write(rank,': ',ts,'* (-1*)');
  delay(2500);clrscr;
end;
begin
  ptmau := 10;
  mauboss  := 100;
  mau      := 100;
  shooting := 21;
  repeat
    gotoxy(65,2);write('BOSS dame: ',dame2);
    gotoxy(65,3);write('BOSS tank: ',tank2);
    gotoxy(65,4);write('MY dame: ',dame);
    saving;
    ranking := rank2*3+ts;
    gotoxy(41,25);write(mauboss,'%');
    case (mauboss div 10) of
      1:ptmau:=1;
      2:ptmau:=2;
      3:ptmau:=3;
      4:ptmau:=4;
      5:ptmau:=5;
      6:ptmau:=6;
      7:ptmau:=7;
      8:ptmau:=8;
      9:ptmau:=9;
    end;
    for xmau:=37 to ptmau+37 do
    begin
      gotoxy(xmau+1,24);write('   ');
      gotoxy(xmau,24);write(char(177));
    end;
    if mauboss<1 then
    begin
      win;mau:=mau+80;delay(1000);mauboss:=100;
    end;
    if mau<1 then
    begin
      mau:=100;lose;delay(1000);mauboss:=100;
    end;
    inc(clear);
    if clear=500 then
    begin
      clear:=1; clrscr;
    end;
    inc(move);
    if move=35 then
    begin
      move := 1;
      if (x+3)>=xboss then dec(xboss) else if (x+3)<=xboss then inc(xboss);
      if xboss>74 then xboss:=xboss-7;
      if xboss<6 then xboss:=xboss+7;
      gotoxy(xboss,3);
      write(' ',char(240),' ');
      gotoxy(wherex-3,wherey+1);
      write(' ',char(157),' ');
    end;
    begin
      gotoxy(x+1,23);
      write(' ',mau,'% ');
      inc(bossban);
      if bossban=100 then
      begin
        bossban := 1;
        randomize;shoot:=random(2);if shoot=1 then
        begin
          mau:=mau-random(20)-1-dame2;
          for yboss:=1 to 19 do
          begin
            delay(10);
            gotoxy(x+3,yboss-1);write(' ');
            gotoxy(x+3,yboss);write(char(31));
          end;
        end;
      end;
      inc(dem);
      if dem=3 then
      begin
        dec(shooting);gotoxy(x+1,shooting);
        write('  ',char(127),'  ');gotoxy(x+2,shooting-1);write('   ');gotoxy(x+2,shooting+1);write('   ');
        dem := 1;if ((x+3)=(xboss+1)) and (shooting<5) then
        begin
          if xboss=6 then xboss:=xboss+3 else if xboss=74 then xboss:=xboss-3;mauboss:=mauboss-random(15)-1+tank2-dame;
        end;
      end;
      if shooting=3 then shooting:=21;
      delay(10);
      gotoxy(x-1,22);write('  ');
      gotoxy(x+6,22);write('  ');
      textcolor(color1); gotoxy(x+1,22);write(char(219));
      textcolor(color2); gotoxy(x+2,22);write(char(219));
      textcolor(color3); gotoxy(x+3,22);write(char(219));
      textcolor(green);  gotoxy(x+1,21);write('  ',char(234),'  ');
      textcolor(color4); gotoxy(x+4,22);write(char(219));
      textcolor(color5); gotoxy(x+5,22);write(char(219));
      textcolor(black);
      if keypressed then
      begin
        ch:=' ';ch:=readkey;
        if ch=#32 then
        begin
          if tangtoc=1 then tangtoc:=2 else tangtoc:=1;
        end;
        if ch=#75 then
        begin
          x:=x-tangtoc;if x<0 then x:=0;
        end;
        if ch=#77 then
        begin
          x:=x+tangtoc;if x>75 then x:=75;
        end;
      end;
    end;
  until 1=2;
end;
procedure saving;
begin
  assign(f,'SAVE GAME.txt');
  rewrite(f);
  write(f,tien,' ',diem,' ',wave);
  close(f);
end;
procedure clear;
begin
  time       := 2000;
  level      := 0;
  muctieu1   := 100;
  muctieu2   := 0;
  time2      := 0;
  wave       := 1;
  health     := 5;
  tienthuong := 0;
  menu;
end;
procedure nextwave;
begin
  level    := level+10;
  muctieu2 := 0;
  muctieu1 := 100+level;
  inc(wave);
  time2 := time2+100;
  if time2>1000 then time2:=1000;
  time := 2000-time2;
end;
procedure win;
begin
  clrscr;
  gotoxy(25,10);
  muctieu2   := 0;
  muctieu1   := 100+level;
  tienthuong := tienthuong+50;
  write('CONGRATUATION! YOU WIN, + ',tienthuong,'$');
  tien := tien+tienthuong;
  delay(2000);
  clrscr;
end;
procedure lose;
begin
  clrscr;
  gotoxy(30,10);
  time     := 2000-time2;
  muctieu2 := 0;
  write('GAME OVER OC`s CHO`s!');
  delay(2000);
  clrscr;
  menu;
end;
procedure huongdan;
begin
  write('xai cac nut ',char(27),' ',char(26),' de di chuyen thanh hung trung va xai nut cach (backspace)');
  writeln(' de bat tang toc cho thanh nhung trung, bam them lan nua de tat tang toc. Bam ENTER de tiep tuc . . .');
  readln;
  menu;
end;
procedure campain;
begin
  repeat
    begin

      saving;
      IF wave=10 then boss;
      dokho    := 0;
      trungroi := 1;
      randomize;
      xtrung   := random(73)+2;
      trung    := random(4)+1;
      mautrung := 5;
      for i:=mucdo3{*1} to mucdo2{*22} do
      begin
        if trungroi=20 then
        begin
          n := x;
          m := (x+6);
          if (xtrung>n) and (xtrung<m) then
          begin
            trungroi:=1;
            case trung of
              1: //
              begin
                muctieu2:=muctieu2+20;diem:=diem+20;
              end;
              2: //
              begin
                muctieu2:=muctieu2+50;diem:=diem+50;
              end;
              3: //
              begin
                tien:=tien+50;inc(health);
              end;
              4,5: //
              begin
                health:=health-5;muctieu2:=muctieu2-10;
              end;
            end;
            if health<1 then lose;
            campain;
          end;
        end;
        delay(10);
        gotoxy(x-1,20);write('  ');
        gotoxy(x+6,20);write('  '); textcolor(color1);
        gotoxy(x+1,20);write(char(219));textcolor(color2);
        gotoxy(x+2,20);write(char(219));textcolor(color3);
        gotoxy(x+3,20);write(char(219));textcolor(color4);
        gotoxy(x+4,20);write(char(219));textcolor(color5);
        gotoxy(x+5,20);write(char(219));
        textcolor(black);
        begin
          dokho := dokho+1;
          if dokho=mucdo then
          begin
            trungroi := trungroi+1;
            dokho    := 1;
          end;
          if trungroi=24 then
          begin
            Sound ( 150 );delay(400);
            if trung =1 then
            begin
              gotoxy(xtrung-1,trungroi-1);textcolor(14);write(',,,');
            end;
            if trung =2 then
            begin
              gotoxy(xtrung-2,trungroi-1);textcolor(14);write(',,,,,');
            end;
            if trung =3 then
            begin
              gotoxy(xtrung-1,trungroi-1);textcolor(green);write('***');
            end;
            if (trung =4) or (trung=5) then
            begin
              gotoxy(xtrung-3,trungroi-1);textcolor(red);write('|||||||');
            end;
            campain;
          end;
          gotoxy(xtrung,trungroi);
          textcolor(mautrung);
          case trung of
            1:write('o');
            2:write('O');
            3:write('$');
            4:write('0');
            5:write('0');
          end;
          textcolor(black);
          gotoxy(xtrung,trungroi-1);
          write(' ');
          gotoxy(70,2);
          write('health: ',health,' ');
          gotoxy(63,3);
          write('Muc tieu: ',muctieu2,'/',muctieu1);
          gotoxy(70,4);
          write('Tien: ',tien);
          if tangtoc=2 then
          begin
            gotoxy(63,5);write('Tang toc: Dang bat');
          end
          else
          begin
            gotoxy(63,5);write('Tang toc: Dang tat')
          end;
          gotoxy(65,6);
          write('Bam ECS de thoat');
          gotoxy(60,1);
          write('WAVE: ',wave,'  TIMES: ',time,' ');
          time := time-1;
          if (muctieu2 >= muctieu1) and (firsttimeplay=true) then
          begin
            win;nextwave;
          end
          else if muctieu2 >= muctieu1 then
          begin
            win;nextwave;
          end;
          if time=0 then lose;
          if keypressed then
          begin
            ch:=' ';ch:=readkey;
            if ch=#32 then
            begin
              if tangtoc=1 then tangtoc:=2 else tangtoc:=1;
            end;
            if ch=#27 then
            begin
              muctieu2:=0;time:=2000-time2;menu;
            end;
            if ch=#75 then
            begin
              x:=x-tangtoc;if x<0 then x:=0;
            end;
            if ch=#77 then
            begin
              x:=x+tangtoc;if x>75 then x:=75;
            end;
          end;
        end;
      end;
    end;
  until 1=2;
end;
procedure survival;
begin
  repeat
    begin
      saving;
      dokho    := 0;
      trungroi := 1;
      randomize;
      xtrung   := random(74)+1;
      trung    := random(4)+1;
      mautrung := 5;
      for i:=mucdo3{*1} to mucdo2{*22} do
      begin
        if trungroi=20 then
        begin
          n := x;
          m := (x+6);
          if (xtrung>n) and (xtrung<m) then
          begin
            trungroi:=1;
            case trung of
              1:diem:=diem+10;
              2:diem:=diem+50;
              3: //
              begin
                tien:=tien+50;inc(health);
              end;
              4:health:=health-5;
              5:health:=health-5;
            end;
            if health<1 then lose;
            survival;
          end;
        end;
        delay(10);
        gotoxy(x-1,20);write('  ');
        gotoxy(x+6,20);write('  '); textcolor(color1);
        gotoxy(x+1,20);write(char(219));textcolor(color2);
        gotoxy(x+2,20);write(char(219));textcolor(color3);
        gotoxy(x+3,20);write(char(219));textcolor(color4);
        gotoxy(x+4,20);write(char(219));textcolor(color5);
        gotoxy(x+5,20);write(char(219));
        textcolor(black);
        begin
          dokho := dokho+1;
          if dokho=mucdo then
          begin
            trungroi := trungroi+1;
            dokho    := 1;
          end;
          if trungroi=24 then
          begin
            if trung =1 then
            begin
              gotoxy(xtrung-1,trungroi-1);textcolor(14);write(',,,');
            end;
            if trung =2 then
            begin
              gotoxy(xtrung-2,trungroi-1);textcolor(14);write(',,,,,');
            end;
            if trung =3 then
            begin
              gotoxy(xtrung-1,trungroi-1);textcolor(green);write('***');
            end;
            if (trung =4) or (trung=5) then
            begin
              gotoxy(xtrung-3,trungroi-1);textcolor(red);write('|||||||');
            end;

            survival;
          end;
          gotoxy(xtrung,trungroi);
          textcolor(mautrung);
          case trung of
            1:write('o');
            2:write('O');
            3:write('$');
            4:write('0');
            5:write('0');
          end;
          textcolor(black);
          gotoxy(xtrung,trungroi-1);
          write(' ');
          gotoxy(70,2);
          write('health: ',health);
          gotoxy(70,3);
          write('Diem: ',diem);
          gotoxy(70,4);
          write('Tien: ',tien);
          if tangtoc=2 then
          begin
            gotoxy(63,5);write('Tang toc: Dang bat');
          end
          else
          begin
            gotoxy(63,5);write('Tang toc: Dang tat')
          end;
          gotoxy(65,6);
          write('Bam ECS de thoat');
          if keypressed then
          begin
            ch:=' ';ch:=readkey;
            if ch=#32 then
            begin
              if tangtoc=1 then tangtoc:=2 else tangtoc:=1;
            end;
            if ch=#27 then menu;
            if ch=#75 then
            begin
              x:=x-tangtoc;if x<0 then x:=0;
            end;
            if ch=#77 then
            begin
              x:=x+tangtoc;if x>75 then x:=75;
            end;
          end;
        end;
      end;
    end;
  until 1=2;
end;
procedure muc;
begin
  repeat
    begin
      clrscr;
      textcolor(black);
      writeln('       De       ');
      writeln('   Trung binh   ');
      writeln('       Kho       ');
      gotoxy(1,y);write('->');gotoxy(15,y);write('<-');
      ch := readkey;
      if ch=#13 then
      begin
        clrscr;
        if y=1 then
        begin
          mucdo2:=15;mucdo3:=15;mucdo:=15;
        end;
        if y=2 then
        begin
          mucdo2:=10;mucdo3:=10;mucdo:=10;
        end;
        if y=3 then
        begin
          mucdo2:=7;mucdo3:=7;mucdo:=7;
        end;
        mucdo2 := mucdo2*22;
        menu;
      end;
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72) or (ch=#13);
      if ch=#72 then
      begin
        y:=y-1;if y<1 then y:=3;gotoxy(1,y);
      end;
      if ch=#80 then
      begin
        y:=y+1;if y>3 then y:=1;gotoxy(1,y);
      end;
    end;
  until 1=2;
end;
procedure skin;
begin
  clrscr;
  repeat
    begin
      tien2 := 0;
      gotoxy(2,1);
      textcolor(0);
      writeln('chon mau thanh hung trung               so tien cua ban: ',tien,'$');
      for c:=2 to 15 do
      begin
        gotoxy(k,18);write(char(25));gotoxy(k,20);write(char(24));
        gotoxy(3,19);
        textcolor(color1);write(char(219));
        textcolor(color2);write(char(219));
        textcolor(color3);write(char(219));
        textcolor(color4);write(char(219));
        textcolor(color5);write(char(219));
        textcolor(c);
        gotoxy(7,c);write(char(219));write(char(219));write(char(219));textcolor(black);gotoxy(14,c);write(tien2,'$');
        tien2 := tien2+20;
      end;
      gotoxy(4,y2);write('->');gotoxy(11,y2);write('<-');
      ch := readkey;
      if ch=#13 then
      begin
        clrscr;
        tien2 := (y2-2)*20;
        if tien+1>tien2 then
        begin
          tien := tien-tien2;
          if p=1 then color1 := y2;
          if p=2 then color2 := y2;
          if p=3 then color3 := y2;
          if p=4 then color4 := y2;
          if p=5 then
          begin
            color5 := y2;p:= 1;menu;
          end;
          p := p+1;
          k := k+1;
        end;
        skin;
      end;
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72) or (ch=#13);
      if ch=#72 then
      begin
        y2:=y2-1;if y2<2 then y2:=15;
      end;
      if ch=#80 then
      begin
        y2:=y2+1;if y2>15 then y2:=2;
      end;
      clrscr;
    end;
  until 1=2;
end;
begin
  k := 3;
  y := 1;
  if r=1 then
  begin
    r :=2;huongdan;
  end;
  if e=1 then
  begin
    e:=2;muc;
  end;
  if e2=1 then
  begin
    e2:=2;skin;
  end;
  clrscr;
  repeat
    begin
      saving;
      clrscr;
      health := 5;
      textcolor(black);
      writeln('    CAMPAIN     ');
      writeln('    SURVIVAL     ');
      writeln('    MUC DO    ');
      writeln('     SKIN     ');
      writeln(' CLEAR CAMPAIN');
      writeln('     QUIT     ');
      gotoxy(1,y);write('->');gotoxy(14,y);write('<-');
      ch := readkey;
      if ch=#13 then
      begin
        clrscr;
        if y=1 then campain;
        if y=2 then survival;
        if y=3 then muc;
        if y=4 then skin;
        if y=5 then clear;
        if y=6 then halt;
      end;
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72) or (ch=#13);
      if ch=#72 then
      begin
        y:=y-1;if y<1 then y:=6;gotoxy(1,y);
      end;
      if ch=#80 then
      begin
        y:=y+1;if y>6 then y:=1;gotoxy(1,y);
      end;
    end;
  until 1=2;
end;
begin
  rank          := 'DONG';
  firsttimeplay := false;
  health        := 5;
  tien2         := 0;
  x             := 2;
  y2            := 2;
  y             := 2;
  k             := 3;
  p             := 1;
  tangtoc       := 1;
  e             := 1;
  e2            := 1;
  r             := 1;
  assign(f,'SAVE GAME.txt');
  reset(f);
  readln(f,tien,diem,wave,ranking);
  close(f);
  if (tien=0) and (diem=0) and (wave=0) then
  begin
    firsttimeplay:=true;wave:=1;
  end;
  for m := 1 to wave do
  begin
    time2:=time2+100;level:=level+10;tienthuong:=tienthuong+50;
  end;
  for m := 1 to ranking do
  begin
    inc(dame2);inc(tank2);
  end;
  rank2 := ranking div 3;
  if rank2>5 then rank2:=5;
  case rank2 of
    0:rank:='DONG';
    1:rank:='BAC';
    2:rank:='VANG';
    3:rank:='BACK KIM';
    4:rank:='KIM CUONG';
    5:rank:='CAO THU';
  end;
  if rank='CAO THU' then ts:=ranking-15 else ts:=ranking div 3;
  time     := 2000-time2;
  muctieu1 := 100;
  shooting := 22;
  textbackground(white);
  clrscr;
  textcolor(black);
  menu;
end.
