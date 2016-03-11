% PATHMAN manage matlab packages
% 
% Manage packages on the matlab path.
%
% Can be used to install, update, remove, add-to-path and remove-from-path
%
% Usage:
%   pathman install srcdir [as packname]
%       Installs the srcdir directory and all subdirs into the folder
%       'packname' in the PATHMANROOT (usually the MATLAB folder).  If
%       packname is not given, the name of the specified directory is used.
%       If a package with the specified name already exists, the function
%       will complain.
%
%   pathman update packname [with srcdir]
%       Overwrite the package packname with the contents of srcdir.  THIS
%       IS A DESTRUCTIVE OPERATION.
%
%       If no srcdir is given, update the package directory from its
%       original install location.
%
%   pathman remove/uninstall packname
%       Delete the packname folder from PATHMANROOT.  You may use the word
%       uninstall OR remove.
%
%   pathman use packname
%       Add the package packname to PATH
%
%   pathman unuse packname
%       Remove the package packname from PATH
%
%   pathman list [glob]
%       Return a list of installed packages.  If 'glob' is given, return
%       files matching glob
%
%   pathman conf
%       Open the pathman config file in the editor.
function pathman(varargin)
    if isempty(varargin)
        help_();
        return
    end

    subcmd = varargin{1};
    varargin(1) = [];

    switch subcmd
        case 'install'
            install(varargin{:});
        case 'update'
            update(varargin{:});
        case 'remove'
            remove(varargin{:});
        case 'use'
            use(varargin{:});
        case 'unuse'
            unuse(varargin{:});
        case 'list'
            list(varargin{:});
        case 'conf'
            conf(varargin{:});
        case 'help'
            help_(varargin{:})
    end

end


function conf(varargin)
    edit('pathman.conf')
    return
end

function help_(varargin)
    help(mfilename('fullpath'));
    return
end

function install(varargin)
    len = length(varargin);
    
    if len==0 || len >=4
        help_();
        return
    end
    
    if len >= 1
        srcdir = varargin{1};
    end
    
    
    
    if len == 1
        [~, target, ~] = fileparts(srcdir);
    end

   
    if len == 2
        target = varargin{2};
    end
    
    if len == 3
        hasas = strcmp(varargin{2}, 'as');
        if ~hasas
            help_();
            return
        end
        target = varargin{3};
    end
    
    pathman.install(srcdir, target, false); % don't overwrite existing
end

function update(varargin)
    len = length(varargin);
    
    if len < 1 || len >= 4
        help_();
        return
    end
    
    target = varargin{1};
    if len == 1
        srcdir = pathman.get_package_info(target);
        srcdir = srcdir.srcdir;
    end
    
    if len == 2

        srcdir = varargin{2};
    end
    
    if len == 3

        haswith = strcmp(varargin{2}, 'with');
        
        if ~haswith
            help_()
            return
        end
        srcdir = varargin{3};
    end
    
    pathman.install(srcdir, target, true); % DO overwrite existing
end

function remove(varargin)
    if length(varargin) ~= 1
        help_();
        return
    end
    
    packname = varargin{1};
    
    pathman.remove(packname);
end

function use(varargin)
    pathman.use(varargin{:});
end

function unuse(varargin)
    pathman.unuse(varargin{:});
end

function list(varargin)
    if length(varargin) > 1
        help_();
    end
    if length(varargin) == 1
        glob = [varargin{1}];
    else
        glob = '*';
    end
    
    pathman.list(glob);
end