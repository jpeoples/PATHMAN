function install( srcdir, opt )
    %INSTALL Installs a package from source
    % parse options
    srcdir = absolutepath(srcdir);
    if strcmp(opt.as, '')
        opt.as = default_package_name(srcdir);
    end

    packname = opt.as;

    if ispack(packname)
        error('Package name %s already exists', packname);
    end

    % packageinfo has fields
    % .conf
    %   .name
    %   .srcdir
    %   .targetdir
    %   .installdate
    %   .modifieddate
    %   .ignorelist
    packageinfo = get_initial_package_configuration(srcdir, opt);

    update_package(packageinfo);
end

