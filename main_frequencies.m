clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

pancarta={'INSPECCIOANDO','USO RESTRINGIDO','INSEGURO'};
radii=50;
%% Asumiendo independencia
for k=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),k),[1 2]);
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),radii);
    [~,c]=size(d);
    frec=zeros(3,1);
    dist=[];
    for l=1:c
        dist=[dist;danos(d(:,c)==1,3)];
        t=tabulate(danos(d(:,c)==1,3));
        frec=frec+t(:,2);
    end
    subplot(3,2,2*k-1)
    pareto(frec);
    title([pancarta{k} ' radii=' num2str(radii)]);
    subplot(3,2,2*k)
    histogram(dist)
    title([pancarta{k} ' radii=' num2str(radii)]);
end
%% 