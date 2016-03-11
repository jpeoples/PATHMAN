function run_usescr( pack, usename )
conf = pathman.conf;
switch usename
    case 'use'
        scr = conf.ADDSCR;
    case 'unuse'
        scr = conf.RMSCR;
end

func = str2func(sprintf('pathman.%s.%s.%s',conf.PATHMODSUBPACKAGENAME, pack, scr));

func(get_package_dir(pack));


end

