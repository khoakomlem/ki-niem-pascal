USES crt;
VAR ten:STRING;files,t:string;cauhoi,tien,r,goidien,tuvan,nammuoi,unlock,ar,br,cr,dr,r1,r2,r3,khaosat,y,load,color,loadi:integer;f:text;ch:char;
procedure loading;
begin
  for load:=1 to 2000 do
  begin
    color := color+1;
    if color>15 then color:=1;
    if color<1 then color:=15;
    textbackground(color);
    write(char(178));
  END;
  write('                         Da khoi tao man hinh xong');
  delay(3000);
  for load:=1 to 2000 do
  begin
    color := color+1;
    if color>15 then color:=1;
    if color<1 then color:=15;
    textbackground(color);
    write(char(178));
  END;
  for load:=1 to 20 do
  begin
    loadi := loadi+5;
    gotoxy(20,50);
    write('                               | LOADING |  ',loadi,'%');delay(50);clrscr;
    gotoxy(20,50);
    write('                               / LOADING /  ',loadi,'%');delay(50);clrscr;
    gotoxy(20,50);
    write('                               - LOADING -  ',loadi,'%');delay(50);clrscr;
    gotoxy(20,50);
    write('                               | LOADING \  ',loadi,'%');delay(50); clrscr;
  end;
end;
procedure cauhoi1;
procedure khaosatnguoichoi;
begin
  if khaosat <> 2 then
  begin
    randomize;
    r1 := random(60);
    r2 := random(60);
    r3 := random(60);
    if cauhoi=0 then ar:=random(100);
    if cauhoi=1 then br:=random(100);
    if cauhoi=2 then cr:=random(100);
    if cauhoi=3 then dr:=random(100);
    if cauhoi=4 then cr:=random(100);
    if cauhoi=5 then br:=random(100);
    if cauhoi=6 then ar:=random(100);
    if cauhoi=7 then cr:=random(100);
    if cauhoi=8 then dr:=random(100);
    if cauhoi=9 then cr:=random(100);
    if cauhoi=10 then ar:=random(100);
    if cauhoi=11 then cr:=random(100);
    if cauhoi=12 then br:=random(100);
    if cauhoi=13 then ar:=random(100);
    if cauhoi=14 then ar:=random(100);
    if ar<40 then ar:=ar+30;
    if br<40 then br:=br+30;
    if cr<40 then cr:=br+30;
    if dr<40 then dr:=br+30;
    if cauhoi=0 then
    begin
      br:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=1 then
    begin
      ar:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=2 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=3 then
    begin
      br:=r1;cr:=r2;ar:=r3;
    end;
    if cauhoi=4 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=5 then
    begin
      ar:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=6 then
    begin
      br:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=7 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=8 then
    begin
      br:=r1;cr:=r2;ar:=r3;
    end;
    if cauhoi=9 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=10 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=11 then
    begin
      br:=r1;ar:=r2;dr:=r3;
    end;
    if cauhoi=12 then
    begin
      ar:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=13 then
    begin
      br:=r1;cr:=r2;dr:=r3;
    end;
    if cauhoi=14 then
    begin
      br:=r1;cr:=r2;dr:=r3;
    end;
    writeln('A: ',ar,'%  |  B: ',br,'%  |  C: ',cr,'%  |  D: ',dr,'%');
    writeln('Bam ENTER de tiep tuc . . .');
    readln;
    khaosat := 2;
    clrscr;
    cauhoi1;
  end
  else
  begin
    writeln('Ban da su dung tro giup nay, bam ENTER de tiep tuc . . .');
    readln;
    clrscr;
    cauhoi1;
  end;
end;
procedure tuvantaicho;
begin
  if tuvan<>2 then
  begin
    if unlock=2 then
    begin
      if cauhoi=0 then writeln('Nguoi choi 1:A     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=1 then writeln('Nguoi choi 1:B     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=2 then writeln('Nguoi choi 1:C     nguoi choi 2: C     nguoi choi 3: B');
      if cauhoi=3 then writeln('Nguoi choi 1:D     nguoi choi 2: D     nguoi choi 3: D');
      if cauhoi=4 then writeln('Nguoi choi 1:C     nguoi choi 2: B     nguoi choi 3: A');
      if cauhoi=5 then writeln('Nguoi choi 1:B     nguoi choi 2: B     nguoi choi 3: B');
      if cauhoi=6 then writeln('Nguoi choi 1:A     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=7 then writeln('Nguoi choi 1:C     nguoi choi 2: C     nguoi choi 3: C');
      if cauhoi=8 then writeln('Nguoi choi 1:D     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=9 then writeln('Nguoi choi 1:C     nguoi choi 2: C     nguoi choi 3: C');
      if cauhoi=10 then writeln('Nguoi choi 1:A     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=11 then writeln('Nguoi choi 1:C     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=12 then writeln('Nguoi choi 1:B     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=13 then writeln('Nguoi choi 1:A     nguoi choi 2: A     nguoi choi 3: B');
      if cauhoi=14 then writeln('Nguoi choi 1:B     nguoi choi 2: A     nguoi choi 3: A');
      writeln('Bam ENTER de tiep tuc');
      readln;
      tuvan := 2;
      clrscr;
      cauhoi1;
    end
    else
    begin
      writeln('Ban chua unlock no, bam ENTER de tiep tuc . . .');
      readln;
      clrscr;
      cauhoi1;
    end;
  end
  else
  begin
    writeln('Ban da su dung tro giup nay, bam ENTER de tiep tuc . . .');
    readln;
    clrscr;
    cauhoi1;
  end;
end;
procedure goidienthoaichonguoithan;
begin
  if goidien <> 2 then
  begin
    writeln('1.Ngo Bao Chau     2.Ho Chi Minh     3.Dau Khoa');
    repeat
      begin
        ch := readkey;
      end;
    until (ch='1') or (ch='2') or (ch='3');
    randomize;
    r := random(10);
    if r =6 then
    begin
      randomize;
      r := random(4);
      if r =0 then writeln('Toi khong biet');
      if r =1 then writeln('Toi khong biet');
      if r =2 then writeln('Toi khong biet');
      if r =3 then writeln('Toi khong biet');
      readln;
      cauhoi1;
    end
    else
    begin
      if cauhoi =0 then write('Dap an la A');
      if cauhoi =1 then write('Dap an la B');
      if cauhoi =2 then write('Dap an la C');
      if cauhoi =3 then write('Dap an la D');
      if cauhoi =4 then write('Dap an la C');
      if cauhoi =5 then write('Dap an la B');
      if cauhoi =6 then write('Dap an la A');
      if cauhoi =7 then write('Dap an la C');
      if cauhoi =8 then write('Dap an la D');
      if cauhoi =9 then write('Dap an la C');
      if cauhoi =10 then write('Dap an la A');
      if cauhoi =11 then write('Dap an la C');
      if cauhoi =12 then write('Dap an la B');
      if cauhoi =13 then write('Dap an la A');
      if cauhoi =14 then write('Dap an la A');
      writeln('. Bam ENTER de tiep tuc . . .');
      readln;
      goidien := 2;
      clrscr;
      cauhoi1;
    END;
  end
  else
  begin
    writeln('Tro giup ban da su dung! Bam ENTER de tiep tuc . . .');readln;clrscr;cauhoi1;
  end;
end;
procedure nammuoinammuoi;
begin
  if nammuoi <> 2 then
  begin
    if cauhoi =0 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =1 then write('Hai dap an bi loai bo la: A,C ');
    if cauhoi =2 then write('Hai dap an bi loai bo la: B,D ');
    if cauhoi =3 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =4 then write('Hai dap an bi loai bo la: A,B ');
    if cauhoi =5 then write('Hai dap an bi loai bo la: C,D ');
    if cauhoi =6 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =7 then write('Hai dap an bi loai bo la: B,D ');
    if cauhoi =8 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =9 then write('Hai dap an bi loai bo la: A,B ');
    if cauhoi =10 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =11 then write('Hai dap an bi loai bo la: B,D ');
    if cauhoi =12 then write('Hai dap an bi loai bo la: A,C ');
    if cauhoi =13 then write('Hai dap an bi loai bo la: B,C ');
    if cauhoi =14 then write('Hai dap an bi loai bo la: B,C ');
    writeln(', bam ENTER de tiep tuc . . .');
    readln;
    nammuoi := 2;
    clrscr;
    cauhoi1;
  end
  else
  begin
    writeln('Tro giup ban da su dung! Bam ENTER de tiep tuc . . .');readln;clrscr;cauhoi1;
  end;
end;
procedure congcu;
begin
  if ch='g' then goidienthoaichonguoithan;
  if ch='5' then nammuoinammuoi;
  if ch='k' then khaosatnguoichoi;
  if ch='t' then tuvantaicho;
  if cauhoi =0 then
  begin
    if (ch='a') or (ch='A') then
    begin
      tien:=tien+1;writeln('Dung, so tien cua ban la ',tien,'$   (+1$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =1 then
  begin
    if (ch='b') or (ch='B') then
    begin
      tien:=tien+1;writeln('Dung, so tien cua ban la ',tien,'$   (+1$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =2 then
  begin
    if (ch='c') or (ch='C') then
    begin
      tien:=tien+1;writeln('Dung, so tien cua ban la ',tien,'$   (+1$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =3 then
  begin
    if (ch='d') or (ch='D') then
    begin
      tien:=tien+2;writeln('Dung, so tien cua ban la ',tien,'$   (+2$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =4 then
  begin
    if (ch='c') or (ch='C') then
    begin
      tien:=tien+5;writeln('Dung, so tien cua ban la ',tien,'$   (+5$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =5 then
  begin
    if (ch='b') or (ch='B') then
    begin
      tien:=tien+10;writeln('Dung, so tien cua ban la ',tien,'$   (+10$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =6 then
  begin
    if (ch='a') or (ch='A') then
    begin
      tien:=tien+20;writeln('Dung, so tien cua ban la ',tien,'$   (+20$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =7 then
  begin
    if (ch='c') or (ch='C') then
    begin
      tien:=tien+20;writeln('Dung, so tien cua ban la ',tien,'$   (+20$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =8 then
  begin
    if (ch='d') or (ch='D') then
    begin
      tien:=tien+30;writeln('Dung, so tien cua ban la ',tien,'$   (+30$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =9 then
  begin
    if (ch='c') or (ch='C') then
    begin
      tien:=tien+40;writeln('Dung, so tien cua ban la ',tien,'$   (+40$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =10then
  begin
    if (ch='a') or (ch='A') then
    begin
      tien:=tien+40;writeln('Dung, so tien cua ban la ',tien,'$   (+40$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =11then
  begin
    if (ch='c') or (ch='C') then
    begin
      tien:=tien+50;writeln('Dung, so tien cua ban la ',tien,'$   (+50$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =12then
  begin
    if (ch='b') or (ch='B') then
    begin
      tien:=tien+100;writeln('Dung, so tien cua ban la ',tien,'$   (+100$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =13then
  begin
    if (ch='a') or (ch='A') then
    begin
      tien:=tien+150;writeln('Dung, so tien cua ban la ',tien,'$   (+150$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  if cauhoi =14then
  begin
    if (ch='a') or (ch='A') then
    begin
      tien:=tien+300;writeln('Dung, so tien cua ban la ',tien,'$   (+300$)');
    end
    else
    begin
      tien:=tien-50;writeln('Sai, so tien cua ban da bi tru 50$ thanh: ',tien);
    end;
  end;
  cauhoi := cauhoi+1;

  Writeln('Bam ENTER de tiep tuc . . .');

end;
procedure menu;
procedure huongdan;
begin
  write('Xin hay doc huong dan ki:Bam cac nut |a|  |b|  |c|  |d| de chon ca');
  write('c dap an a,b,c,d. De goi cac tro giup bam |5| la');
  write('nam muoi nam muoi,|g| la goi dien thoai cho nguoi than, |t| la tu van tai cho, |k| la khao sat nguoi choi.');
  write(' Bam |y| la yes(co),');
  write('|n| la no(khong). Meo nho, ban bam nut "-" ngay menu de hack tien va con nhieu loi, xin hay choi game nay tu');
  writeln(' tu (SLOW MOTION) Bam ENTER de thoat . . .');
  readln;
  menu;
end;
procedure shop;
begin
  writeln('Chao mung ban den voi \\*SHOP*// ai la trieu phu! Ban muon mua gi?');
  writeln('So tien cua ban la: ',tien,'$');
  writeln('1.Tro giup "tu van tai cho":. . .\1099$/');
  writeln('Bam ESC de thoat');
  repeat
    ch := readkey;
  until (ch='1') or (ch='2') or (ch=#27);
  if ch='1' then
  begin
    if tien>1099 then
    begin
      tien :=tien-1099;unlock:=2;writeln('Ban da mua tro giup "tu van tai cho" thanh cong, bam ENTER de thoat . . .');readln;
    end
    else
    begin
      writeln('Ban ko du tien! Bam ENTER de tiep tuc . . .');readln;clrscr;shop;
    end;
  end;
  if ch=#27 then menu;
  clrscr;
  menu;
end;
begin
  repeat
    begin
      clrscr;
      writeln('                                  HUONG DAN  ');
      writeln('                                    CHOI     ');
      writeln('                                    SHOP     ');
      writeln('                                    QUIT     ');
      gotoxy(32,y);write('->');gotoxy(45,y);write('<-');
      ch := readkey;
      if ch='-' then
      begin
        tien:=16958;
      end;
      if ch=#13 then
      begin
        clrscr; if y=1 then huongdan;if y=2 then cauhoi1;if y=3 then shop;if y=4 then halt;
      end;
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72);
      if ch=#72 then
      begin
        y:=y-1;if y<1 then y:=4;gotoxy(1,y);
      end;
      if ch=#80 then
      begin
        y:=y+1;if y>4 then y:=1;gotoxy(1,y);
      end;

    end;
  until 1=2
end;
begin
  if cauhoi=0 then files:='cau1,1.txt';
  if cauhoi=1 then files:='cau1,2.txt';
  if cauhoi=2 then files:='cau1,3.txt';
  if cauhoi=3 then files:='cau1,4.txt';
  if cauhoi=4 then files:='cau1,5.txt';
  if cauhoi=5 then files:='cau1,6.txt';
  if cauhoi=6 then files:='cau1,7.txt';
  if cauhoi=7 then files:='cau1,8.txt';
  if cauhoi=8 then files:='cau1,9.txt';
  if cauhoi=9 then files:='cau1,10.txt';
  if cauhoi=10 then files:='cau1,11.txt';
  if cauhoi=11 then files:='cau1,12.txt';
  if cauhoi=12 then files:='cau1,13.txt';
  if cauhoi=13 then files:='cau1,14.txt';
  if cauhoi=14 then files:='cau1,15.txt';
  if cauhoi=15 then
  begin
    writeln('Chuc mung ban da vuot qua cac cau hoi tren! So tien cua ban la:',tien,'.  Choi lai? (y/n)');
    repeat
      begin
        ch:=readkey;
      end;
    until (ch='y') or (ch='n');if ch='y' then
    begin
      cauhoi:=0;clrscr;cauhoi1;
    end
    else
    begin
      cauhoi:=0;
    end
    ;menu;
  end;
  if cauhoi=15 then exit;
  assign(f, files);
  reset(f);
  read(f,t);
  writeln(t);
  repeat
    begin
      ch := readkey;
    end;
  until (ch='a') or (ch='5') or (ch='A') or (ch='b') or (ch='B') or (ch='c') or (ch='C') or (ch='d') or (ch='D') or (ch='g') or
  (ch='t') or (ch='k') or (cauhoi=15);
  congcu;
  readln;
  clrscr;
  cauhoi1;
  readln;
end;
procedure menu;
procedure huongdan;
begin
  write('Xin hay doc huong dan ki:Bam cac nut |a|  |b|  |c|  |d| de chon ca');
  write('c dap an a,b,c,d. De goi cac tro giup bam |5| la');
  write('nam muoi nam muoi,|g| la goi dien thoai cho nguoi than, |t| la tu van tai cho, |k| la khao sat nguoi choi.');
  write(' Bam |y| la yes(co),');
  write('|n| la no(khong). Meo nho, ban bam nut "-" ngay menu de hack tien va con nhieu loi, xin hay choi game nay tu');
  writeln(' tu (SLOW MOTION) Bam ENTER de thoat . . .');
  readln;
  menu;
end;
procedure shop;
begin
  writeln('Chao mung ban den voi \\*SHOP*// ai la trieu phu! Ban muon mua gi?');
  writeln('So tien cua ban la: ',tien,'$');
  writeln('1.Tro giup "tu van tai cho":. . .\1099$/');
  writeln('Bam ESC de thoat');
  repeat
    ch := readkey;
  until (ch='1') or (ch='2') or (ch=#27);
  if ch='1' then
  begin
    if tien>1099 then
    begin
      tien :=tien-1099;unlock:=2;
      writeln('Ban da mua tro giup "tu van tai cho" thanh cong, bam ENTER de thoat . . .');readln;
    end
    else
    begin
      writeln('Ban ko du tien! Bam ENTER de tiep tuc . . .');readln;clrscr;shop;
    end;
    ;
  end;
  if ch=#27 then menu;
  clrscr;
  menu;
end;
begin
  repeat
    begin
      clrscr;
      writeln('                                  HUONG DAN  ');
      writeln('                                    CHOI     ');
      writeln('                                    SHOP     ');
      writeln('                                    QUIT     ');
      gotoxy(32,y);write('->');gotoxy(45,y);write('<-');
      ch := readkey;
      if ch='-' then
      begin
        tien:=16958;menu;
      end;
      if ch=#13 then
      begin
        clrscr; if y=1 then huongdan;if y=2 then cauhoi1;if y=3 then shop;if y=4 then halt;
      end;
      repeat
        begin
          ch:=readkey;
        end;
      until (ch=#80) or (ch=#72);
      if ch=#72 then
      begin
        y:=y-1;if y<1 then y:=4;gotoxy(1,y);
      end;
      if ch=#80 then
      begin
        y:=y+1;if y>4 then y:=1;gotoxy(1,y);
      end;

    end;
  until 1=2
end;
BEGIN
  clrscr;
  loading;
  y := 1;
  textcolor(lightblue);
  textbackground(white);
  menu;
end.
