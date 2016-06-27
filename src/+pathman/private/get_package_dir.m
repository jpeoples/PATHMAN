function [ pdir ] = get_package_dir( name )
%GET_PACKAGE_DIR Summary of this function goes here
%   Detailed explanation goes here

conf = pathman.conf;

pdir = [fullfile(conf.ROOT, name) conf.PACKAGEPOSTFIX];
end

