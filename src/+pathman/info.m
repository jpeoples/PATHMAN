function info(packname)
    packageinfo = readpackageinfo(packname);
    fprintf('Name:           %s\n', packageinfo.name);
    fprintf('Source dir:     %s\n', packageinfo.srcdir);
    fprintf('Install date:   %s\n', packageinfo.installdate);
    fprintf('Last updated:   %s\n', packageinfo.modifieddate);
end
