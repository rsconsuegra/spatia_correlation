
import numpy as np
import math as mn 

#%%
def Distance_Calculations( Lat_Station,Long_Station,     Lat_Hypo,Long_Hypo ):
    R_Tierra=6371; 
    Lat_Station=mn.radians(Lat_Station);    #En Radianes
    Long_Station=mn.radians(Long_Station);  #En Radianes
   
    Lat_Hypo=mn.radians(Lat_Hypo);   #En Radianes
    Long_Hypo=mn.radians(Long_Hypo);  #En Radianes
    
    Delta_Lat=Lat_Station-Lat_Hypo; 
    Delta_Long=Long_Station-Long_Hypo; 
    e=(mn.sin(Delta_Lat/2))**2
    d=mn.cos(Lat_Station)*mn.cos(Lat_Hypo)*(mn.sin(Delta_Long/2))**2
    a=e+d
    c=2*mn.atan2(mn.sqrt(a),mn.sqrt(1-a)) ; 
    R_epi=R_Tierra*c;
    return R_epi

