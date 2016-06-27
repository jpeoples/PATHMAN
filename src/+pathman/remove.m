function remove( packname )
%REMOVE Summary of this function goes here
%   Detailed explanation goes here
if ~ispack(packname)
    warning('No such package "%s"', packname);
    return
end

packdir = get_package_dir(packname);
installscrdir = get_pathmodscr_folder(packname);

rmdir(packdir, 's');
rmdir(installscrdir, 's');
end

