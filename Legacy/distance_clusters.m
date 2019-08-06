clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

pancarta={'INSPECCIOANDO','USO RESTRINGIDO','INSEGURO'};
color={'*r','*b','*g'};

radii=8;
%% Asumiendo independencia
for k=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),k),[1 2]);
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),radii);
    [~,c]=size(d);
    plot(danos(:,1),danos(:,2),'*k')
    hold on;
    for l=1:c
        points=danos(d(:,l)==1,:);
        
        p1=points(points(:,3)==1,:);
        plot(p1(:,1),p1(:,2),'*r');
        
        p2=points(points(:,3)==2,:);
        plot(p2(:,1),p2(:,2),'*b');
        
        p3=points(points(:,3)==3,:);
        plot(p3(:,1),p3(:,2),'*g');
    end
    plot(centroids(:,1),centroids(:,2),'+m')
    pause()
    close all;
end
%%