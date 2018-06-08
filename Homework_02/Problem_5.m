Img = imread('statue.jpg');

gray = rgb2gray(Img);

x = [-2:2];
y = [-2:2];

g1 = zeros(5, 5);
g2 = zeros(5, 5);


for i = [1:5]
    g1(:, i) = 1 / (2 * pi * 1) * exp(-1* (x.^2 + y(i)^2) / (2 * 1));
    g2(:, i) = 1 / (2 * pi * (0.01)) * exp(-1* (x.^2 + y(i)^2) / (2 * 0.01));
end

g1
g2


% figure(1)
% imshow(uint8(conv2(gray, g1, 'same')));
% 
% figure;
% imshow(uint8(conv2(gray, g2, 'same')));

g1fft = abs(fftshift(fft(g1(3,:))));
g2fft = abs(fftshift(fft(g2(3,:))));

figure(1)
stem([1:5], g1fft);

figure;
stem([1:5], g2fft);