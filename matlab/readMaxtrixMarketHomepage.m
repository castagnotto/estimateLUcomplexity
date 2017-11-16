function [subpages, matrices] = readMaxtrixMarketHomepage(url)

%   Function used to read an url, find subpages and matrices in matrix
%   market format

%% Extract information from the webpage
fprintf(1,'Reading from %s...\n',url)
try
    data = webread(url);
catch err
    fprintf(2,'URL "%s" could not be read and is skipped.\nThis was the error message:\n%s',url,err.message);
    subpages = {};
    matrices = {};
    return
end

% cut off header and footer (this is actually looking for the first list)
headerEnd   = '<UL>';
footerStart = '</UL>';

idxStart    = strfind(data,headerEnd);
idxEnd      = strfind(data,footerStart)+length(footerStart)-1;

data        = data(idxStart:idxEnd); 

%% Find all subpages
refStart    = 'HREF="';
refEnd      = '">'; % '.html">' ending will be dealt with later on

idxStart    = strfind(data,refStart)+length(refStart);
idxEnd      = strfind(data,refEnd);

subpages     = {};
for iStr = 1:length(idxStart)
    currEnd  = find(idxEnd>idxStart(iStr),1);
    newSubpage  = data(idxStart(iStr):idxEnd(currEnd)-1);
    newSubpage  = completeUrl(newSubpage,url);  %make sure url is complete
    subpages    = [subpages; newSubpage];       %#ok<AGROW>
end

%% Find all matrices
refEnd      = '.mtx.gz">';
idxEnd      = strfind(data,refEnd);

matrices    = {};
for iStr = 1:length(idxEnd)
    currStart  = find(idxEnd(iStr) < idxStart ,1) - 1;
    newMatrix  = data(idxStart(currStart):idxEnd(iStr)+length(refEnd)-3);
    newMatrix  = completeUrl(newMatrix,url);  %make sure url is complete
    matrices = [matrices; newMatrix]; %#ok<AGROW>
    fprintf(1,'+ Added matrix %s...\n',newMatrix);
end

%% Call function recursively to explore the whole website
while ~isempty(subpages)
    [newSubpages,newMatrices] = readMaxtrixMarketHomepage(subpages{1});
    subpages     = [subpages(2:end);newSubpages];   %remove the page just searched and add all other ones
    matrices    = [matrices, newMatrices];          %#ok<AGROW>
end
