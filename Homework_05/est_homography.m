function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE

A = zeros(8, 9);

for i = 1:4
    y_row = 2 * i;
    x_row = y_row - 1;
    orig_pt = video_pts(i, :);
    trans_pt = logo_pts(i, :);
    A(x_row, :) = [-1*orig_pt(1) -1*orig_pt(2) -1 0 0 0 orig_pt(1)*trans_pt(1) orig_pt(2)*trans_pt(1) trans_pt(1)];
    A(y_row, :) = [0 0 0 -1*orig_pt(1) -1*orig_pt(2) -1 orig_pt(1)*trans_pt(2) orig_pt(2)*trans_pt(2) trans_pt(2)];
end

[U, S, V] = svd(A);

V

H = [V(1, 9) V(2, 9) V(3, 9); V(4, 9) V(5, 9) V(6, 9); V(7, 9) V(8, 9) V(9, 9)];

end

