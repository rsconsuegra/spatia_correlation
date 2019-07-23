clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

%% Asumiendo independencia
for k=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),k),[1 2]);
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),200);
    [~,c]=size(d);
    frec=zeros(3,1);
    dist=[];
    for l=1:c
        dist=[dist;danos(d(:,c)==1,3)];
        t=tabulate(danos(d(:,c)==1,3));
        frec=frec+t(:,2);
    end    
    pareto(frec);
    figure()
    histogram(dist)
    pause()
    close all
end
%% 