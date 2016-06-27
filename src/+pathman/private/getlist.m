function [ packnames ] = getlist( glob )

conf = pathman.conf;



packs = dir(fullfile(conf.ROOT, normalize_glob(glob)));

packnames = cell(1, length(packs));
for i = 1:length(packs)
    name = packs(i).name;
    [~, name, ~] = fileparts(name);
    
    packnames{i} = name;


end

