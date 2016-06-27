function  abs_path = absolutepath( path, rel_to )
%ABSOLUTEPATH  returns the absolute path relative to a given startpath.
%   From path, determine the absolute path.  Input path may be absolute
%   or relative.
%
%   The return value of this function does not indicate that the path
%   actually exists.

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
