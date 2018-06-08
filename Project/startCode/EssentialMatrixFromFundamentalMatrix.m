function [E] = EssentialMatrixFromFundamentalMatrix(F, K)
% GetInliersRANSAC finds the essenital matrix by multiplying F by the 
% camera matrix
% Inputs:
%   F, K: 3x3 matrix fundamental and camera intrinsic matrix
% Outputs:
%   E: 3x3 essential matric with singular values (1,1,0)

E1 = K' * F * K;

[U, D, V] = svd(E1);

% E = U * D * V';
E = U * [1 0 0; 0 1 0; 0 0 0] * V';

end