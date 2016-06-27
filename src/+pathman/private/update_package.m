function update_package(packageinfo)

    conf = pathman.conf;

    pdir = get_package_dir(packageinfo.name);

    hasscripts = copy_scripts(packageinfo.srcdir, packageinfo.name);

    if ~hasscripts
        conf.MAKEPATHMODSCRIPTS(packageinfo.name);
    end

    mirror_src(packageinfo.srcdir, packageinfo.targetdir, packageinfo.ignorelist);

    packageinfo.modifieddate = get_datestr;
    packageinfo.srcdir = absolutepath(packageinfo.srcdir); % ensure srcdir is abs

    writepackageinfo(packageinfo);
end

function hasscripts = copy_scripts( srcdir, packname)
    conf = pathman.conf;

    % get script names
    usescr = fullfile(srcdir, conf.ADDSCR);
    unusescr = fullfile(srcdir, conf.RMSCR);

    targetdir = get_pathmodscr_folder(packname);
    if exist(usescr, 'file') && exist(unusescr, 'file')
        mkdir(targetdir);
        copyfile(usescr, fullfile(targetdir, conf.ADDSCR));
        copyfile(unusescr, fullfile(targetdir, conf.RMSCR));
        hasscripts = true;
    elseif exist(usescr, 'file') || exist(unusescr, 'file')
        error('Either both or neither install scripts should exist');
    else
        hasscripts = false;
    end
end

function mirror_src(srcdir, packagedir, ignorefiles)
    conf = pathman.conf;

    % copy all
    copyfile(srcdir, packagedir);

    % delete ignored files
    for i = 1:length(ignorefiles)
        fname = ignorefiles{i};
        if exist(fname, 'dir')
            rmdir(fname, 's');
        elseif exist(fname, 'file')
            delete(fname);
        end
    end

end
