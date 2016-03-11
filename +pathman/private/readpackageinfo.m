function [ pinfo ] = readpackageinfo( name )
    conf = pathman.conf();
    packagedir = get_package_dir(name);
    
    fid = fopen(fullfile(packagedir, conf.INFOFILE), 'r');
    
    pinfo.srcdir = fgetl(fid);
    pinfo.install_date = fgetl(fid);
    pinfo.last_update = fgetl(fid);
    
    fclose(fid);
end

