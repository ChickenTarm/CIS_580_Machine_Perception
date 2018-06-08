function [filter_cos,filter_sin] = gaborFilter1D(T_f, sigma, len)
% This function returns two 1D Gabor quadrature filters
% (vectors).
%
% Unit sampling period; zero is sampled only when filter_length is odd.

% ARGUMENTS
% - T_f: spatial period in pixels
% - sigma: Gaussian envelope sigma
% - len: length of the output

%
% OUTPUT
% filter_cos, filter_sin: (1,len) vectors containing the real part
% and the imaginary part of the filter

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%

g = gaussian1d(sigma, len);

if mod(len,2) == 0
    X = cat(2, [len / -2:-1] + .5, [1:len / 2] - .5);
else
    X = [(len - 1) / -2:(len - 1) / 2];
end

rl = cos(2 * pi / T_f * X);

im = sin(2 * pi / T_f * X);

filter_cos = g .* rl;

filter_sin = g .* im;

% use gaussian1d for the Gaussian envelope

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%

