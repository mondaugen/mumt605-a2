function [y] = vecty(x,r,n)
% VECTY extract column of length n at r in x
% no bounds checking yet
    u = [r:r+n];
    y = x(u);
endfunction
