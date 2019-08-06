clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

pancarta={'INSPECCIONADO','USO RESTRINGIDO','INSEGURO'};
color={'*r','*b','*g'};

radii=1;
root='Imagenes';

exppath=fullfile(root,[num2str(radii*1000) 'm']);
mapspath=fullfile(root,[num2str(radii*1000) 'm'],'Maps');
histspath=fullfile(root,[num2str(radii*1000) 'm'],'Histograms');

if(not(exist(exppath,'dir')))
    mkdir(exppath)
    mkdir(mapspath)
    mkdir(histspath)
end


for k=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),k),[1 2]);
    
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),radii);
    [~,Colegios]=size(d);
    
    dist=[];
    for Colegio=1:Colegios
        frec=zeros(3,1);
        dist=[dist;danos(d(:,Colegio)==1,3)];
        t=tabulate(danos(d(:,Colegio)==1,3));
        if length(t(:,1))<3
            frec(t(:,1))=frec(t(:,1))+t(:,2);
        else
            frec=frec+t(:,2);
        end
        [~,i]=max(frec);
        if (i<k)
            centroids(Colegio,3)=1;
        elseif (i>k)
            centroids(Colegio,3)=3;
        else
            centroids(Colegio,3)=2;
        end
    end
    
%     figure('name','Colegios-Ecuador');
%     geoscatter(centroids(:,1),centroids(:,2),20,centroids(:,3))
%     set(gcf,'NumberTitle','off','Position', get(0, 'Screensize'));
%     geobasemap('landcover')

    figure('name','Colegios-Ecuador (Burbujas)');
    geobubble(centroids(:,1),centroids(:,2),10,categorical(pancarta(centroids(:,3))));
    set(gcf,'NumberTitle','off','Position', get(0, 'Screensize'));
    geobasemap('landcover')
    pname=['Bubbles ' num2str(radii) ' km ' pancarta{k} '.png'];
    saveas(gcf,fullfile(mapspath,pname))
        
    pause(5)
    
    figure('name','Colegios-Ecuador (Histograma)');
    histogram(centroids(:,3))
    title([pancarta{k} ' radii=' num2str(radii)]);
    pname=['Histogram ' num2str(radii) ' km ' pancarta{k} '.png'];
    saveas(gcf,fullfile(histspath,pname))
    pause(5)
    
    close all;
end
%% 