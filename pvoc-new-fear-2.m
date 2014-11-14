clear;
x = wavread("a.wav")';
x = x / max(abs(x));
P = length(x); % length of input sound
t = [0:P-1]; % samples of input sound
T1 = 64;     % period of input sinusoid
N = 8;                 % length of FFT
H = N / 4;               % hop size
Yu = stft(x,0,N);        % starting spectrum (same as input spectrum)
a = 1;                   % time stretch factor, a > 1 is slower 0 < a < 1 is
                         % faster
L = P * a;
for u = [H:H:L-N];
    Yu = vertcat(Yu,pvoc_synthstep(x,H,u,Yu(size(Yu)(1),:),a,N));
end
y = zeros(1,L);
u = 0;
for Y = Yu.';
    y += istft(Y.',u,L);
    u += H;
end
u = [0:L - 1];
plot(u,y);
y = y / max(abs(y)); % normalize
wavwrite(y,"a-stretch-1.wav");
