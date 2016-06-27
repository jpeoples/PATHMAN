% PATHMAN manage matlab packages
%
% Manage packages on the matlab path.
%
% Can be used to install, update, remove, add-to-path and
% remove-from-path
%
% Usage:
%   pathman install srcdir [as packname]
%       Installs the srcdir directory and all subdirs into the directory
%       PATHMANROOT/packname if unspecified.  If packname is not given,
%       the name of the specified directory is used.  If a package with
%       the specified name already exists, the function will complain.
%
%   pathman update packname [with srcdir]
%       Overwrite the package packname with the contents of srcdir.
%       THIS IS A DESTRUCTIVE OPERATION.
%
%       If no srcdir is given, update the package directory from its
%       original install location.
%
%       If srcdir is different from the original install location, the
%       install location will be updated, and future update will use the
%       new srcdir for updates.
%
%   pathman remove/uninstall packname
%       Remove package packname and all files generated for it by
%       pathman. (Does not affect install src directory.)
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
%   pathman info packname
%       Display information and configuration regarding package
%       packname.
%
%   Jacob Peoples, 2016
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
        case 'uninstall'
            remove(varargin{:});
        case 'use'
            use(varargin{:});
        case 'unuse'
            unuse(varargin{:});
        case 'list'
            list(varargin{:});
        case 'info'
            info(varargin{:})
        otherwise
            help_(varargin{:})
    end

end


function opt = parse(opt, argin, errmsg)
    if nargin<3
        errmsg = '';
    end

    [opt, unparsed] = pathman.ezparse(opt, argin);

    if ~isempty(unparsed)
        help_();
        error(errmsg);
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

    srcdir = varargin{1};

    opt.as = '';

    opt = parse(opt, varargin(2:end));

    pathman.install(srcdir, opt);
end


function update(varargin)

    packname = varargin{1};

    opt.with = '';
    opt = parse(opt, varargin(2:end));

    pathman.update(packname, opt);
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
        return;
    end
    if length(varargin) == 1
        glob = [varargin{1}];
    else
        glob = '*';
    end

    pathman.list(glob);
end

function info(varargin)

    if length(varargin) ~= 1
        help_();
        return;
    end

    packname = varargin{1};

    pathman.info(packname);
end
