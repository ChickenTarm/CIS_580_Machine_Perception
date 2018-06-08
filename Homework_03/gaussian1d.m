function g = gaussian1d(sigma, len)
% GAUSSIAN1D - make discrete normalized centered 1D Gaussian
%
% Syntax: g = gaussian1d(sigma, len);
%
% Output is symmetric with unit sampling period.
% Zero is sampled only when len is odd.
% Examples:
%   if len==3, sample points are [-1,0,1]
%   if len==4, sample points are [-1.5, -0.5, 0.5, 1.5]
%
% Inputs:
%   sigma: standard deviation
%   len: output length.
%
% Outputs:
%   g: gaussian filter of dimension (1,len)
%

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%

if mod(len,2) == 0
    X = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
else
    X = [(len - 1) / -2:(len - 1) / 2];
end

g = 1 / (sigma * sqrt(2 * pi)) * exp(-1 * X.^2 / (2 * sigma * sigma));

if sum(g) ~= 1
    ratio = 1 / sum(g);
    g = g * ratio;
end

end
% use gaussian1d.m

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%