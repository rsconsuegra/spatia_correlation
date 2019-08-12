%% Main function: Plots the category (Pancarta-ish) of the schools, respect the buildings around an specific radii.
% Future work: Convert this to a function, in order to call it in an
% main handler.
% Requires to have previously storage the data (after the pre-processing) in a .mat file.
% Note: Works on R2018b and up. 
% Vars clarification: 
%                       banner: is the value of the Pancarta
%                       exppath: the absolute path of the experiment's folder

clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

banner={'1-INSPECCIONADO','2-USO RESTRINGIDO','3-INSEGURO'};

rgb=[0, 0.5, 0; %g
    0.9290, 0.6940, 0.1250; %y
    1, 0, 0]; %b

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


for banner_state=1:3
    %Centroids are schools, choosen by banner value, in order to analyze frequencies.
    
    centroids=damage(ismember(damage(:,3),banner_state),[1 2]);
    
    distance=nn_distance(centroids(:,1),centroids(:,2),danos(:,1),danos(:,2),radii);
    [~,Schools]=size(distance);
    
    for School=1:Schools
        frec=zeros(3,1);
        tabulation=tabulate(danos(distance(:,School)==1,3));
        if length(tabulation(:,1))<3
            frec(tabulation(:,1))=frec(tabulation(:,1))+tabulation(:,2);
        else
            frec=frec+tabulation(:,2);
        end
        [~,index]=max(frec);
        centroids(School,3)=index;
    end
    
    close all;
    
    figure('name','Colegios-Ecuador (Burbujas)');
    geobubble(centroids(:,1),centroids(:,2),10,categorical(banner(centroids(:,3))),'BubbleColorList',rgb);
    set(gcf,'NumberTitle','off','Position', get(0, 'Screensize'));
    geobasemap('landcover')
    bpname=['Bubbles ' num2str(radii) ' km ' banner{banner_state} '.png'];
    saveas(gcf,fullfile(mapspath,bpname))
        
    pause(5)
    
    figure('name','Colegios-Ecuador (Histograma)');
    histogram(categorical(centroids(:,3),[1 2 3],banner))
    title([banner{banner_state} ' radii=' num2str(radii)]);
    bpname=['Histogram ' num2str(radii) ' km ' banner{banner_state} '.png'];
    saveas(gcf,fullfile(histspath,bpname))
    pause(5)    
end