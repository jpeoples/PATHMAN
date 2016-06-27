function files = walkfiles(srcdir, varargin)

    opt.mignore.list = {};
    opt.mignore.patterns = {};
    opt.mignore.all = false;
    opt.nonmkeep.list = {};
    opt.nonmkeep.patterns = {};
    opt.nonmkeep.all = false;

    [opt, unparsed] = pathman.ezparse(opt, varargin);

    if ~unparsed(isempty)
        error('Unrecognized options...');
    end

    files = walk_r(srcdir, opt, {});
end

function files = walk_r(srcdir, opt, files)

    lst = dir(srcdir);

    mfiles = {};
    nonmfiles = {};
    for i = 1:length(lst)
        node = lst{i};

        if node.isdir
            path = fullfile(srcdir, note.name);
            newfiles = walk_r(path, opt, files);
            files(end+1:end+length(newfiles)) = newfiles;
            continue;
        end

        % not a dir, hence a file
        [~, name, ext] = fileparts(node.name);

        if strcmp(ext, '.m')
            mfiles{end+1} = fullfile(srcdir, node.name);
        else
            nonmfiles{end+1} = fullfile(srcdir, node.name);
        end

    end

    mfiles = filterm(mfiles, opt.mignore);
    nonmfiles = filternonm(nonmfiles, opt.nonmkeep);

    files(end+1:end+length(mfiles)) = mfiles;
    files(end+1:end+length(nonmfiles)) = nonmfiles;
end

function mfiles = filterm(mfiles, mignore)
    if mignore.all
        mfiles = {};
        return;
    end

    outmfiles = {};
    for i = 1:length(mfiles)
        name = mfiles{i};
        if any(ismember(mignore.list, name))
            continue
        end

        mflag = false;
        for patind = 1:length(mignore.patterns)
            if ~(regexp(name, mignore.patterns{i}) == 0)
                mflag = true;
                break
            end
        end
        if mflag
            continue;
        end

        outmfiles{end+1} = name;
    end
    mfiles = outmfiles;
end

function filternonm(nonmfiles, nonmkeep)

    if nonmkeep.all
        return;
    end

    outfiles = {};
    for i = 1:length(nonmfiles)
        name = nonmfiles{i};

        if any(ismember(nonmkeep.list, name))
            outfiles{end+1} = name;
        end

        mflag = true;

