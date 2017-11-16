function    newLink  = completeUrl(link,url)

    % Take single parts
    urlSplit    = strsplit(url,'/');
    linkSplit   = strsplit(link,'/');
    
    % Find the first non-empty part of linkSplit
    while isempty(linkSplit{1}), linkSplit(1) = []; end
    idx = find(strcmp(linkSplit{1},urlSplit));
    if isempty(idx) % no common path
        if ~strcmp(linkSplit{1}(end),':')
            idx = length(urlSplit);         %prepent the whole url if no http, https or ftp was speficied
        else
            %The link is already valid
            newLink = link;
            return
        end 
    elseif idx == 1
        %The link is already valid
        newLink = link;
        return
    end
    
    % create the full link
    newLink = strjoin([urlSplit(1),strjoin([urlSplit(2:idx-1),linkSplit],'/')],'//');

    
    
    
    