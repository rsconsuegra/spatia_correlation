clc;clearvars;close all;

load("datos_colegios.mat")
load("datos_todos.mat")

radii=0.2;
root='Data';

filepath=fullfile(root,[num2str(radii*1000) 'm.csv']);

cHeader = {'Lon' 'Lat' 'PancartaProm' 'Desempenio'}; %dummy header
textHeader = strjoin(cHeader, ','); %cHeader in text with commas
fid = fopen(filepath,'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);


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
        if (index<banner_state)
            centroids(School,4)=1;
        elseif (index>banner_state)
            centroids(School,4)=3;
        else
            centroids(School,4)=2;
        end
    end
    
    dlmwrite(filepath,centroids,'-append');    
end