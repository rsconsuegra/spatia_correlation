clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

pancarta={'INSPECCIOANDO','USO RESTRINGIDO','INSEGURO'};
color={'*r','*b','*g'};

radii=1;
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
        dist=[dist;danos(d(:,l)==1,3)];
        t=tabulate(danos(d(:,l)==1,3));
        if length(t(:,1))<3
            frec(t(:,1))=frec(t(:,1))+t(:,2);
        else
            frec=frec+t(:,2);
        end
        [~,i]=max(frec);
        if (i<k)
            centroids(l,3)=1;
        elseif (i>k)
            centroids(l,3)=3;
        else
            centroids(l,3)=2;
        end
    end
    hold on;
    p1=centroids(centroids(:,3)==1,:);
    plot(p1(:,1),p1(:,2),'*r');

    p2=centroids(centroids(:,3)==2,:);
    plot(p2(:,1),p2(:,2),'*b');

    p3=centroids(centroids(:,3)==3,:);
    plot(p3(:,1),p3(:,2),'*g');
    
    pause()
    close all;
end
%% 