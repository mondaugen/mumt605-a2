clear;
sr = 8000;
tr = 1/sr;
l  = 1; % length in seconds
t = [0:tr:1];
tl = 1;
t = [0:tr:tl];
N = 512;
H = N / 4;
fw = sr/N;
f = fw * 100;
x = sin(2 * pi * f * t) + sin(2 * pi * f * t * 0.75);
% window function
w = hanning(N);
Xk  = fft(circshift( ...
        fliplr( ...
            toeplitz(x, ...
                fliplr(horzcat(x(2:end),[0]))
            ) ...
        ),[1 0] ...
     )(:,1:N)(1:H:(end - N + 1),:),N,2);
surf(abs(Xk));

