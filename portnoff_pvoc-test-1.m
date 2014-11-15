sr = 8000; % sampling rate
Tr = 1/sr; % sampling period
t = [0:Tr:1]; % 1 seconds of sound
f1 = 3500;   % end frequency of sine tone
f0 = 200;    % starting freq
Tf = 1;
phi = 2 * pi * (f1 - f0)/(2 * Tf) * (t .^ 2);
x = sin(phi)';
%x += sin(f1 * t * 2 * pi)';
N = 512;
H = 128;
K = 4;
wax = [-K*N/2:K*N/2] / N; % analysis window indices
wa  = hanning(length(wax))' .* sinc(wax);
Xk = [];
n = 100;
for n = [0:H:length(x)]
    Xk = horzcat(Xk,portnoff_analysis(x,n,wa',N,K));
end
surf(abs(Xk));
