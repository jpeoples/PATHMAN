function writepackageinfo( pinfo )

    name = pinfo.name;
    packagedir = get_package_dir(name);

    conf = pathman.conf();

    f = fullfile(packagedir, conf.INFOFILE);

    fid = fopen(f, 'w');

    fprintf(fid, '%s\n%s\n%s\n', pinfo.srcdir, pinfo.installdate, pinfo.modifieddate);

    fclose(fid);
end

