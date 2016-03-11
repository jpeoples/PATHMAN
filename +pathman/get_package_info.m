function [ info ] = get_package_srcdir( name )

    if ~ispack(name)
        error('Package %s not found', name);
    end
    
    info = readpackageinfo(name);



end

