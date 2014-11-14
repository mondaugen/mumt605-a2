function [Yui] = pvoc_synthstep(x, H, ui, Yui_1, a, N)
%PVOC_SYNTHSTEP Do one step of synthesis as described by Puckette in paper.
ti = ui / a;
si = ti - H;
Yui_1;
x;
Xti = stft(x,ti,N);
Xsi = stft(x,si,N);
qYX = ( Yui_1 ./ Xsi ); % quotient used twice in equation
Yui = Xti .* qYX  .* (abs(qYX) .^ -1);
endfunction
