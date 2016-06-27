function install(installdir)
    targetpackage = fullfile(installdir, '+pathman');

    val = 0;
    if exist(targetpackage, 'dir')
        val = input('Pathman appears to already be installed.\n\n1. Overwrite installation\n2. Keep configuration and path mod scripts\n\n>> ');
        if val < 1 || val > 2
            error('Invalid input');
        end
    end
    switch val
        case 0
            simple_install(installdir);

        case 1
            clear_target_package(targetpackage);
            simple_install(installdir);
        case 2
            pathmodsubpackage = copy_conf(targetpackage, '.');
            clear_target_package(targetpackage);
            simple_install(installdir);
            apply_conf('.', pathmodsubpackage, targetpackage);
    end

    cd(installdir);
    edit('pathman.conf');
end


function simple_install(installdir)
    copyfile('src/pathman.m', installdir);
    copyfile('src/+pathman', fullfile(installdir, '+pathman'));
end

function clear_target_package(targetpackage)
    rmdir(targetpackage, 's');
end


function list = copy_conf(targetpackage, odir)
    conffile = fullfile(targetpackage, 'conf.m');

    list = dir(targetpackage);

    list = list([list.isdir]);
    list = list(~strcmp('.', {list.name}) & ~strcmp('..', {list.name}));

    list = list(~strcmp('private', {list.name}));

    list = {list.name};
    copyfile(conffile, odir);

    for i = 1:length(list)
        f = fullfile(targetpackage, list{i});
        copyfile(f, fullfile(odir, list{i}));
    end
end

function apply_conf(src, subfolders, targetpackage)
    copyfile(fullfile(src, 'conf.m'), targetpackage);

    for i = 1:length(subfolders)
        f = fullfile(src, subfolders{i});
        copyfile(f, fullfile(targetpackage, subfolders{i}));

        rmdir(f, 's');
    end

    delete(fullfile(src, 'conf.m'));

end
