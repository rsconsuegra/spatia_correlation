clc;clearvars;close all;

load("datos_colegios.mat");

damage=sortrows(damage,3);

corr=zeros(length(damage));
dist=corr;
for i=1:3
    idx=find(damage(:,3)==i);
    corr(idx,idx)=i;
    dist=Distance_Calculations(damage(idx,1),damage(idx,2),damage(idx,1),damage(idx,2));
end

corre=sparse(corr);
spy(corre)
