function [R_epi] = Distance_Calculations(Lat_Station,Long_Station,Lat_Hypo,Long_Hypo)
%Distance_Calculations Calcualtes the distance of two points over the earth
%   Calculates the distance of two points, specifically with the same
%   alture over the sea, on a sphere, Earth in particular

    R_Tierra=6378.137; 
    Lat_Station=deg2rad(Lat_Station);    %En Radianes
    Long_Station=deg2rad(Long_Station);  %En Radianes
   
    Lat_Hypo=deg2rad(Lat_Hypo);   %En Radianes
    Long_Hypo=deg2rad(Long_Hypo);  %En Radianes
    
    Delta_Lat=Lat_Station-Lat_Hypo; 
    Delta_Long=Long_Station-Long_Hypo; 
    e=(sin(Delta_Lat./2)).^2;
    d=cos(Lat_Station).*cos(Lat_Hypo).*(sin(Delta_Long./2)).^2;
    a=e+d;
    c=2*atan2(sqrt(a),sqrt(1-a)); 
    R_epi=R_Tierra*c;
end

