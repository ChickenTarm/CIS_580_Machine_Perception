% n = [0:29];
% x = cos(2*pi*n/10);

% ff = abs(fftshift(fft(x)));
% ff64 = abs(fftshift(fft(x, 64)));
% ff128 = abs(fftshift(fft(x, 128)));
% ff256 = abs(fftshift(fft(x, 256)));

% figure(1)
% stem([-14:15], ff);
% 
% figure;
% stem([-31:32], ff64);
% 
% 
% figure;
% stem([-63:64], ff128);
% 
% figure;
% stem([-127:128], ff256);

% xx = repmat(x, 1, 2);
% xxx = repmat(x, 1, 3);
% 
% fftx = abs(fftshift(fft(x, 2048)));
% fftxx = abs(fftshift(fft(xx, 2048)));
% fftxxx = abs(fftshift(fft(xxx, 2048)));
% 
% figure(1)
% stem([-1023:1024], fftx);
% 
% figure;
% stem([-1023:1024], fftxx);
% 
% figure;
% stem([-1023:1024], fftxxx);

% fftx30 = abs(fftshift(fft(x, 30)));
% fftxx60 = abs(fftshift(fft(xx, 60)));
% 
% figure(1)
% stem([-14:15], fftx30);
% 
% figure;
% stem([-29:30], fftxx60);

t = [1:.01:128];
f = cos(2 * pi * t / 8) + cos(2 * pi * t / 20);

% plot(t, f)

fftf = abs(fftshift(fft(f)));

stem([-64:.01:63] / (128/.01), fftf);

