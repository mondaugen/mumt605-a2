function [xn] = portnoff_synth(sn,f,n,R,Q,N)
% PORTNOFF_SYNTH synthesizes a sample of the signal x[n].
%   sn is a matrix of spectral chunks defined such that column 1 = ifft{Xk[0]},
%   column 2 = ifft{Xk[R]}, ... column n = ifft{Xk[(n-1)R]}
%   f is the impulse response of an interpolating filter of length 2RQ + 1
%   (probably a windowed sinc function) as a COLUMN vector
%   n is the sample number you want to look up
%   R is the "hop size" or interpolation factor
%   Q is analogous to K and is really just a measure of how long the window is.
%   N is the height of each column of sn or the size of the FFT that was
%   performed on them
rleft = (floor(n/R) - Q + 1);
if (rleft < 0)
    rleft = 0;
endif
rright = (floor(n/R) + Q);
if (rright >= size(sn)(2))
    rright = size(sn)(2) - 1;
endif
r = [rleft:rright] + 1; % add 1 for MATLAB indexing
nrR = -R * r + n + (length(f) - 1) / 2;
snr = sn(mod(n,N) + 1,r); % add 1 for MATLAB indexing
fnrR = get_inf_signal_vals(f,nrR);
xn = snr * fnrR.';
endfunction
