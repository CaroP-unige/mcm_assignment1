function [psi,theta,phi] = RotToYPR(R)
% Given a rotation matrix the function outputs the relative euler angles
% usign the convention YPR
% Input:
% R rotation matrix
% Output:
% psi angle around z axis (yaw)
% theta angle around y axis (theta)
% phi angle around x axis (phi)
% SUGGESTED FUNCTIONS
    % atan2()
    % sqrt()

    I = eye(3,3);
    % Check matrix R to see if its size is 3x3
    if any([3 3] ~= size(R))
        error("R is not a 3x3 matrix.")
    end

    if ((det(R) - 1 > 1e-10) || any(abs(R * R' - I) > 1e-10,"all"))
        error("R can't be a rotation matrix.")
    end
    
    theta = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));

    % Check the singolarity of the configurationss
    if cos(theta) ~= 0
        phi = atan2(R(3,2), R(3,3));
        psi =  atan2(R(2,1), R(1,1));
    else
        error("The singolarity is not verify.")
    end
    
end

