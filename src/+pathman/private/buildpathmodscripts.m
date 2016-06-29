function buildpathmodscripts( packname )
    conf = pathman.conf;
    targetdir = get_pathmodscr_folder(packname);
    if ~exist(targetdir, 'dir')
        mkdir(targetdir);
    end

    addscrname = conf.ADDSCR;
    rmscrname = conf.RMSCR;

    addcmd = sprintf('function %s(pd)\naddpath(genpath(pd));', addscrname(1:end-2));
    rmcmd = sprintf('function %s(pd)\nrmpath(genpath(pd));', rmscrname(1:end-2));

    addscrname = addscrname;
    rmscrname = rmscrname;

    fid = fopen(fullfile(targetdir, addscrname), 'w');

    fprintf(fid, addcmd);
    fclose(fid);

    fid = fopen(fullfile(targetdir, rmscrname), 'w');

    fprintf(fid, rmcmd);
    fclose(fid);
end

