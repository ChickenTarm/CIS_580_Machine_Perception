Img = imread('statue.jpg');

gray = rgb2gray(Img);

central = gray(250-100:250+100,187-100:187+100);

fftImg = fftshift(fft2(central));

m1 = 40000 / 8;
m2 = 40000 / 64;

m1len = round(sqrt(m1) / 2);
m2len = round(sqrt(m2) / 2);

M1Sel = zeros(201, 201);
M2Sel = zeros(201, 201);

M1Sel(100 - m1len : 100 + m1len, 100 - m1len : 100 + m1len) = 1;
M2Sel(100 - m2len : 100 + m2len, 100 - m2len : 100 + m2len) = 1;

ImgM1 = uint8(real(ifft2(ifftshift(M1Sel .* fftImg))));
ImgM2 = uint8(real(ifft2(ifftshift(M2Sel .* fftImg))));

% figure(1)
% imshow(central);
% 
% figure;
% imshow(ImgM1);
% 
% figure;
% imshow(ImgM2);


% 
% sqrtM = [10:200];
% M = sqrtM .* sqrtM;
% SNR = zeros(191);
% 
% central = double(central);
% 
% for i = 1:191
%     width = round(sqrtM(i) / 2);
%     window = zeros(201, 201);
%     window(101 - width : 101 + width, 101 - width : 101 + width) = fftImg(101 - width : 101 + width, 101 - width : 101 + width);
%     approx = round(abs(real(ifft2(ifftshift(window)))));
%     SNR(i) = -20 * log(norm(central - approx, 'fro') / norm(central, 'fro'));
% end
% 
% plot(M, SNR)

fftco = fft2(central);

reals = real(fftco);

realVec = reals(:);

T1 = prctile(realVec(:), 1 - m1 / 40000)

T2 = prctile(realVec(:), 1 - m2 / 40000)

T1fft = zeros(201, 201);
T2fft = zeros(201, 201);

for i = [1:200]
    for j = [1:200]
        if reals(j, i) >= T1
            T1fft(j, i) = fftco(j, i);
        end
        if reals(j, i) >= T2
            T2fft(j, i) = fftco(j, i);
        end
    end
end

% figure(1)
% imshow(T1fft);
% 
% figure;
% imshow(T2fft);

ImgT1 = uint8(real(ifft2(T1fft)));
ImgT2 = uint8(real(ifft2(T2fft)));

figure(1)
imshow(ImgM1);

figure;
imshow(ImgM2);

figure;
imshow(ImgT1);

figure;
imshow(ImgT2);