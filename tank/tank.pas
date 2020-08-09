uses crt,dos,mouse;
var
  huong,str,huongs,save:string;
  x,y,i,j,xs,ys,time,bulletmove,dam,AInum,AIcount,botmovement,health,AIshot,speeds,speed,killed,e,allAIhealth,k,wnumber,tmp,direction,movetype:longint;
  ch:char;
  alive,hit:boolean;
//board
  a:array[-100..10000,-100..100000] of char;
  wallbld:array[-100..10000,-100..10000] of longint;
  weaponx,weapony:array[-10..10000] of integer;
  chose,kt:array[0..10] of boolean;
//files
  f:text;
//AI things
  AIx,AIy,ran,ran2,beau,AIhealth,AIxs,AIys,AItime,randomAIstatus:array[0..30] of integer;
  AIalive:array[0..30] of boolean;
  AIhuong,AIstatus,AIhuongs,last_AIhuong:array[0..30] of string;
///remember bulletmove to plus the level!
///--> main <--\\\

procedure guide;
begin
  clrscr;
  gotoxy(1,10);
  writeln('Use buttons (',char(24),' ',char(25),' ',char(26),' ',char(27),') to move your tank,[SPACEBAR] to shoot and becarefull of the AI tank! If you colision to it, you would be hurt. This tool ',char(5),' will increase your damage by 2');
  write('Enter to exit');
  readln;
  clrscr;
end;
procedure credits;
begin
  clrscr;
  gotoxy(30,10);write('Creator: Khoa');
  gotoxy(30,11);write('Email: khoahoangvip2030@gmail.com');
  gotoxy(30,12);write('Version: 3');
  gotoxy(30,13);write('Good Luck !');
  gotoxy(30,15);write('ENTER to exit');
  readln;
  clrscr;
end;
procedure menu;
Var
  X,Y,last,k,count : Word;
  mouseEvent:tmouseevent;
  chose:array[1..4] of boolean;
  ch:char;
begin
  for i := 1 to 4 do chose[i]:=false;
  textbackground(white);clrscr;
  initmouse;
  chose[1]:=true;
  last := 1;
  k    := 1;
  repeat
    inc(k);
    x := getmousex;
    y := getmousey;
    if (x>=34) and (x<=43) and (y<=12) and (y>=9) then
    begin
      chose[last]:=false;chose[y-8]:=true;last:=y-8;
    end;
    textcolor(black);
    if chose[1] then textbackground(green) else textbackground(15);gotoxy(35,10);write('  PLAY    ');
    if chose[2] then textbackground(green) else textbackground(15);gotoxy(35,11);write('  GUIDE   ');
    if chose[3] then textbackground(green) else textbackground(15);gotoxy(35,12);write('  CREDIT  ');
    if chose[4] then textbackground(green) else textbackground(15);gotoxy(35,13);write('  QUIT    ');
    if pollmouseevent(mouseevent) then getmouseevent(mouseevent);
    if (getmousebuttons=mouserightbutton) then
    begin
      inc(count);if count=2 then
      begin
        count:=0;showmouse;
      end;
    end;
    if (getmousebuttons=mouseleftbutton) and (x>=34) and (x<=43) and (y<=12) and (y>=9) then
    begin
      donemouse;
      case y-8 of 1:exit;2:guide;3:credits;4:halt;
      end
      ;initmouse;
    end;
  until (1=2);
end;

procedure writebld;
begin
    // my tank
  textcolor(red);
  gotoxy(1,25);write('MY TANK:');
  gotoxy(10,25);
  for k := 1 to 50 do if health div 2 >k then write(char(219)) else write(' ');
    //boss tank
  gotoxy(2,24);write(AInum-killed,' BOSS:',(allAIhealth / AInum):0:2,' %');
end;
procedure drawmap;
begin
//Did you already create your own map by "map editor.exe"?
  textcolor(brown);
  for i:=1 to 24 do
  for j := 1 to 80 do
  begin
    gotoxy(j,i);
    write(a[i,j]);
  end;
end;
procedure readmap;
begin
//need program name "map editor.exe" to edit the map.txt
  assign(f,'map.txt');
  reset(f);
  for i:=1 to 24 do
  begin
    readln(f,str);
    for j := 1 to length(str) do if str[j]='1' then
    begin
      wallbld[i,j]:=3;a[i,j]:=char(219);
    end
    else if str[j]='2' then
    begin
      a[i,j]:=char(5);inc(wnumber);weaponx[wnumber]:=j;weapony[wnumber]:=i;
    end
    else a[i,j]:=' ';
  end;
  close(f);
end;
procedure drawtank(x,y:longint;z:string);
begin
//up down
  if (z='up') or (z='down') then
  begin
    textcolor(brown);
    gotoxy(x+1,y-1);
    write(a[y-1,x+1],a[y-1,x+2],a[y-1,x+3],a[y-1,x+4],a[y-1,x+5]);
    gotoxy(x,y);
    textcolor(brown);write(a[y,x]);textcolor(green);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[y,x+6]);
    gotoxy(x,y+1);
    textcolor(brown);write(a[y+1,x]);textcolor(green);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[y+1,x+6]);
    gotoxy(x,y+2);
    textcolor(brown);write(a[y+2,x]);textcolor(green);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[y+2,x+6]);
    gotoxy(x+1,y+3);
    write(a[y+3,x+1],a[y+3,x+2],a[y+3,x+3],a[y+3,x+4],a[y+3,x+5]);
  end;
//right left
  if (z='right')or(z='left') then
  begin
    textcolor(brown);
    gotoxy(x+1,y-1);
    write(a[y-1,x+1],a[y-1,x+2],a[y-1,x+3],a[y-1,x+4],a[y-1,x+5]);
    gotoxy(x,y);
    textcolor(brown);write(a[y,x]);textcolor(green);write(char(178),char(178),char(178),char(178),char(178));textcolor(brown);write(a[y,x+6]);
    gotoxy(x,y+1);
    textcolor(brown);write(a[y+1,x]);textcolor(green);write(char(219),char(219),char(219),char(219),char(219));textcolor(brown);write(a[y+1,x+6]);
    gotoxy(x,y+2);
    textcolor(brown);write(a[y+2,x]);textcolor(green);write(char(178),char(178),char(178),char(178),char(178));textcolor(brown);write(a[y+2,x+6]);
    gotoxy(x+1,y+3);
    write(a[y+3,x+1],a[y+3,x+2],a[y+3,x+3],a[y+3,x+4],a[y+3,x+5]);
  end;
  case z of
    'up': //
    begin
      gotoxy(x+3,y-1);write(char(30));
    end;
    'down': //
    begin
      gotoxy(x+3,y+3);write(char(31));
    end;
    'left': //
    begin
      gotoxy(x,y+1);write(char(17));
    end;
    'right': //
    begin
      gotoxy(x+6,y+1);write(char(16));
    end;
  end;
end;
procedure drawtankAI(x,y:longint;z:string);
begin
//up down
  if (z='up') or (z='down') then
  begin
    textcolor(brown);
    gotoxy(AIx[AIcount]+1,AIy[AIcount]-1);
    write(a[AIy[AIcount]-1,AIx[AIcount]+1],a[AIy[AIcount]-1,AIx[AIcount]+2],a[AIy[AIcount]-1,AIx[AIcount]+3],a[AIy[AIcount]-1,AIx[AIcount]+4],a[AIy[AIcount]-1,AIx[AIcount]+5]);
    gotoxy(AIx[AIcount],AIy[AIcount]);
    textcolor(brown);write(a[AIy[AIcount],AIx[AIcount]]);textcolor(14);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[AIy[AIcount],AIx[AIcount]+6]);
    gotoxy(AIx[AIcount],AIy[AIcount]+1);
    textcolor(brown);write(a[AIy[AIcount]+1,AIx[AIcount]]);textcolor(14);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[AIy[AIcount]+1,AIx[AIcount]+6]);
    gotoxy(AIx[AIcount],AIy[AIcount]+2);
    textcolor(brown);write(a[AIy[AIcount]+2,AIx[AIcount]]);textcolor(14);write(char(178),char(178),char(219),char(178),char(178));textcolor(brown);write(a[AIy[AIcount]+2,AIx[AIcount]+6]);
    gotoxy(AIx[AIcount]+1,AIy[AIcount]+3);
    write(a[AIy[AIcount]+3,AIx[AIcount]+1],a[AIy[AIcount]+3,AIx[AIcount]+2],a[AIy[AIcount]+3,AIx[AIcount]+3],a[AIy[AIcount]+3,AIx[AIcount]+4],a[AIy[AIcount]+3,AIx[AIcount]+5]);
  end;
//right left
  if (z='right')or(z='left') then
  begin

    textcolor(brown);
    gotoxy(AIx[AIcount]+1,AIy[AIcount]-1);
    write(a[AIy[AIcount]-1,AIx[AIcount]+1],a[AIy[AIcount]-1,AIx[AIcount]+2],a[AIy[AIcount]-1,AIx[AIcount]+3],a[AIy[AIcount]-1,AIx[AIcount]+4],a[AIy[AIcount]-1,AIx[AIcount]+5]);
    gotoxy(AIx[AIcount],AIy[AIcount]);
    textcolor(brown);write(a[AIy[AIcount],AIx[AIcount]]);textcolor(14);write(char(178),char(178),char(178),char(178),char(178));textcolor(brown);write(a[AIy[AIcount],AIx[AIcount]+6]);
    gotoxy(AIx[AIcount],AIy[AIcount]+1);
    textcolor(brown);write(a[AIy[AIcount]+1,AIx[AIcount]]);textcolor(14);write(char(219),char(219),char(219),char(219),char(219));textcolor(brown);write(a[AIy[AIcount]+1,AIx[AIcount]+6]);
    gotoxy(AIx[AIcount],AIy[AIcount]+2);
    textcolor(brown);write(a[AIy[AIcount]+2,AIx[AIcount]]);textcolor(14);write(char(178),char(178),char(178),char(178),char(178));textcolor(brown);write(a[AIy[AIcount]+2,AIx[AIcount]+6]);
    gotoxy(AIx[AIcount]+1,AIy[AIcount]+3);
    write(a[AIy[AIcount]+3,AIx[AIcount]+1],a[AIy[AIcount]+3,AIx[AIcount]+2],a[AIy[AIcount]+3,AIx[AIcount]+3],a[AIy[AIcount]+3,AIx[AIcount]+4],a[AIy[AIcount]+3,AIx[AIcount]+5]);
  end;
  case z of
    'up': //
    begin
      gotoxy(AIx[AIcount]+3,AIy[AIcount]-1);write(char(30));
    end;
    'down': //
    begin
      gotoxy(AIx[AIcount]+3,AIy[AIcount]+3);write(char(31));
    end;
    'left': //
    begin
      gotoxy(AIx[AIcount],AIy[AIcount]+1);write(char(17));
    end;
    'right': //
    begin
      gotoxy(AIx[AIcount]+6,AIy[AIcount]+1);write(char(16));
    end;
  end;
end;
procedure AIshoot;
begin
  if AIalive[AIcount] then
  begin
    //AI bullet
    if (AItime[AIcount]>0) then
    begin
      case AIhuongs[AIcount] of 'up' : dec(AIys[AIcount]);'down':inc(AIys[AIcount]);'left':dec(AIxs[AIcount]);'right':inc(AIxs[AIcount]);
      end;
                //bullet cannot exit screen
      if AIxs[AIcount]<2 then AIxs[AIcount]:=2;
      if AIys[AIcount]<1 then AIys[AIcount]:=1;
      if AIxs[AIcount]>79 then AIxs[AIcount]:=79;
      if AIys[AIcount]>23 then AIys[AIcount]:=23;
                //enter wall and inflict the wall()
                //wall status
      if a[AIys[AIcount],AIxs[AIcount]+1]<>' ' then
      begin
        dec(wallbld[AIys[AIcount],AIxs[AIcount]+1],random(2)+1);if wallbld[AIys[AIcount],AIxs[AIcount]+1]<1 then
        begin
          gotoxy(AIxs[AIcount]+1,AIys[AIcount]);write(' ');a[AIys[AIcount],AIxs[AIcount]+1]:=' ';
        end
        else if wallbld[AIys[AIcount],AIxs[AIcount]+1]<=dam then
        begin
          gotoxy(AIxs[AIcount]+1,AIys[AIcount]);write(char(176));a[AIys[AIcount],AIxs[AIcount]+1]:=char(176);
        end
        ;AItime[AIcount]  := -1;
      end;
                //bullet
      gotoxy(AIxs[AIcount]+1,AIys[AIcount]-1);write(a[AIys[AIcount]-1,AIxs[AIcount]+1]);gotoxy(AIxs[AIcount]+1,AIys[AIcount]+1);write(a[AIys[AIcount]+1,AIxs[AIcount]+1]);textcolor(brown);if AIxs[AIcount]>0 then gotoxy(AIxs[AIcount],AIys[AIcount]) else gotoxy(1,AIys[AIcount]);textcolor(brown);write(a[AIys[AIcount],AIxs[AIcount]]);textcolor(black);write('.');textcolor(brown);write(a[AIys[AIcount],AIxs[AIcount]+2]);dec(AItime[AIcount]);
      if AItime[AIcount]<1 then
      begin
        gotoxy(AIxs[AIcount]+1,AIys[AIcount]);write(a[AIys[AIcount],AIxs[AIcount]+1]);
      end;
      if (AItime[AIcount]>15) or ((AItime[AIcount]>6)and ((AIhuongs[AIcount]<>'right') and (AIhuongs[AIcount]<>'left'))) then if AIalive[AInum] then drawtankAI(AIx[AIcount],AIy[AIcount],AIhuong[AIcount]);
    end;
  end;
end;
procedure ai;
begin
  for AIcount:=1 to AInum do
  begin
    randomAIstatus[AIcount]            := random(10);
    if (randomAIstatus[AIcount]<7) then AIstatus[AIcount]:='moving' else AIstatus[AIcount]:='shooting';
    if randomAIstatus[AIcount]=0 then AIstatus[AIcount]:='think_and_turn';
    if AItime[AIcount]>0 then AIstatus[AIcount]:='moving';
    //end of status.
    if (AIalive[AIcount]) and (AIstatus[AIcount]='moving') then
    begin
     //ai        
      ran[AIcount]  := ran2[AIcount];
      ran2[AIcount] := random(4);
      if (ran[AIcount]<>ran2[AIcount]) and (beau[AIcount]>0) then
      begin
        ran2[AIcount]:=ran[AIcount];dec(beau[AIcount]);
      end
      else beau[AIcount]:=random(3)+3;
      movetype := random(5);
//moving
      case AIhuong[AIcount] of
        'right':inc(AIx[AIcount]);
        'left': dec(AIx[AIcount]);
        'down':inc(AIy[AIcount]);
        'up':dec(AIy[AIcount]);
      end;
      begin
//true move

        if AIx[AIcount]<x then
        begin
          AIhuong[AIcount]:='right';
        end
        else
        if AIx[AIcount]>x then
        begin
          AIhuong[AIcount]:='left';
        end
        else
        if AIy[AIcount]>y then
        begin
          AIhuong[AIcount]:='up';
        end
        else
        if AIy[AIcount]<y then
        begin
          AIhuong[AIcount]:='down';
        end;

      end;
    //have a straight move
      if (AIy[AIcount]>80-6) or (AIx[AIcount]<2) or (AIy[AIcount]>24-4) or (AIy[AIcount]<2) then
      begin
        beau[AIcount]:=0;randomize;
      end;
      if AIx[AIcount]>80-6 then AIx[AIcount]:=80-6;
      if AIx[AIcount]<2 then AIx[AIcount]:=2;
      if AIy[AIcount]>24-4 then AIy[AIcount]:=24-4;
      if AIy[AIcount]<2 then AIy[AIcount]:=2;
    //AI cannot enter wall
      case AIhuong[AIcount] of
        'up':   if (a[AIy[AIcount],AIx[AIcount]+1]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+2]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+3]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+4]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+5]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+1]=char(176)) or (a[AIy[AIcount],AIx[AIcount]+2]=char(176)) or (a[AIy[AIcount],AIx[AIcount]+3]=char(176)) or (a[AIy[AIcount],AIx[AIcount]+4]=char(178)) or (a[AIy[AIcount],AIx[AIcount]+5]=char(178)) then
        begin
          inc(AIy[AIcount]);beau[AICount]:=0;
        end;
        'down': if (a[AIy[AIcount]+2,AIx[AIcount]+1]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+2]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+3]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+4]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+5]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+1]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+2]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+3]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+4]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+5]=char(176)) then
        begin
          dec(AIy[AIcount]);;beau[AICount]:=0;
        end;
        'left': if (a[AIy[AIcount],AIx[AIcount]+1]=char(219)) or (a[AIy[AIcount]+1,AIx[AIcount]+1]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+1]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+1]=char(176)) or (a[AIy[AIcount]+1,AIx[AIcount]+1]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+1]=char(176)) then
        begin
          inc(AIx[AIcount]);;beau[AICount]:=0;
        end;
        'right':if (a[AIy[AIcount],AIx[AIcount]+5]=char(219)) or (a[AIy[AIcount]+1,AIx[AIcount]+5]=char(219)) or (a[AIy[AIcount]+2,AIx[AIcount]+5]=char(219)) or (a[AIy[AIcount],AIx[AIcount]+5]=char(176)) or (a[AIy[AIcount]+1,AIx[AIcount]+5]=char(176)) or (a[AIy[AIcount]+2,AIx[AIcount]+5]=char(176)) then
        begin
          dec(AIx[AIcount]);;beau[AICount]:=0;
        end;
      end;
    //AI cannot enter another object like my tank, other AI tank, ... and injure it
      if ( ((x+1<=AIx[AIcount]+5)and(x+1>=AIx[AIcount]+1)) or ((x+2<=AIx[AIcount]+5)and(x+2>=AIx[AIcount]+1)) or ((x+3<=AIx[AIcount]+5)and(x+3>=AIx[AIcount]+1)) or ((x+4<=AIx[AIcount]+5)and(x+4>=AIx[AIcount]+1)) or ((x+5<=AIx[AIcount]+5)and(x+5>=AIx[AIcount]+1))) and ((y<=AIy[AIcount]+2) and (y+2>=AIy[AIcount])) then
      begin
        case AIhuong[AIcount] of 'up':dec(y);'down':inc(y);'left':dec(x);'right':inc(x);
        end
        ;dec(health,random(5)+5);gotoxy(15,25);writebld;drawtank(x,y,huong);
      end;
    //tank cannot exit screen
      if AIalive[AIcount] then
      begin
        if x<2 then x:=2;
        if y<2 then y:=2;
        if x>80-6 then x:=80-6;
        if y>23-3 then y:=23-3;
      end;

//tank cannot enter wall region
      case huong of
        'up':   if (a[y,x+1]=char(219)) or (a[y,x+2]=char(219)) or (a[y,x+3]=char(219)) or (a[y,x+4]=char(219)) or (a[y,x+5]=char(219)) or (a[y,x+1]=char(176)) or (a[y,x+2]=char(176)) or (a[y,x+3]=char(176)) or (a[y,x+4]=char(178)) or (a[y,x+5]=char(178)) then inc(y);
        'down': if (a[y+2,x+1]=char(219)) or (a[y+2,x+2]=char(219)) or (a[y+2,x+3]=char(219)) or (a[y+2,x+4]=char(219)) or (a[y+2,x+5]=char(219)) or (a[y+2,x+1]=char(176)) or (a[y+2,x+2]=char(176)) or (a[y+2,x+3]=char(176)) or (a[y+2,x+4]=char(176)) or (a[y+2,x+5]=char(176)) then dec(y);
        'left': if (a[y,x+1]=char(219)) or (a[y+1,x+1]=char(219)) or (a[y+2,x+1]=char(219)) or (a[y,x+1]=char(176)) or (a[y+1,x+1]=char(176)) or (a[y+2,x+1]=char(176)) then inc(x);
        'right':if (a[y,x+5]=char(219)) or (a[y+1,x+5]=char(219)) or (a[y+2,x+5]=char(219)) or (a[y,x+5]=char(176)) or (a[y+1,x+5]=char(176)) or (a[y+2,x+5]=char(176)) then dec(x);
      end;
      if AIalive[AIcount] then drawtankAI(AIx[AIcount],AIy[AIcount],AIhuong[AIcount]);
    end
    else if AIstatus[AIcount]='shooting' then
    begin
      AItime[AIcount]:=20;if (AIhuong[AIcount]='left') or (AIhuong[AIcount]='right') then AItime[AIcount]:=AItime[AIcount]*2;AIxs[AIcount]:=AIx[AIcount]+2;AIys[AIcount]:=AIy[AIcount]+1;AIhuongs[AIcount]:=AIhuong[AIcount];
    end
  end;
end;
procedure main;
procedure play;
begin
  if alive=false then
  begin
    gotoxy(1,1);write('YOU LOSE!');readln;halt;
  end;
  inc(AIshot);
  if AIshot=speeds then
  begin
    for AIcount:=1 to AInum do AIshoot;AIshot:=0;
  end;
  inc(botmovement);
  if botmovement>speed then
  begin
    botmovement:=0;ai;
  end;
//the time to let the bullet move
  if time>0 then inc(bulletmove);
  if (time>0) and (bulletmove=50) then
  begin
    bulletmove := 0;
    case huongs of 'up' : dec(ys);'down':inc(ys);'left':dec(xs);'right':inc(xs);
    end;
                //bullet cannot exit screen
    if xs<1 then xs:=1;
    if ys<1 then ys:=1;
    if xs>80 then xs:=80;
    if ys>23 then ys:=23;
    if (xs=1) or (ys=1) or (xs=80) or (ys=23) then time:=1;
                //enter wall and inflict the wall
    if (a[ys,xs+1]=char(219))or(a[ys,xs+1]=char(176)) then
    begin
      dec(wallbld[ys,xs+1],dam);if wallbld[ys,xs+1]<1 then
      begin
        gotoxy(xs+1,ys);write(' ');a[ys,xs+1]:=' ';
      end
      else if wallbld[ys,xs+1]<=dam then
      begin
        gotoxy(xs+1,ys);write(char(176));a[ys,xs+1]:=char(176);
      end
      ;time := -1;
    end;
    textcolor(brown);gotoxy(xs+1,ys-1);write(a[ys-1,xs+1]);gotoxy(xs+1,ys+1);write(a[ys+1,xs+1]);textcolor(14);if xs>0 then gotoxy(xs,ys) else gotoxy(1,ys);textcolor(brown);write(a[ys,xs]);textcolor(black);write('.');textcolor(brown);write(a[ys,xs+2]);dec(time);
    if time<2 then
    begin
      gotoxy(xs+1,ys);write(a[ys,xs+1]);
    end;
    if (time>35) or ((time>16)and ((huongs<>'right') and (huongs<>'left'))) then drawtank(x,y,huong);
  end;
//Injure AI when hit the bullet
  for AIcount:=1 to AInum do
  begin
    case huongs of
      'up':if (AIx[AIcount]+5>=xs+1) and (AIx[AIcount]+1<=xs+1) and (AIy[AIcount]+2=ys) then hit:=true;
      'down':if (AIx[AIcount]+5>=xs+1) and (AIx[AIcount]+1<=xs+1) and (AIy[AIcount]=ys) then hit:=true;
      'left':if (AIy[AIcount]+2>=ys) and (AIy[AIcount]<=ys) and (AIx[AIcount]+5=xs+1) then hit:=true;
      'right':if (AIy[AIcount]+2>=ys) and (AIy[AIcount]<=ys) and (AIx[AIcount]+1=xs+1) then hit:=true;
    end;
    if hit then
    begin
      time:=0;xs:=0;if AIhealth[AIcount]>=dam*10 then
      begin
        dec(AIhealth[AIcount],dam*10);dec(allAIhealth,dam*10);
      end
      else
      begin
        dec(allAIhealth,AIhealth[AIcount]);AIhealth[AIcount]:=0;
      end
      ;writebld;hit:=false;
    end;
//if the AIheath<1 then ...
    if (AIhealth[AIcount]<1) and AIalive[AIcount] then
    begin
      inc(killed);writebld;AIalive[AIcount]:=false;AIx[AIcount]:=-50;AIy[AIcount]:=-50;drawtank(x,y,huong);AIxs[AIcount]:=-50;AIys[AIcount]:=-50;
    end;
//Injure me on Colision with AI tank
    if ( ((x+1<=AIx[AIcount]+5)and(x+1>=AIx[AIcount]+1)) or ((x+2<=AIx[AIcount]+5)and(x+2>=AIx[AIcount]+1)) or ((x+3<=AIx[AIcount]+5)and(x+3>=AIx[AIcount]+1)) or ((x+4<=AIx[AIcount]+5)and(x+4>=AIx[AIcount]+1)) or ((x+5<=AIx[AIcount]+5)and(x+5>=AIx[AIcount]+1))) and ((y<=AIy[AIcount]+2) and (y+2>=AIy[AIcount])) then
    begin
      case huong of 'up':inc(y);'down':dec(y);'left':inc(x);'right':dec(x);
      end
      ;dec(health,random(10)+5);gotoxy(15,25);writebld;drawtank(x,y,huong);
    end;
//injure me when hit the bullet from AI AIhuongs=AI huong shoot
    if (x+5>=AIxs[AIcount]+1) and (x+1<=AIxs[AIcount]) and (y+2>=AIys[AIcount]) and (y<=AIys[AIcount]) then
    begin
      AItime[AIcount]:=0;AIxs[AIcount]:=0;dec(health,random(10)+5);gotoxy(15,25);writebld;
    end;
  end;
//movement (xs:xshoot,ys:yshoot of the bullet)
  if keypressed then
  begin
    ch := readkey;
    case ch of
      #27: //
      begin
        clrscr;menu;drawmap;{exec('tank.exe','400000')'}end;
        #72: //
        begin
          if huong='up' then dec(y);huong:='up';
        end;
        #80: //
        begin
          if huong='down' then inc(y);huong:='down';
        end;
        #75: //
        begin
          if huong='left' then dec(x);huong:='left';
        end;
        #77: //
        begin
          if huong='right' then inc(x);huong:='right';
        end;
        #32: //
        begin
          case huong of 'up','down':time:=20;'right','left':time:=40;
          end
          ;{20,40 meter}xs:=x+2;ys:=y+1;huongs:=huong;
        end;
      end;
//tank cannot exit screen
      if x<2 then x:=2;
      if y<2 then y:=2;
      if x>80-6 then x:=80-6;
      if y>23-3 then y:=23-3;
//tank cannot enter wall region
      case huong of
        'up':   if (a[y,x+1]=char(219)) or (a[y,x+2]=char(219)) or (a[y,x+3]=char(219)) or (a[y,x+4]=char(219)) or (a[y,x+5]=char(219)) or (a[y,x+1]=char(176)) or (a[y,x+2]=char(176)) or (a[y,x+3]=char(176)) or (a[y,x+4]=char(178)) or (a[y,x+5]=char(178)) then inc(y);
        'down': if (a[y+2,x+1]=char(219)) or (a[y+2,x+2]=char(219)) or (a[y+2,x+3]=char(219)) or (a[y+2,x+4]=char(219)) or (a[y+2,x+5]=char(219)) or (a[y+2,x+1]=char(176)) or (a[y+2,x+2]=char(176)) or (a[y+2,x+3]=char(176)) or (a[y+2,x+4]=char(176)) or (a[y+2,x+5]=char(176)) then dec(y);
        'left': if (a[y,x+1]=char(219)) or (a[y+1,x+1]=char(219)) or (a[y+2,x+1]=char(219)) or (a[y,x+1]=char(176)) or (a[y+1,x+1]=char(176)) or (a[y+2,x+1]=char(176)) then inc(x);
        'right':if (a[y,x+5]=char(219)) or (a[y+1,x+5]=char(219)) or (a[y+2,x+5]=char(219)) or (a[y,x+5]=char(176)) or (a[y+1,x+5]=char(176)) or (a[y+2,x+5]=char(176)) then dec(x);
      end;
//eat weapon
      for k:=1 to wnumber do
      if ((y<=weapony[k]) and (x<weaponx[k]) and (y+2>=weapony[k]) and (x+5>=weaponx[k])) then
      begin
        gotoxy(x,y-2);write('+2 damage');a[weapony[k],weaponx[k]]:=' ';inc(dam,2);weaponx[k]:=0;weapony[k]:=0;
      end;
      drawtank(x,y,huong);
    end;
    if health<2 then
    begin
      clrscr;textcolor(red);gotoxy((80-9)div 2,11);write('YOU LOSE!');delay(1000);main;
    end
    else if killed=AInum then
    begin
      clrscr;textcolor(red);gotoxy((80-8)div 2,11);write('YOU WIN!');delay(1000);main;
    end;
  end;

  begin
    cursoroff;
    textcolor(black);textbackground(15);clrscr;
    assign(f,'setting.txt');
    reset(f);
    readln(f,save);
    delete(save,1,pos('=',save));
    val(save,speed,e);
    readln(f,save);
    delete(save,1,pos('=',save));
    val(save,speeds,e);
    readln(f,save);
    delete(save,1,pos('=',save));
    val(save,AInum,e);
    close(f);
    xs          := -1;
    alive       := true;
    health      := 100;
    allAIhealth := AInum*100;
    killed      := 0;
    AIy[0]:=19;
    AIx[0]:=70;
    for AIcount:=1 to AInum do
    begin
      AIalive[AIcount]:=true;
      AIhuong[AIcount]:='up';
      AIhealth[AIcount]:=100;
      AIx[AIcount]:=AIx[AIcount-1]-5;
      if AIx[AIcount]<3 then
      begin
        AIy[AIcount]:=AIy[AIcount-1]-7;AIx[AIcount]:=65;
      end
      else AIy[AIcount]:=AIy[AIcount-1];
    end;
    dam := 1;
    menu;
    readmap;
    drawmap;
    gotoxy(15,25);writebld;
    huong := 'right';
    x     := 2;y:=3;
    drawtank(x,y,'right');
    repeat
      play
    until 1=2;
  end;
  begin
    main;
  end.
