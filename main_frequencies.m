clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

%% Asumiendo independencia

for k=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),k),[1 2]);
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),50);
    [~,c]=size(d);
    q=zeros(3,1);
    for l=1:c
        t=tabulate(danos(d(:,c)==1,3));
        q=q+t(:,2);
    end
    pareto(q);
    pause()
end
%% 