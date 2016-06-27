function update(packname, opt)
    if ~ispack(packname)
        error('Package %s does not exist. Use pathman install to install', packname);
    end
    packageinfo = readpackageinfo(packname);


    if ~strcmp(opt.with, '') % srcdir given
        packageinfo.srcdir = absolutepath(opt.with);
    end

    update_package(packageinfo);
end
