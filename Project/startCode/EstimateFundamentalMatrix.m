function [F] = EstimateFundamentalMatrix(x1, x2)
% EstimateFundamentalMatrix estimates the fundamental matrix that gives
% epipolar lines from the camera in x1 to x2
% Inputs:
%   x1, x2: a Nx2 matrix of corresponding points, N >= 8
% Outputs:
%   F: a 3x3 rank 2 matrix s.t. K'EK = F

[num_pts, dim] = size(x1);

A = zeros(num_pts, 9);

for i = 1:num_pts
    f1 = x1(i, :);
    f2 = x2(i, :);
    A(i, :) = [f1(1)*f2(1) f1(1)*f2(2) f1(1) f1(2)*f2(1) f1(2)*f2(2) f1(2) f2(1) f2(2) 1];
%     A(i, :) = [f1(1)*f2(1) f1(2)*f2(1) f2(1) f1(1)*f2(2) f1(2)*f2(2) f2(2) f1(1) f1(2) 1];
end

[U, D, V] = svd(A);

X = V(:, 9);

F3 = reshape(V(:, 9), 3, 3);

[FU, FD, FV] = svd(F3);

FD(3, 3) = 0;

F = FU * FD * FV';
end