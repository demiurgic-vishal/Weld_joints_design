%Weld
V = F;                  % F is theforce applied on cantilever
M = F*l;                % l is the distance of point of application of force in the X direction from the centroid of weld pool
T' = V/A;               % Primary Shear
T'' = M*r/J;            % Secondary Shear
J = 0.707*h*Ju;         % Second Moment of Inertia

% Table 9-1
case 1
    A = 0.707*h*d;          % A : Area of Weld Pool
    Xav = 0;                % Xav : X Coordiante of centroid of Weld Pool            
    Yav = d/2;              % Yav : Y Coordiante of centroid of Weld Pool
    Iu = (d^3)/12;          % Iu  : Unit Second moment of Interia of Weld Pool
    Ra=Yav;                 % Point a b c are in the clockwise direction from the origin ( at the maximum distance from centroid
    Rb=d-Yav;               % Ra, Rb, Rc and Rd are the distances from the centroid to the points a,b,c,d respectively

case 2 
    A=1.414*h*d;
    Xav=b/2;
    Yav=d/2;
    Ju=d*(3*b^2+d^2)/6;
    Ra=Rb=Rc=Rd=(Xav^2+Yav^2)^(1/2);
    
case 3
    A=0.707*h*(b+d);
    Xav=(b^2)/(2*(b+d));
    Yav=(d^2)/(2*(b+d));
    Ju=((b+d)^4-6*b^2*d^2)/(12*(b+d))6;
    Ra=(Xav^2+Yav^2)^(1/2);
    Rb=(Xav^2+(d-Yav)^2)^(1/2);                     %A B C clockwise
    Rc=((b-Xav)^2+Yav^2)^(1/2);
case 4
    A=0.707*h*(d+2*b);
    Xav=(b^2)/(2b+d);
    Yav=d/2;
    Ju=(8*b^3+6*b*d^2+d^3)/12 - b^4/(2*b+d);
    Ra=(Xav^2+Yav^2)^(1/2);
    Rb=(Xav^2+(d-Yav)^2)^(1/2);
    Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
    Rd=((b-Xav)^2+Yav^2)^(1/2);
case 5
    A=1.414*h*(b+d);
    Xav=b/2;
    Yav=d/2;
    Ju=((b+d)^3)/6;
    Ra=(Xav^2+Yav^2)^(1/2);
    Rb=(Xav^2+(d-Yav)^2)^(1/2);
    Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
    Rd=((b-Xav)^2+Yav^2)^(1/2);
case 6
    A=1.414*h*pi*r;
    Ju=2*pi*r^3;
end
    J=0.707*h*Ju;        % Polar Moment of Area