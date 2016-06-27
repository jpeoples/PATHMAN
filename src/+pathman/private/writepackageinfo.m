function writepackageinfo( pinfo, name )

    packagedir = get_package_dir(name);
    
    conf = pathman.conf();
    
    f = fullfile(packagedir, conf.INFOFILE);
    
    fid = fopen(f, 'w');
    
    fprintf(fid, '%s\n%s\n%s\n', pinfo.srcdir, pinfo.install_date, pinfo.last_update);
    
    fclose(fid);
end

