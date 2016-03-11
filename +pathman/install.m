function install( srcdir, packname, overwrite )
%INSTALL Installs a package from source
    srcdir = absolutepath(srcdir);
    conf = pathman.conf;
    
    % get the target package directory
    packagedir = get_package_dir(packname);%fullfile(conf.ROOT, packname);

    if ispack(packname)
        if overwrite
            packageinfo = readpackageinfo(packname);
            pathman.remove(packname);
        else
            error('Package name %s already exists', packname);
        end
    else
        packageinfo.install_date = date;
    end
    
    packageinfo.srcdir = srcdir;
    packageinfo.last_update = date;
    
    hasscripts = copy_scripts(srcdir, get_pathmodscr_folder(packname));
    if ~hasscripts
        conf.MAKEPATHMODSCRIPTS(packname)
    end
    
    mirror_src(srcdir, packagedir, hasscripts);
    writepackageinfo(packageinfo, packname);
end

function hasscripts = copy_scripts( srcdir, targetdir)
    conf = pathman.conf;
    usescr = fullfile(srcdir, [conf.ADDSCR '.m']);
    unusescr = fullfile(srcdir, [conf.RMSCR '.m']);
    
    if exist(usescr, 'file') && exist(unusescr, 'file')
        mkdir(targetdir);
        copyfile(usescr, fullfile(targetdir, 'add.m'));
        copyfile(unusescr, fullfile(targetdir, 'remove.m'));
        hasscripts = true;
    elseif exist(usescr, 'file') || exist(unusescr, 'file')
        error('Either both or neither install scripts should exist');
    else
        hasscripts = false;
    end
end

function mirror_src(srcdir, packagedir, hasscripts)
    conf = pathman.conf;
    copyfile(srcdir, packagedir)
    
    if hasscripts
        usescr = fullfile(packagedir, [conf.USESCR '.m']);
        unusescr = fullfile(packagedir, [conf.UNUSESCR '.m']);
        
        delete(usescr);
        delete(unusescr);
    end

end