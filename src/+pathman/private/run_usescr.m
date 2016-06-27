function run_usescr( pack, usename )
conf = pathman.conf;
switch usename
    case 'use'
        scr = conf.ADDSCR(1:end-2);
    case 'unuse'
        scr = conf.RMSCR(1:end-2);
end

func = str2func(sprintf('pathman.%s.%s.%s',conf.PATHMODSUBPACKAGENAME, pack, scr));

func(get_package_dir(pack));


end

