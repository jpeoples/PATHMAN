function packageinfo = get_initial_package_configuration(srcdir, opt)
%GET_INITIAL_PACKAGE_CONFIGURATION initialize package information.
%
    % start with basic
    packageinfo.name = opt.as;
    packageinfo.srcdir = srcdir;
    packageinfo.targetdir = opt.to;
    packageinfo.installdate = date;
    packageinfo.modifieddate = date;
    packageinfo.flatten = ~opt.noflatten

    ignorelist = get_ignore_list(packageinfo.srcdir, opt.keepnonm);
    keeplist = get_keep_list(packageinfo.srcdir);

    packageinfo.srcfiles = walkfiles(packageinfo.srcdir, 'mignore', ignorelist, 'nonmkeep',  keeplist);

    packageinfo.targetfiles = {};

end
