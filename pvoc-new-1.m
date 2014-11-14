x = [0 0 0 0 1 2 3 4 0 0 0 0];
S = stft(x,4,4);
s = ifft(S)
k = [0:length(s) - 1];
plot(k,s);
