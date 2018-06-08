function main

%% Parse Data
[Mu, Mv, V, RGB] = ParseData('/Users/tommylee/Documents/CIS_580_Machine_Perception/Project/data');

Mu1 = Mu(:, 1);
Mv1 = Mv(:, 1);

Mu2 = Mu(:, 2);
Mv2 = Mv(:, 2);

bothVis = V(:, 1) & V(:, 2);

f1_pts = [Mu1(bothVis, 1) Mv1(bothVis, 1)];
f2_pts = [Mu2(bothVis, 1) Mv2(bothVis, 1)];
feat_rgb = RGB(bothVis, :);

K = [568.996140852 0 643.21055941; 0 568.988362396 477.982801038; 0 0 1];

%% Process Data
[f1_keep, f2_keep, idx] = GetInliersRANSAC(f1_pts, f2_pts);

feat_rgb = feat_rgb(logical(idx), :);

E = EssentialMatrixFromFundamentalMatrix(EstimateFundamentalMatrix(f1_keep, f2_keep), K);

[Cset, Rset] = ExtractCameraPose(E);

Xset = cell(1,4);

Xset{1} = LinearTriangulation(K, [0 0 0]', eye(3), Cset{1}, Rset{1}, f1_keep, f2_keep);
Xset{2} = LinearTriangulation(K, [0 0 0]', eye(3), Cset{2}, Rset{2}, f1_keep, f2_keep);
Xset{3} = LinearTriangulation(K, [0 0 0]', eye(3), Cset{3}, Rset{3}, f1_keep, f2_keep);
Xset{4} = LinearTriangulation(K, [0 0 0]', eye(3), Cset{4}, Rset{4}, f1_keep, f2_keep);

[C, R, X0, c_idx, cam] = DisambiguateCameraPose(Cset, Rset, Xset);

feat_rgb = feat_rgb(logical(c_idx), :);

image1 = imread('/Users/tommylee/Documents/CIS_580_Machine_Perception/Project/data/image0000001.bmp');
image2 = imread('/Users/tommylee/Documents/CIS_580_Machine_Perception/Project/data/image0000002.bmp');

Cset = cell(1,2);
Rset = cell(1,2);

Cset{1} = [0 0 0]';
Cset{2} = C;
Rset{1} = eye(3);
Rset{2} = R;

figure(1)
plot_reprojection(image1, eye(3), [0 0 0]', K, X0, f1_keep(logical(c_idx), :));

figure;
plot_reprojection(image2, R, C, K, X0, f2_keep(logical(c_idx), :));

PlotCamerasAndPoints(Cset, Rset, X0, 1);

figure;
PC3Dshow(X0, Cset, Rset, feat_rgb);

end