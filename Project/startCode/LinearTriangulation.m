function [X] = LinearTriangulation(K, C1, R1, C2, R2, x1, x2)

P1 = K * R1 * [eye(3) -1*C1];
P2 = K * R2 * [eye(3) -1*C2];

% P1 = K * [R1 -1*R1*C1];
% P2 = K * [R2 -1*R2*C2];

[num_pts, dim] = size(x1);

X = zeros(num_pts, 3);

for i=1:num_pts
    pt1 = [x1(i, :) 1];
    pt2 = [x2(i, :) 1];
    skew1 = [0 -1*pt1(3) pt1(2); pt1(3) 0 -1*pt1(1); -pt1(2) pt1(1) 0];
    skew2 = [0 -1*pt2(3) pt2(2); pt2(3) 0 -1*pt2(1); -pt2(2) pt2(1) 0];
    [U, D, V] = svd([skew1 * P1; skew2 * P2]);
    X_h = V(:,4) / V(4, 4);
    X(i, :) = reshape(X_h(1:3,1), 1, 3);
end

end