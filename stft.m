function [S] = stft(x, t, N)
% STFT  Finds the short-time fourier transform of x of length N at time t.
%       It does this by shifting the signal x so that t is at the origin of time
%       and then windows it with a Hann window. Finally it takes the fourier
%       transform of this signal. t is checked so that we can create a signal of
%       zeros outside of the defined interval of x.
d = -t;
s = circshift(x, [0 d]);
if (d < 0)
    s((length(x) + d + 1):length(x)) = 0;
elseif (d > 0)
    s(1:d) = 0;
endif
s = s(1:N);
if ( mod(N,2) == 0 ) % N is even
    N = N - 1;
endif
w = hanning(N)';
w = horzcat(w,[0]);
s = s .* w;
S = fft(s);
endfunction
