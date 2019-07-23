function [distance] = nn_distance(xc,yc,xe,ye,k)
%%PURPOSE: 
%%USAGE: W = nn_distance(xc,yc,k)
% where the following holds:
%           xc = an (n x 1) vector of longitude coordinates (in degrees)
%           yc = an (n x 1) vecotor of latitude coordinates (in degrees)
%           k = the number of nearest neighbors
%%NOTES: The code uses the haversine distance formula to create an
% N x N matrix of pairwise diatances

%%Rearrange coordinates and pre-allocate matrices
colegios = [yc xc];
edificios = [ye xe];
n = length(xe);
m = length(xc);
%%Create pairwise distance matrix using Haversine distance calculation

distance = zeros(n,m);
for u=1:n
    for v=1:m
        temp1 =  Distance_Calculations(colegios(v,1),colegios(v,2),edificios(u,1),edificios(u,2));
        if(temp1<=k)
            distance(u,v)= 1;
        end
    end
end
end