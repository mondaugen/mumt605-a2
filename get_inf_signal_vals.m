function [y] = get_inf_signal_vals(x,k)
% GET_INF_SIGNAL_VALS Given signal x and indices k, return a vector y = x[k] for
% all k. If k is not in a valid range, put 0 in that place. The indexing of k is
% MATLAB style. x is in ROW format.
l = (k > 0 & k <= length(x)) .* k;
x = horzcat(x,[0]);
l(l == 0) = length(x);
y = x(l);
endfunction
