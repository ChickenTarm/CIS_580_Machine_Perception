function [Mu, Mv, V, RGB] = ParseData(folder)
%% Parse raw data and encode them into proper data structure (e.g. a search table)
%% Author: Haoyuan Zhang

% [Input] folder
% - represents the directory of all stored data.

% [Output] Mu/Mv (N x num_frame):
%  - represents correspondences in all frames in u/v dimension.
%  e.g. Mu[i, :]: stores the ith feature position in all frames, if the jth frame doesn't be observed by 
%  the ith feature, Mu[i, j] = 0, otherwise, Mu[i ,j] stores the u coordinate of ith feature in jth camera frame. Same as Mv.

% [Output] V (N x num_frame): 
%  - represents the visible state of each observed feature in all frames.
%  e.g. V[i, :]: stores the visible state of the ith feature, V[i, j] = 1 means the ith feature can be seen in
%  the jth camera, otherwise, V[i, j] = 0.

% [Output] RGB (N x 3): 
%  - store RGB information for each observed feature.

%%
% the folder stores correspondences matching data
srcFiles = dir([folder '/matching*.txt']);
nfiles = length(srcFiles);

% Mu and Mv store u and v coordinates respectfully
Mu = []; Mv = []; 

% V is the visibility matrix
V = []; RGB = [];
for i = 1 : nfiles
    filename = strcat('data/matching', int2str(i), '.txt');
    
    % store matching data into matrix form
    [mu, mv, v, rgb] = createMatrix(filename, i, 6);
    Mu = [Mu; mu];
    Mv = [Mv; mv];
    V = [V; v];
    RGB = [RGB; rgb];
end

end


%% encode data function
function [Mu, Mv, v, rgb] = createMatrix(filename, image_idx, nImages)

file = fopen(filename);
header = strsplit(fgetl(file));
num_feats = str2num(header{2});

Mu = zeros(num_feats, nImages);
Mv = zeros(num_feats, nImages);
v = zeros(num_feats, nImages);
rgb = zeros(num_feats, 3);

for i=1:num_feats
    l_split = strsplit(fgetl(file));
    num_frames = str2num(l_split{1});
    rgb(i, :) = [str2num(l_split{2}) str2num(l_split{3}) str2num(l_split{4})];
    Mu(i, image_idx) = str2double(l_split{5});
    Mv(i, image_idx) = str2double(l_split{6});
    v(i, image_idx) = 1;
    for j=1:(num_frames-1)
        start_idx = 7 + (j-1) * 3;
        frame = str2num(l_split{start_idx});
        Mu(i, frame) = str2double(l_split{start_idx + 1});
        Mv(i, frame) = str2double(l_split{start_idx + 2});
        v(i, frame) = 1;
    end
end

fclose(file);

% Your Code Goes Here



end



































