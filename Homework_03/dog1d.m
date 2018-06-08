function dog = dog1d(sigma, k, len)
% DOG1D - return difference of gaussians of std k*sigma and sigma
%
% Syntax: g = dog1d(sigma, k, len)
%
% Output is symmetric with unit sampling period.
% Zero is sampled only when len is odd.
%
% Inputs:
%   sigma: standard deviation
%   k: standard deviation ratio
%   len: output length.
%
% Outputs:
%   dog: difference of gaussians with dimension (1,len)
%

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
% use gaussian1d.m

dog = gaussian1d(sigma * k, len) - gaussian1d(sigma, len);

% dog = 1 / ((k - 1) * sigma^2) * dog;

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%