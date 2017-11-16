% Load matrices from external sources in order to generate training and
% validation data

%% List of collections on math.nist.gov/MatrixMarket

%   Generate the list of matrices
src = 'http://math.nist.gov/MatrixMarket/data/';
[~, matrices]   = readMaxtrixMarketHomepage(src);
nMatrices       = length(matrices);
fprintf(1,'\n\nNumber of matrices found on Matrix Market: \t%6i\n',nMatrices);

%   Save the list
save(sprintf('data/MatrixMarket_listOfMatrices_%s.mat',datestr(now,'yyyymmdd_HHMM')),'matrices');
fid = fopen('data/MatrixMarket_listOfMatrices.txt','w');
fprintf(fid,'%s\n',matrices{:});
fclose(fid);

%   Download the matrices onto .data/
for iMat = 1:nMatrices
    
end