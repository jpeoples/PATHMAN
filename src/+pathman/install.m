function install( srcdir, opt )
    %INSTALL Installs a package from source
    srcdir = absolutepath(srcdir);

    % parse options
    if strcmp(opt.as, '')
        opt.as = default_package_name(srcdir);
    end
    if strcmp(opt.to, '')
        opt.to = get_package_dir(opt.as);
    end

    packname = opt.as;

    if ispack(packname)

        %if overwrite
            %packageinfo = readpackageinfo(packname);
            %pathman.remove(packname);
        %else
        error('Package name %s already exists', packname);
        %end
    end

    % packageinfo has fields
    % .conf
    %   .name
    %   .srcdir
    %   .targetdir
    %   .installdate
    %   .modifieddate
    %   .srcfiles
    %   .targetfiles
    packageinfo = get_initial_package_configuration(srcdir, opt);

    update_package(packageinfo);


    %packagedir = get_package_dir(packname);%fullfile(conf.ROOT, packname);


    %packageinfo = get_package_configuration(packname);

    %packageinfo.install_date = date;
    %packageinfo.srcdir = srcdir;
    %packageinfo.last_update = date;
    %packageinfo.target_dir = actualtarget;
    %packageinfo.flatten = flatten;
    %packageinfo.keepnonm = keepnonm;

    %packageinfo = read_package_conf(srcdir, packageinfo);

    %hasscripts = copy_scripts(srcdir, get_pathmodscr_folder(packname));
    %if ~hasscripts
        %conf.MAKEPATHMODSCRIPTS(packname)
    %end

    %mirror_src(srcdir, packagedir, hasscripts);
    %writepackageinfo(packageinfo, packname);
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
    copyfile(srcdir, packagedir);

    if hasscripts
        usescr = fullfile(packagedir, [conf.USESCR '.m']);
        unusescr = fullfile(packagedir, [conf.UNUSESCR '.m']);

        delete(usescr);
        delete(unusescr);
    end

end
