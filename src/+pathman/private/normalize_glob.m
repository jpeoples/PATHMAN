function [ glob ] = normalize_glob( glob )
%NORMALIZE_GLOB Summary of this function goes here
%   Detailed explanation goes here

conf = pathman.conf;

glob = [glob conf.PACKAGEPOSTFIX '*'];
end

