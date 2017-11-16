% Load matrices from external sources in order to generate training and
% validation data

%% List of collections on math.nist.gov/MatrixMarket

src = 'http://math.nist.gov/MatrixMarket/data/';

[subpages, matrices] = readMaxtrixMarketHomepage(src);




       
%% Find all download links
for iColl = 1:length(coll)
    src     = coll{iColl};
    data    = webread(src);
end

%   Reading the matrices
% [A, rows, cols, entries] = mmread(filename);