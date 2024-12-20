function [h,theta] = RotToAngleAxis(R)
%EULER REPRESENTATION: Given a tensor rotation matrices this function
% should output the equivalent angle-axis representation values,
% respectively 'theta' (angle), 'h' (axis) 
% SUGGESTED FUNCTIONS
    % size()
    % eye()
    % abs()
    % det()
    % NB: Enter a square, 3x3 proper-orthogonal matrix to calculate its angle
    % and axis of rotation. Error messages must be displayed if the matrix
    % does not satisfy the rotation matrix criteria.

    I = eye(3,3);
    % Check matrix R to see if its size is 3x3
    if any([3 3] ~= size(R))
        error("R is not a 3x3 matrix.")
    end
    if ((det(R) - 1 > 1e-10) || any(abs(R * R' - I) > 1e-10,"all"))
        error("R can't be a rotation matrix.")
    end

    theta = acos((sum(R .* I, "all") - 1) / 2);

    if (theta == 0)
        error("The angle of rotation is zero, h can be arbitrary.")
    elseif abs(theta - pi) < 1e-10
        h_pos = sqrt((diag(R) + 1) / 2);

        % max() make found the not null component
        [~, idx] = max(abs(h_pos));
        
        % Set the sgn of ather components with repect R's compoents
        if idx == 1
            if R(1, 2) < 0
                h_pos(2) = -abs(h_pos(2));
            end
            if R(1, 3) < 0
                h_pos(3) = -abs(h_pos(3));
            end
        elseif idx == 2
            if R(1, 2) < 0
                h_pos(1) = -abs(h_pos(1));
            end
            if R(2, 3) < 0
                h_pos(3) = -abs(h_pos(3));
            end
        else
            if R(1, 3) < 0
                h_pos(1) = -abs(h_pos(1));
            end
            if R(2, 3) < 0
                h_pos(2) = -abs(h_pos(2));
            end
        end

        h_pos = h_pos / norm(h_pos);
        h_neg = -h_pos; % make the second solution equal and opposite
        disp(h_pos)
        h = [h_pos, h_neg];
    else
        a = vex((R - R') / 2);
        % Axial vector a, a = sin(theta) * h => h = a / sin(theta)
        h = a / sin(theta);
    end
end

 
function a = vex(S_a)
% input: skew matrix S_a (3x3)
% output: the original a vector (3x1)
% a = sin(theta) * h = (R - R') / 2
a = [S_a(3, 2); S_a(1, 3); S_a(2, 1)];
end
