function ignorelist = get_ignore_list(srcdir, targetdir)
% GET_IGNORE_LIST parse the .pathmanignore list of files/directories.
%

    conf = pathman.conf;
    ignorelist = {fullfile(targetdir, '.pathmanignore'), ...
                  fullfile(targetdir, conf.ADDSCR), ...
                  fullfile(targetdir, conf.RMSCR)};


    ignorelist = parse_pathmanignore(ignorelist, srcdir, targetdir);
end

function ignorelist = parse_pathmanignore(ignorelist, srcdir, targetdir)
    igfile = fullfile(srcdir, '.pathmanignore');

    if ~exist(igfile, 'file')
        return;
    end

    fid = fopen(igfile);

    line = fgetl(fid);

    while (line ~= -1)
        ignorelist{end+1} = fullfile(targetdir, line);
        line = fgetl(fid);
    end

    fclose(fid);


end
