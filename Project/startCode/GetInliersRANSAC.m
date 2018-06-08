function [y1, y2, idx] = GetInliersRANSAC(x1, x2)
% GetInliersRANSAC finds the best selection of points whose fundamental
% matrix provides the most consistent mapping.
% Inputs:
%   x1, x2: a Nx2 matrix of corresponding points, N >= 8
% Outputs:
%   y1 y2: a Nix2 matrix of corresponding points where the fundamental
%   matrix calcuated from the first 8 corresponding points produces
%   inliers
%   idx: logical Nx1 matrix where a 1 at i means that x1(i) and x2(i) are
%   inliers

[num_pts, dim] = size(x1);

max_inliers = 0;
y1 = [];
y2 = [];
idx= [];

for i = 1:5000
    x1_h = datasample(x1, 64, 1);
    x2_h = datasample(x2, 64, 1);
    F_h = EstimateFundamentalMatrix(x1_h, x2_h);
    num_inliers = 0;
    y1_h = [];
    y2_h = [];
    idx_h = [];
    for j = 1:num_pts
        dist = [x2(j, :) 1] * F_h * [x1(j, :) 1]';
        if abs(dist) < .1
            num_inliers = num_inliers + 1;
            y1_h(num_inliers, :) = x1(j, :);
            y2_h(num_inliers, :) = x2(j, :);
            idx_h(j, 1) = 1;
        else
            idx_h(j, 1) = 0;
        end
    end
    if num_inliers > max_inliers
        y1 = y1_h;
        y2 = y2_h;
        idx = idx_h;
        max_inliers = num_inliers;
    end
end

end