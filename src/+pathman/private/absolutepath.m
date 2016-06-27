function  abs_path = absolutepath( path, rel_to )
%ABSOLUTEPATH  returns the absolute path relative to a given startpath.
%   From path, determine the absolute path.  Input path may be absolute
%   or relative.
%
%   The return value of this function does not indicate that the path
%   actually exists.
%
%   Note: One might expect that the file.getCanonicalPath function would
%   be enough to get the full path of either an absolute or relative
%   path.  However, if matlab has changed directory since java was
%   loaded, the result will be relative to the previous working
%   directory.  To mitigate this, we must pass concatenate the working
%   directory to the relative path, which obviously will fail for
%   absolute paths.
%
%   Therefore, we must detect absolute paths first.  All that this
%   function does is check if the path starts with
%       X: (for windows paths)
%   or
%       / or ~ (for unix-y paths)
%
%   This is probably not the most robust, but it works for now.

    if determine_absolute(path)
        % if we have an absolute path, return the absolute path.
        abs_path = path;
        return;
    end

    % otherwise we have a relative path.
    if nargin < 2
        rel_to = cd; % if not relative_to argument, use working directory.
    end

    %build absolute path
    file = java.io.File(fullfile(rel_to, path));
    abs_path = char(file.getCanonicalPath());

end

function tf = determine_absolute(path)

    regexp1 = '[a-zA-Z]?:'; % match windows abspath
    regexp2 = '^[/~]'; % match unix style abspath (or homedir)

    if any(regexp(path, regexp1)==1) || any(regexp(path, regexp2)==1)
        tf = true;
    else
        tf=false;
    end

end
