function [packageinfo, ignorelist] = get_initial_package_configuration(srcdir, opt)
%GET_INITIAL_PACKAGE_CONFIGURATION initialize package information.
%
    % start with basic
    packageinfo.name = opt.as;
    packageinfo.srcdir = srcdir;
    packageinfo.targetdir = get_package_dir(opt.as);
    packageinfo.installdate = get_datestr;
    packageinfo.modifieddate = get_datestr;

    packageinfo.ignorelist = get_ignore_list(packageinfo.srcdir, packageinfo.targetdir);

end
