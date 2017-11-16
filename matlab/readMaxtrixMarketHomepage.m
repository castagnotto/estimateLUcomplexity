function [subpage, matrices] = readMaxtrixMarketHomepage(url)

%   Function used to read an url, find subpages and matrices in matrix
%   market format

data = webread(src);

% cut off header and footer
headerEnd   = '</MAP>';
footerStart = '<P><HR><P>[ <A HREF="/MatrixMarket">Home</A> ]';

idxStart    = strfind(data,headerEnd)+length(headerEnd)+1;
idxEnd      = strfind(data,footerStart)-2;

data        = data(idxStart:idxEnd); 

% Find all hyperlinks
refStart    = 'HREF="';
refEnd      = '">';

idxStart    = strfind(data,refStart)+length(refStart);
idxEnd      = strfind(data,refEnd);

coll = {};
for iStr = 1:length(idxStart)
    currEnd  = find(idxEnd>idxStart(iStr),1);
    coll    = [coll; ['http://math.nist.gov/',data(idxStart(iStr):idxEnd(currEnd)-1)]];
end