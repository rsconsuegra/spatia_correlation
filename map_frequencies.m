clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

pancarta={'1-INSPECCIONADO','2-USO RESTRINGIDO','3-INSEGURO'};
desempeno={'MEJOR','IGUAL','PEOR'};
color={'*g','*y','*r'};
rgb=[0, 0.5, 0;
    0.9290, 0.6940, 0.1250;
    1, 0, 0];

radii=1;
root='Imagenes2';

exppath=fullfile(root,[num2str(radii*1000) 'm']);
mapspath=fullfile(root,[num2str(radii*1000) 'm'],'Maps');
histspath=fullfile(root,[num2str(radii*1000) 'm'],'Histograms');

if(not(exist(exppath,'dir')))
    mkdir(exppath)
    mkdir(mapspath)
    mkdir(histspath)
end


for pancarta_estado=1:3
    %Los centroides son colegios, agrupamos por pancarta para ver
    %frecuencias
    centroids=damage(ismember(damage(:,3),pancarta_estado),[1 2]);
    
    d=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),radii);
    [~,Colegios]=size(d);
    
    dist=[];
    colors=zeros(Colegios,1);
    for Colegio=1:Colegios
        frec=zeros(3,1);
        t=tabulate(danos(d(:,Colegio)==1,3));
        if length(t(:,1))<3
            frec(t(:,1))=frec(t(:,1))+t(:,2);
        else
            frec=frec+t(:,2);
        end
        [~,index]=max(frec);
        centroids(Colegio,3)=index;
    end
    
%     figure('name','Colegios-Ecuador');
%     geoscatter(centroids(:,1),centroids(:,2),20,centroids(:,3))
%     set(gcf,'NumberTitle','off','Position', get(0, 'Screensize'));
%     geobasemap('landcover')

    close all;
    
    figure('name','Colegios-Ecuador (Burbujas)');
    %geobubble(centroids(:,1),centroids(:,2),10,categorical(pancarta(centroids(:,3))));
    geobubble(centroids(:,1),centroids(:,2),10,categorical(pancarta(centroids(:,3))),'BubbleColorList',rgb);
    set(gcf,'NumberTitle','off','Position', get(0, 'Screensize'));
    geobasemap('landcover')
    pname=['Bubbles ' num2str(radii) ' km ' pancarta{pancarta_estado} '.png'];
    saveas(gcf,fullfile(mapspath,pname))
        
    pause(5)
    
    figure('name','Colegios-Ecuador (Histograma)');
    histogram(categorical(centroids(:,3),[1 2 3],pancarta))
    title([pancarta{pancarta_estado} ' radii=' num2str(radii)]);
    pname=['Histogram ' num2str(radii) ' km ' pancarta{pancarta_estado} '.png'];
    saveas(gcf,fullfile(histspath,pname))
    pause(5)    
end