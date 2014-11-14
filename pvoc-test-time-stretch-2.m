clear;
sr = 8000;
tr = 1/sr;
l  = 1; % length in seconds
t = [0:tr:1];
tl = 2;
t = [0:tr:tl];
N = 2048;
O = 4; % overlap
H = N / O;
fw = sr/N;
f = fw * 100;
x = wavread ("syro-010-short.wav",length(t))';
% window function
w = horzcat(hanning(N - 1)',[0]);
Xk = [];
%for n = [1:H:(length(x) - N + 1)];
for n = [1:floor(length(x) / N * 4)] * (N / O);
    Xk = vertcat(Xk,fft(circshift(x, [0 -1*n])(1:N) .* w));
end
a = 1; % time-stretch factor
ly = l / a; % length in seconds of output
Yk = Xk(1,:);
for n = [1:a:size(Xk)(1) - 1];
    Yk = vertcat(Yk,Xk(ceil(n * a + 1),:) ...
    .* (Yk(end,:) ./ Xk(floor(n * a + 1),:)) ...
    .* (abs(Yk(end,:) ./ Xk(floor(n * a + 1),:)) .^ -1));
end
yk = real(ifft(Yk,N,2)); % inverse transform each window
yk = yk ;%.* w;      % window again
y = zeros(1,N + (N / O) * (size(yk)(1) - 1));
offsets = [0:N/O:length(y)-N]';
for yn = horzcat(offsets,yk)';
    y += circshift(horzcat(yn(2:end)', ...
        zeros(1,length(y) - length(yn(2:end)'))), [0 yn(1)]);
end
wavwrite(y,sr,"syro-010-stretch-1.wav");
%surf(abs(Yk));
t = [0:3999];
plot(t,y(1:4000));

