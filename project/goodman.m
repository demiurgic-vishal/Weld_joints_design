
% Sut is ultimate tensile strength of material
% Se' is the endurance limit of the rotating beam specimen
% N is the number of cycle
% Se is the endurance limit at the critical locations
% Ka is the surface modification factor
% Kb is the size modification factor
% Kc is load modification facot
% Kd is tempreature modification factor
% Ke is the reliability factor
% Kf is the miscellenous factor

if (Sut < (1400*10^6)){
    Se' = 0.5*Sut;
    }
if (Sut > (1400*10^6)){
    Se' = 700*10^6;
    }
    
if ( material =='HR'){
    a = 57.7;
    b= = -0.718;
    }
if ( material =='CD'){
    a = 4.51;
    b= = -0.265;
    }
 Ka = a*(Sut^b);
 