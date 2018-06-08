function g = gaussian2d(Sigma, len)
% GAUSSIAN2D - make discrete normalized centered 2D Gaussian
%
% Syntax: g = gaussian2d(Sigma, len);
%
% Output is symmetric with unit sampling period.
% (0,0) is sampled only when len is odd.
%
% Inputs:
%   Sigma: 2x2 covariance matrix
%   len: output is len x len.
%

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%

sig_x = sqrt(Sigma(1, 1));
sig_y = sqrt(Sigma(2, 2));

if mod(len,2) == 0
    X = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
    Y = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
else
    X = [(len - 1) / -2:(len - 1) / 2];
    Y = [(len - 1) / -2:(len - 1) / 2];
end

g = zeros(len, len);

rho = Sigma(1, 2) / (sig_x * sig_y);

for i = 1:len
    for j = 1:len
        z = X(i)^2 / (sig_x^2) - (2 * rho * X(i) * Y(j)) / (sig_x * sig_y) + Y(j)^2 / (sig_y^2);
        g(j, i) = 1 / (2 * pi * sig_x * sig_y * sqrt(1 - rho^2)) * exp(-1 * z / (2 * (1 - rho^2)));
    end
end


if sum(g(:)) ~= 1
    ratio = 1 / sum(g(:));
    g = g * ratio;
end

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%