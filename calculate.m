function [ V , M, T1, T2a, T2b, T2c, T2d , J ] = calculate( force,l, h, material, A , Xav , Yav ,Ju ,Ra , Rb, Rc, Rd )
V = Force;                  % F is theforce applied on cantilever
M = Force*l;                % l is the distance of point of application of force in the X direction from the centroid of weld pool
T1 = V/A;               % Primary Shear
T2a = M*Ra/J;
T2b = M*Rb/J;
T2c = M*Rc/J;
T2d = M*Rd/J;           % Secondary Shear
J = 0.707*h*Ju;         % Second Moment of Inertia



end

