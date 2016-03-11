function [ tf ] = ispack( name )
%ISPACK test if is a package

conf = pathman.conf;

tf = exist([fullfile(conf.ROOT, name) conf.PACKAGEPOSTFIX]);


end

