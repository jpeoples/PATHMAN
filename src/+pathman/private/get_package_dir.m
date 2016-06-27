function [ pdir ] = get_package_dir( name )
% GET_PACKAGE_DIR return package directory from package name.
%   Detailed explanation goes here

conf = pathman.conf;

pdir = [fullfile(conf.ROOT, name) conf.PACKAGEPOSTFIX];
end

