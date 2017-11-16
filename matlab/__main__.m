%   Main MATLAB script to generate the data to train a NN
%
%   Read matrices from the MatrixMarket collection at
%
%       http://math.nist.gov/MatrixMarket/
%
%   and perform LU decompositions to all of them. 
%
%   Save the time for one LU decomposition and whether a (sparse) LU
%   decomposition is possible on a machine with following characteristics:
%
%               Dell Precision WorkStation T7500
%               Intel Xeon CPU E5520 @ 2.27 GHz, 2261 MHz, 4 Kernels
%               50GB RAM 

%% Read the matrices from math.nist.gov

importMatrices;

generateLabels; %TODO

saveData; %TODO
