function [ conf ] = conf()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT THESE VALUES AS NECESSARY/DESIRED BEFORE FIRST USE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set this value to the path where you would like to install packages.  It
% is not necessary for the folder to exist, or to be on the MATLAB path.
conf.ROOT = '~/Documents/MATLAB/PATHMANPACKAGES';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You shouldn't need to edit these values, though you may.
%
% Editing values after using pathman to install packages will likely result
% in errors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist(conf.ROOT, 'dir')
    mkdir(conf.ROOT);
end

% add path install function name
conf.ADDSCR = 'addtopath';

% remove from path function name
conf.RMSCR = 'rmfrompath';

% default path add remover function
conf.MAKEPATHMODSCRIPTS = @buildpathmodscripts;

% package postfix
conf.PACKAGEPOSTFIX = '.pack';

conf.PATHMODSUBPACKAGENAME = 'pathmodscrs';

conf.INFOFILE = 'info.txt';



end

