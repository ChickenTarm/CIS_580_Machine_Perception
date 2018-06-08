x = sawtooth([1:128]*10*pi/128);
x1 = x(1 : 128 / 4);
x2 = x(128 / 4 + 1 : 2 * 128 / 4);
x3 = x(2 * 128 / 4 + 1 : 3 * 128 / 4);
x4 = x(3 * 128 / 4 + 1 : 4 * 128 / 4);

dctx1 = dct(x1);
dctx2 = dct(x2);
dctx3 = dct(x3);
dctx4 = dct(x4);

[dctx1s, dctx1Idx] = sort(dctx1);
smallest16x1 = dctx1Idx(1:16);
dctx1(smallest16x1) = 0;

[dctx2s, dctx2Idx] = sort(dctx2);
smallest16x2 = dctx2Idx(1:16);
dctx2(smallest16x2) = 0;

[dctx3s, dctx3Idx] = sort(dctx3);
smallest16x3 = dctx3Idx(1:16);
dctx3(smallest16x3) = 0;

[dctx4s, dctx4Idx] = sort(dctx4);
smallest16x4 = dctx4Idx(1:16);
dctx4(smallest16x4) = 0;

ix1 = idct(dctx1);
ix2 = idct(dctx2);
ix3 = idct(dctx3);
ix4 = idct(dctx4);

ix = [ix1, ix2, ix3, ix4];

size(ix)

plot([1:128], ix)
hold on

fftx1 = fft(x1);
fftx2 = fft(x2);
fftx3 = fft(x3);
fftx4 = fft(x4);

[fftx1s, fftx1Idx] = sort(fftx1);
smallest16x1 = fftx1Idx(1:16);
fftx1(smallest16x1) = 0;

[fftx2s, fftx2Idx] = sort(fftx2);
smallest16x2 = fftx2Idx(1:16);
fftx2(smallest16x2) = 0;

[fftx3s, fftx3Idx] = sort(fftx3);
smallest16x3 = fftx3Idx(1:16);
fftx3(smallest16x3) = 0;

[fftx4s, fftx4Idx] = sort(fftx4);
smallest16x4 = fftx4Idx(1:16);
fftx4(smallest16x4) = 0;

ix1 = real(ifft(fftx1));
ix2 = real(ifft(fftx2));
ix3 = real(ifft(fftx3));
ix4 = real(ifft(fftx4));

ix = [ix1, ix2, ix3, ix4];

plot([1:128], ix);
hold off
