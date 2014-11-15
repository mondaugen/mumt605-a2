function [y] = vecty(x,r,n)
% VECTY extract column of length n at r in x
% no bounds checking yet
    u = repmat([0:n-1],length(r),1)' .+ r;
    y = x(u);
endfunction
