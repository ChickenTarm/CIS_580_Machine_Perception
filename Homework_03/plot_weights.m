model = load('imagenet-caffe-alex.mat');
weights = model.layers{1}.weights{1};

for i = 1:96
    div = max(max(max(abs(weights(:,:,:, i)))));
    weights(:,:,:, i) = weights(:,:,:, i) / div;
end

figure(1)

for i = 1:96
    subplot(8, 12, i)
    imagesc(weights(:,:,:, i))
end

figure(2)

T_f = 5;
theta = 145;
2 * 1.5 ^2*eye(2)
[g1,g2] = gaborFilter2D(T_f, theta, 2 * 1.5 ^2*eye(2), 11);

subplot(1, 2, 1)
imagesc(g1)

subplot(1, 2, 2)
imagesc(g2)

figure(3)

T_f = 5;
theta = 85;
2 * 1.3 ^2*eye(2)
[g1,g2] = gaborFilter2D(T_f, theta, 2 * 1.3 ^2*eye(2), 11);

subplot(1, 2, 1)
imagesc(g1)

subplot(1, 2, 2)
imagesc(g2)
