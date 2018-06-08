[y441, t441] = make_sine(441, 1, 0, 44100, 2);
[y220, t220] = make_sine(220.5, 1, 0, 44100, 2);

f = y441 + y220;

% plot(t441, y441)
% hold on
% plot(t220, y220)
% hold on
% plot(t441, f)
% hold on

g = 2 / (sqrt(2*pi) * .00085) * exp(-1 * ((t441 - 1).^2 / (2 * .00085^2)));
gmax = max(g);

step = 1 / 44100;

% plot(t441, g, '*')
% hold on
fg = conv(f, g, 'same') * step;

% plot(t441, fg)
% legend('y1(441)', 'y2(220.5)', 'f', 'f*g')
% hold off
sound(y220, 44100);