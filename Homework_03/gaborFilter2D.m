function [filter_cos,filter_sin] = gaborFilter2D(T_f, theta, Sigma, len)
% This function returns two 2D Gabor quadrature filters
% (square matrices).
%
% ARGUMENTS
% - T_f: spatial period in pixels
% - theta: carrier orientation in degrees (0 corresponds
% to oscillation along x-axis only)
% - Sigma: covariance of Gaussian envelope
% - len: output is len x len.
%
% OUTPUT
% filter_cos, filter_sin: two 2d matrices containing the real part
% and the imaginary part of the filter

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
% use gaussian2d.m

rad = deg2rad(theta);

sig_x = Sigma(1, 1);
sig_y = Sigma(2, 2);

if mod(len,2) == 0
    X = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
    Y = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
else
    X = [(len - 1) / -2:(len - 1) / 2];
    Y = [(len - 1) / -2:(len - 1) / 2];
end

filter_cos = zeros(len, len);
filter_sin = zeros(len, len);

rho = Sigma(1, 2) / (sig_x * sig_y);

for i = 1:len
    for j = 1:len
        x_p = X(i) * cos(rad) - Y(j) * sin(rad);
        y_p = -1 * X(i) * sin(rad) - Y(j) * cos(rad);
        z = x_p^2 / (sig_x^2) - (2 * rho * x_p * y_p) / (sig_x * sig_y) + y_p^2 / (sig_y^2);
        filter_cos(j, i) = 1 / (2 * pi * sig_x * sig_y * sqrt(1 - rho^2)) * exp(-1 * z / (2 * (1 - rho^2))) * cos(2 * pi / T_f * x_p);
        filter_sin(j, i) = 1 / (2 * pi * sig_x * sig_y * sqrt(1 - rho^2)) * exp(-1 * z / (2 * (1 - rho^2))) * sin(2 * pi / T_f * x_p);
    end
end

if sum(sqrt(filter_cos(:).^2 + filter_sin(:).^2)) ~= 1
    ratio = 1 / sum(sqrt(filter_cos(:).^2 + filter_sin(:).^2));
    filter_cos = filter_cos * ratio;
    filter_sin = filter_sin * ratio;
end

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%

