clear;
sr = 8000; % sampling rate
Tr = 1/sr; % sampling period
t = [0:Tr:1]; % 1 seconds of sound
%f1 = 3500;   % end frequency of sine tone
f1 = 20;
f0 = 5;    % starting freq
Tf = 1;
phi = 2 * pi * ((f1 - f0)/(2 * Tf) * (t .^ 2) + f0 * t);
x = sin(phi).';
N = 512;
H = 128;
K = 8;
Q = 4;
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
