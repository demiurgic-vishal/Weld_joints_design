%Bolt
%washer thickness t washer.dat A-33 /?????????????????????????????????????????
%Nut Thickness H nut.dat A-31 ????????????????????????????????????
%Grip Length for Fig (A) l is given

%Fig (A) Fasterner Length L
num=l+H;
load Fastner.dat ;
for (i=1:26)
    if ((num-Fastner(i))<0)
        L= Fastner(i);
    break
    end
end
%Threaded length Lt
 if( L<=125&& d<=48)
     Lt= 2*d+6;
 elseif(L>125&&L<=200)
     Lt=2*d +12;
 else
     Lt=2*d+25;
 end
 ld= L-Lt; %Length of unthreaded portion in grip
 lt= l- ld; % Length of threaded portion in grip
 Ad= pi*d*d/4; % Area of unthreaded portion
 %Area of Threaded portion At Table 8-1 and 8-2?????????????
 Kb=(Ad*At*E)/(Ad*lt+At*ld);
 % Given L1 and L2 length of workpiece E1 and E2 also given and d also given
 alpha=(t+L1+L2)/2;
 D=1.5*d;
 if ((alpha-t)==L1)
     Km1=(0.5774*pi*E1*d)/(log((1.155*(alpha)+D-d)*(D+d)/((1.155*(alpha)+D+d)*(D-d))));
     Km2=(0.5774*pi*E2*d)/(log((1.155*(alpha)+(((D/2)/tand(30)+alpha)*2*tand(30)-d)*(((D/2)/tand(30)+alpha)*2*tand(30)+d)/((1.155*(alpha)+((D/2)/tand(30)+alpha)*2*tand(30)+d)*(((D/2)/tand(30)+alpha)*2*tand(30)-d)))));
     Km=(Km1*Km2)/(Km1+Km2);
 elseif((alpha-t)>L1)
     Km1=(0.5774*pi*E1*d)/(log((1.155*(L1+t)+D-d)*(D+d)/((1.155*(t+L1)+D+d)*(D-d))));
     Km2=(0.5774*pi*E2*d)/(log((1.155*(alpha-L1)+(((D/2)/tand(30)+t+L1)*2*tand(30)-d)*((((D/2)/tand(30)+t+L1)*2*tand(30)+d)/((1.155*(alpha-L1)+((D/2)/tand(30)+t+L1)*2*tand(30)+d)*(((D/2)/tand(30)+t+L1)*2*tand(30)-d))))));
     Km3=(0.5774*pi*E2*d)/(log((1.155*(alpha)+(((D/2)/tand(30)+alpha)*2*tand(30)-d)*(((D/2)/tand(30)+alpha)*2*tand(30)+d)/((1.155*(alpha)+((D/2)/tand(30)+alpha)*2*tand(30)+d)*(((D/2)/tand(30)+alpha)*2*tand(30)-d)))));
     
 else
     Km1=(0.5774*pi*E1*d)/(log((1.155*(alpha)+D-d)*(D+d)/((1.155*(alpha)+D+d)*(D-d))));
     Km2=(0.5774*pi*E1*d)/(log((1.155*(L1-alpha)+((D/2)/tand(30)+alpha)*2*tand(30)-d)*(((D/2)/tand(30)+alpha)*2*tand(30)+d)/((1.155*(L1-alpha)+((D/2)/tand(30)+alpha)*2*tand(30)+d)*(((D/2)/tand(30)+alpha)*2*tand(30)-d))));
     Km3=(0.5774*pi*E2*d)/(log((1.155*(L2)+((D/2)/tand(30)+L1)*2*tand(30)-d)*(((D/2)/tand(30)+L1)*2*tand(30)+d)/((1.155*(L2)+((D/2)/tand(30)+L1)*2*tand(30)+d)*(((D/2)/tand(30)+L1)*2*tand(30)-d))));
     Km=(Km1*Km2*Km3)/(Km1*Km2+Km2*Km3+Km3*Km1);
 end
 
% Fi is preload
% Pt total external tensile load applied to the joints
% N is the number of bolts in the joint
% C is the fraction of external load P carries by bolt
% (1-C) is the fraction of external load P carries by members
% Pb is the portion of P taken by bolt
% Pm is the portion of P taken by members
% Fb is resultant bolt load (Pb+Fi)
% Fm is resultant members load (Pb-Fi)
% Sigmab is the tensile stress in the bolt
% Np is the yielding factor of safety against the static stress excedding
% the proof strength
% Nl is the load factor of safety
% Po is value of external load that causes joint separation
% Let Conn be the value for determining connections
% Conn is 1 for permanent connections, 2 otherwise
% p is the Gasket pressure  


P = Pt/N;
C = Kb/(Kb+Km);
Pb = C*P;
Pm = (1-C)*P;
Fb = Pb + Fi;
Fm = Pm - Fi;
Sigmab = (C*P+Fi)/At;
Np = Sp*At/(C*P+Fi);
Nl = (Sp*At-Fi)/(C*P);

if (Fm == 0)
    Fi = (1-C)*Po;
    No = Fi/(P*(1-C));
end

if (Conn == 1)
     Fi = 0.90*Fp;
end
if (Conn == 2)
     Fi = 0.75*Fp;
end

p = -((Fi-(n*P*(1-C)))*N)/Ag;

BS = (pi*Db)/Nd;

if ((BS>=3)&&(BS<=6))
    Wrench Clearance is maintained
end

% Fatigue
% Pmax is the maximum fluctuating external load per bolt 
% Pmin is the minimum fluctuating external load per bolt 
% Fmax is the maximum fluctuating forces
% Fmin is the minimum fluctuating forces
% Sigmaa is the alternating stress
% Sigmam is the mid range stress component
% Nf is the fatigue factor of safety
% Np is the factor of safety for yielding
% Nfo is fatigue factor of safety for no preload 

Fbmax = C*Pmax + Fi;
Fbmin = C*Pmin - Fi;
Sigmaa = (C*(Pmax - Pmin))/(2*At);
Sigmam = ((C*(Pmax + Pmin))/(2*At)) + (Fi/At);

Nf = (Se*(Sut-Sigmai))/((Sut*Sigmaa)+(Se*(Sigmam-Sigmai)));
Np = Sp/(Sigmam+Sigmaa);

if (Fi == 0)
    Nfo = (Se*Sut)/((Sut*Sigmaa)+(Se*Sigmam));
end

if (Fi<=((1-C)*Sut*At))
    Satisfactory
end






     