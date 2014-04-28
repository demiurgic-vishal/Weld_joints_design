function [Mingood, Mingerber, Minyield] = calculate_bending_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

indicesDesMax = find( steel(:,3) == handles.numb );
if steel(indicesDesMax(1),4)== handles.hr
    indice = indicesDesMax(1);
elseif numel(indicesDesMax) == 2
    indice = indicesDesMax(2);
else
    indice = indicesDesMax(1);
end

Sut = steel(indice,5);
Sy = steel(indice,6)*1e6;

Se = 0.5*Sut*1e6;   % in MPa

if ( handles.hr == 1)
    a = 57.7;
    b = -0.718;
else
    a = 4.51;
    b = -0.265;
end

Ka = a*((Sut)^b);
de = 0.808*(Area)^(1/2);
Kb =1;

 if ((de<=0.051) || (de>=0.00279))
      
      Kb = 1.24*((de*1000)^(-0.107));
      
 elseif ((de>=0.051) || (de<=0.254))
      
      Kb = 1.51*((de*1000)^(-0.157));
      
 end
 
 if handles.loading == 1
      Kc = 1;
 else
        Kc = 0.59;
 end
 
 Kd =1;
 
 if (handles.reliability == 50)
     Ke=1;
 elseif (handles.reliability == 90) 
     Ke=0.897;
 elseif (handles.reliability == 95)
     Ke=0.868;
 elseif (handles.reliability == 99)
     Ke=0.814; 
 elseif (handles.reliability == 99.9)
     Ke=0.753;
 elseif (handles.reliability == 99.99)
     Ke=0.702; 
 elseif (handles.reliability == 99.999)
     Ke=0.659; 
 else (handles.reliability == 99.9999)
     Ke=0.620;
 end
 
 Kf =1;
 Kfs = handles.kfs;
 Se = Ka*Kb*Kc*Kd*Ke*Kf*Se'; 
  Ssu=0.67*Sut*1e6;
  Ta = Kfs*(aforce)/(Area);             % Use table 9.5
  Tm = Kfs*(mforce)/(Area);
  
  
  
 
                 % F is theforce applied on cantilever
Ma = aforce*l;
Mm = mforce*l;% l is the distance of point of application of force in the X direction from the centroid of weld pool
              % Primary Shear
J = 0.707*h*Ju;         % Second Moment of Inertia
T2ma = Kfs*Mm*Ra/J;
T2mb = Kfs*Mm*Rb/J;
T2mc = Kfs*Mm*Rc/J;
T2md = Kfs*Mm*Rd/J; 
T2aa = Kfs*Ma*Ra/J;
T2ab = Kfs*Ma*Rb/J;
T2ac = Kfs*Ma*Rc/J;
T2ad = Kfs*Ma*Rd/J; % Secondary Shear

Trma = ((Tm)^2 + (T2ma)^2)^(1/2);
Trmb = ((Tm)^2 + (T2mb)^2)^(1/2);
Trmc = ((Tm)^2 + (T2mc)^2)^(1/2);
Trmd = ((Tm)^2 + (T2md)^2)^(1/2);

Traa = ((Ta)^2 + (T2aa)^2)^(1/2);
Trab = ((Ta)^2 + (T2ab)^2)^(1/2);
Trac = ((Ta)^2 + (T2ac)^2)^(1/2);
Trad = ((Ta)^2 + (T2ad)^2)^(1/2);
Sut = steel(indice,5)*1e6;

ngerbera = (0.5)*((Sut/Trma)^2)*(Traa/Se)*(-1 + (1+(2*Trma*Se/(Sut*Traa))^2)^0.5);
ngerberb = (0.5)*((Sut/Trmb)^2)*(Trab/Se)*(-1 + (1+(2*Trmb*Se/(Sut*Trab))^2)^0.5);
ngerberc = (0.5)*((Sut/Trmc)^2)*(Trac/Se)*(-1 + (1+(2*Trmc*Se/(Sut*Trac))^2)^0.5);
ngerberd = (0.5)*((Sut/Trmd)^2)*(Trad/Se)*(-1 + (1+(2*Trmd*Se/(Sut*Trad))^2)^0.5);

nfa = 1/((Traa/Se)+(Trma/Ssu));
nfb = 1/((Trab/Se)+(Trmb/Ssu));
nfc = 1/((Trac/Se)+(Trmc/Ssu));
nfd = 1/((Trad/Se)+(Trmd/Ssu));

nya = Sy/(Traa+Trma)
nyb = Sy/(Trab+Trmb)
nyc = Sy/(Trac+Trmc)
nyd = Sy/(Trad+Trmd)
Mingood = min([nfa nfb nfc nfd]);
Minyield = min([nya nyb nyc nyd]);
Mingerber = min([ngerbera ngerberb ngerberc ngerberd]);



end

