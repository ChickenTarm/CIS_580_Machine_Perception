function M = conv_matrix_1d(k, m)
%CONV_MATRIX_1D - discrete convolution matrix
%
% Syntax:  M = conv_matrix_1d(k, m)
%
% Inputs:
%    k [n, 1] - 1D convolution kernel
%    m [int] - dimension of convolved vector (not necessarily == n)
%
% Outputs:
%    M [m-n+1, m] - convolution matrix. k * x = Mx, where x is [m, 1]
%                   'valid' padding is assumed


[rows, columns] = size(k);
M = zeros(m - rows + 1, m);

for i = 1:(m - rows + 1)
    M(i,i:(i + rows - 1)) = wrev(k);
end

end