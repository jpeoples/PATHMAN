function [ tf ] = ispack( name )
%ISPACK test if is a package

conf = pathman.conf;

tf = exist(get_package_dir(name));


end

