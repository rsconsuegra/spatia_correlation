function [W,distance] = knn_weight_matrix(xc,yc,k)
%%PURPOSE: The function builds a k nearest neighbor N x N row-stochastic spatial weight matrix
% The function returns a sparse matrix W representing the spatial weight
% matrix
%%USAGE: W = knn_weight_matrix(xc,yc,k)
% where the following holds:
%           xc = an (n x 1) vector of longitude coordinates (in degrees)
%           yc = an (n x 1) vecotor of latitude coordinates (in degrees)
%           k = the number of nearest neighbors
%%NOTES: The code uses the haversine distance formula to create an
% N x N matrix of pairwise diatances

%%Rearrange coordinates and pre-allocate matrices
coordinates = [yc xc];
n = length(xc);

%%Create pairwise distance matrix using Haversine distance calculation

distance = zeros(n,n);
for u=1:n
    for v=u+1:n
        temp1 =  Distance_Calculations(coordinates(u,1),coordinates(u,2),coordinates(v,1),coordinates(v,2));
        distance(u,v) = temp1;
        distance(v,u) = temp1;
    end
end

%%Find indices for the nearest neighbors

% sort all rows of temp2
[~,xind] = sort(distance,2);
% extract first k columns of each (ignoring the first element which 
% is the distance from a coordinate to itself)
nnlist = xind(:,2:k+1);

%%Clear the distance matrix
clear xind temp1

%%Assign row-stochastic and sparse spatial weight matrix to nearest neighbors
%tempw=sparse(n,n);
W=sparse((1:n)',nnlist,1/k,238,238);
spy(W)
end