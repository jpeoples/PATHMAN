function target = default_package_name(srcdir)
% Compute a default package name from src directory.
% Called when installing, if no 'as' param provided.
%

    srcdir = absolutepath(srcdir);

    [~, target, ~] = fileparts(srcdir);

end
