function [ pinfo ] = readpackageinfo( name )
    conf = pathman.conf();
    packagedir = get_package_dir(name);

    fid = fopen(fullfile(packagedir, conf.INFOFILE), 'r');
    pinfo.srcdir = fgetl(fid);
    pinfo.installdate = fgetl(fid);
    pinfo.modifieddate = fgetl(fid);

    pinfo.targetdir = packagedir;
    fclose(fid);

    pinfo.ignorelist = get_ignore_list(pinfo.srcdir, pinfo.targetdir);
    pinfo.name = name;
end

