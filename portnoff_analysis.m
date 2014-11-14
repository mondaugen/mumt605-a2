function [Xk] = portnoff_analysis(x, n, w, N, K)
% PORTNOFF_ANALYISIS gives the short-time spectrum of signal x as a COLUMN of
%                    height N.
%                    x is the signal to do analysis on in COLUMN format
%                    n is the index at which to do it or so we get Xk[n]
%                    w is a window of length KN + 1 which is 0 for lN, all l
%                       (windowed sinc) 
%                    N is the length of the FFT
%                    K is how long the window is, in number of Ns
L = K * N + 1; % length of window
pleft = n - floor(L/2);
if (pleft < 0)
    pleft = 0;
endif
pright = n + floor(L/2);
if (pright >= length(x))
    pleft = length(x) - 1;
endif
p = [pleft:pright] + 1; % add 1 for MATLAB indexing
z = x(p) .* w;
% because L = NK + 1, the window length, we add N - 1 zeros to make it a
% multiple of N for proper folding
z = vertcat(z,zeros(N-1,1));
% do folding
z = reshape(z,N,K+1);
z = sum(z,2);
% shift circularly to multiply by exp(-j * 2 * pi * n)
z = circshift(z,[n 0]); % n is positive because cirshift shifts backwards
Xk = fft(x);
