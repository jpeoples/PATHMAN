function unuse( varargin )

for i = 1:length(varargin)
    pack = varargin{i};

    if ~ispack(pack)
        warning('Package %s not found, path unchanged...', pack);
        continue;
    end

    run_usescr(pack, 'unuse');

end
