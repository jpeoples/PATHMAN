function use( varargin )

for i = 1:length(varargin)
    pack = varargin{i};

    if ~ispack(pack)
        warning('Package %s not found, and not added to path', pack);
        continue;
    end

    run_usescr(pack, 'use');

end

