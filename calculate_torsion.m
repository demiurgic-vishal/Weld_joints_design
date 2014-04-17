function [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n]=calculate_torsion(electrode,l,force2,h,material,A,Xav,Yav,Ju,Ra,Rb,Rc,Rd,Oa,Ob,Oc,Od)
V = force2;                  % F is theforce applied on cantilever
M = force2*l;                % l is the distance of point of application of force in the X direction from the centroid of weld pool
T1 = V/A;               % Primary Shear
J = 0.707*h*Ju;         % Second Moment of Inertia
T2a = M*Ra/J;
T2b = M*Rb/J;
T2c = M*Rc/J;
T2d = M*Rd/J;           % Secondary Shear

Tra = ((T1)^2 + (T2a)^2 + 2*T1*T2a*cosd(Oa))^(1/2);
Trb = ((T1)^2 + (T2b)^2 + 2*T1*T2b*cosd(Ob))^(1/2);
Trc = ((T1)^2 + (T2c)^2 + 2*T1*T2c*cosd(Oc))^(1/2);
Trd = ((T1)^2 + (T2d)^2 + 2*T1*T2d*cosd(Od))^(1/2);
maxTr = max([Tra Trb Trc Trd]);
electrode1 = electrode';
indicesDesMax = find( electrode1(2,:) == material );
Min = min([0.4*electrode1(4,indicesDesMax) 0.3*electrode1(3,indicesDesMax)]);
n=Min/maxTr
end

