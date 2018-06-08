function [Cset, Rset] = ExtractCameraPose(E)

[U D V] = svd(E);

W = [0 -1 0; 1 0 0; 0 0 1];

R = U * W * V';

RT = U * W' * V';

t = U(:, 3);

t_neg = -1 * U(:, 3);

C1 = -1 * R' * t;
C2 = -1 * R' * t_neg;
C3 = -1 * RT' * t;
C4 = -1 * RT' * t_neg;

% C1 = -1 * t;
% C2 = -1 * t_neg;
% C3 = -1 * t;
% C4 = -1 * t_neg;

% if abs(-1 - det(R)) < .01
if det(R) < 0
    C1 = -1 * C1;
    C2 = -1 * C2;
    R = -1 * R;
end
% if abs(-1 - det(RT)) < .01
if det(RT) < 0
    C3 = -1 * C3;
    C4 = -1 * C4;
    RT = -1 * RT;
end

Cset = cell(1, 4);
Rset = cell(1, 4);

Cset{1} = C1;
Cset{2} = C2;
Cset{3} = C3;
Cset{4} = C4;

Rset{1} = R;
Rset{2} = R;
Rset{3} = RT;
Rset{4} = RT;
end