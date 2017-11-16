% Load matrices from external sources in order to generate training and
% validation data

%% List of collections on math.nist.gov/MatrixMarket
clc
src = 'http://math.nist.gov/MatrixMarket/data/';

[~, matrices] = readMaxtrixMarketHomepage(src);


%   Reading the matrices
% [A, rows, cols, entries] = mmread(filename);