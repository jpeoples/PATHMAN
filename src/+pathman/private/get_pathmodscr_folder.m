function [ foldern ] = get_pathmodscr_folder(packname )
    conf = pathman.conf;
    [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
    [pathstr, ~, ~] = fileparts(pathstr);

    targetdir = fullfile(pathstr, sprintf('+%s/+%s', conf.PATHMODSUBPACKAGENAME, packname'));

    foldern = targetdir;

end

