function [s] = istft(X,t,L)
% RSTFT Finds the "inverse" short-time fourier transform. It does this by
% calling ifft on X giving x, padding with 0s to make a signal s of length L and
% then shifting to time t, making sure the signal is 0 outside of the interval
% [t, length(X) + t]
N = length(X);
if (mod(N,2) == 0)
    N = N - 1; % make N odd
endif
w = hanning(N)';
w = horzcat(w,[0]);
x = ifft(X);
s = x .* w;
s = horzcat(s,zeros(1,L - length(x)));
s = circshift(s, [0 t]);
if (t < 0)
    s((length(x) + t + 1): length(x)) = 0;
elseif (t > 0)
    s(1:t) = 0;
endif
s = s(1:L);
endfunction
    
