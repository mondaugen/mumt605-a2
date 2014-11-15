clear;
sr = 8000; % sampling rate
Tr = 1/sr; % sampling period
x = wavread("syro-010-short.wav");
t = [0:length(x)-1] / sr;
N = 512;
H = 128;
K = 2;
Q = 2;
R = H;
wax = [-K*N/2:K*N/2] / N; % analysis window indices
wa  = hanning(length(wax)).' .* sinc(wax);
wsx = [-Q*R:Q*R] / R; % synthesis window indices
ws  = hanning(length(wsx)).' .* sinc(wsx);
% analysis
Xk = [];
for n = [0:H:length(x)];
    Xk = horzcat(Xk,portnoff_analysis(x,n,wa.',N,K));
end
% synthesis
sk = real(ifft(Xk));
y = [];
for n = [0:length(x)-1];
    y = horzcat(y,portnoff_synth(sk,ws,n,R,Q,N));
end
plot([0:length(x)-1],y);
wavwrite(y,"syro-010-short-pvoced.wav");
