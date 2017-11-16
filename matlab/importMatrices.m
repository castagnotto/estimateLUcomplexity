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

%%   Download the matrices onto .data/

% MATLAB CANNOT DOWNLOAD THE FILE FROM THE FTP SERVER...!
% Using system commands instead...
fid = fopen('data/batchDonwloadFiles.bat','w');
fprintf(fid,'bitsadmin /reset \npause\n');
fprintf(fid,'bitsadmin /create myDownloadJob\npause\n');
fprintf(1,'bitsadmin /create myDownloadJob\n');

for iMat = 1:nMatrices
    url     = matrices{iMat};
    idxName = strfind(url,'/'); idxName = idxName(end);
    target  = sprintf('%sdata%s%s','C:\Users\castagnotto\Documents\estimateLUcomplexity\matlab\',filesep,url(idxName+1:end)); 
    fprintf(fid,'bitsadmin /addfile myDownloadJob %s %s\npause\n',url,target);
    fprintf(1,'bitsadmin /addfile myDownloadJob %s %s\n',url,target);
end

fprintf(fid,'bitsadmin /resume myDownloadJob\n');
fprintf(fid,'bitsadmin /monitor\n');
fprintf(fid,'bitsadmin /reset \npause\n');
fclose(fid);

%now run the batch file on your own..
