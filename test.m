clc;clear all;

a=[1 3 6 4 3 2;
   2 4 5 7 8 1];
b=[2 3 5 3;
   8 6 2 5];

for u=1:6
    for v=1:4
        k(u,v)=norm(a(:,u)-b(:,v))
    end
end