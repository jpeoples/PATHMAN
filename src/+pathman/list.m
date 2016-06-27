function list( glob )

packages = getlist(glob);

for i = 1:length(packages)
    pack = packages{i};
    
    disp(pack);
end


end

