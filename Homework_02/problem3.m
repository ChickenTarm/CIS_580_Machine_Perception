[y441, t441] = make_sine(441, 1, 0, 44100, 2);
[y220, t220] = make_sine(220.5, 1, 0, 44100, 2);

[length, other] = size(t441);

f = y441 + y220;

g = 2 / (sqrt(2*pi) * .00085) * exp(-1 * ((t441 - 1).^2 / (2 * .00085^2)));

fftf3 = abs(fftshift(fft(f)));
fftg3 = abs(fftshift(fft(g)));

% stem([-44100:44100] * 44100/length, fftf3 / max(fftf3))
% hold on
% stem([-44100:44100] * 44100/length, fftg3 / max(fftg3))
% hold off