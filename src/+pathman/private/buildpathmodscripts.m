function buildpathmodscripts( packname )
    conf = pathman.conf;
    targetdir = get_pathmodscr_folder(packname);
    mkdir(targetdir);
    
    addscrname = conf.ADDSCR;
    rmscrname = conf.RMSCR;
    
    addcmd = sprintf('function %s(pd)\naddpath(genpath(pd));', addscrname);
    rmcmd = sprintf('function %s(pd)\nrmpath(genpath(pd));', rmscrname);
    
    addscrname = [addscrname '.m'];
    rmscrname = [rmscrname '.m'];
    
    fid = fopen(fullfile(targetdir, addscrname), 'w');
    
    fprintf(fid, addcmd);
    fclose(fid);
    
    fid = fopen(fullfile(targetdir, rmscrname), 'w');
    
    fprintf(fid, rmcmd);
    fclose(fid);
end

