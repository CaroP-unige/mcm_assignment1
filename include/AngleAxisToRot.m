function R = AngleAxisToRot(h,theta)
% The fuction implement the Rodrigues Formula
% Input: 
% h is the axis of rotation
% theta is the angle of rotation (rad)
% Output:
% R rotation matrix

if abs(norm(h) - 1) > 1e-10
    error("The axis h must be a unit vector.")
end

identity = eye(3,3);

if theta == 0
    R = identity;
elseif theta == pi
    R = 2 * (h * h') - identity;
else
    h_skewsym = [0 -h(3) h(2); h(3) 0 -h(1); -h(2) h(1) 0];
    R = identity + sin(theta) * h_skewsym + (1 - cos(theta)) * (h_skewsym^2);
end

end
