function [ conf ] = conf()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET PATHMAN ROOT DIRECTORY BEFORE FIRST USE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set this value to the path where you would like to install packages.  It
% is not necessary for the folder to exist, or to be on the MATLAB path.
conf.ROOT = '~/Documents/MATLAB/PATHMANPACKAGES';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not edit these values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist(conf.ROOT, 'dir')
    mkdir(conf.ROOT);
end

% add path install function name
conf.ADDSCR = 'addtopath.m';

% remove from path function name
conf.RMSCR = 'rmfrompath.m';

% default path add remover function
conf.MAKEPATHMODSCRIPTS = @buildpathmodscripts;

% package postfix
conf.PACKAGEPOSTFIX = '.pack';

conf.PATHMODSUBPACKAGENAME = 'pathmodscrs';

conf.INFOFILE = 'info.txt';



end

