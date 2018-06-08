function [C, R, X0, idx, cam_idx] = DisambiguateCameraPose(Cset, Rset, Xset)

max_front = 0;
C = [];
R = [];
X0 = [];
idx = [];
cam_idx = 1;

for i=1:4
    curr_C = Cset{i};
    curr_R = Rset{i};
    curr_X = Xset{i};
    [num_pts, dim] = size(curr_X);
    r3 = curr_R(3, :);
    num_front = 0;
    front_pts = [];
    idx_h = [];
    for j=1:num_pts
        dist = r3 * (reshape(curr_X(j, :), 3, 1) - curr_C);
        if (dist > 0) & (curr_X(j, 3) > 0) & (dist < 300)
            num_front = num_front + 1;
            front_pts(num_front, :) = curr_X(j, :);
            idx_h(j, 1) = 1;
        else
            idx_h(j, 1) = 0;
        end
    end
    if num_front > max_front
        max_front = num_front;
        C = curr_C;
        R = curr_R;
        X0 = front_pts;
        idx = idx_h;
        cam_idx = i;
    end
end

end