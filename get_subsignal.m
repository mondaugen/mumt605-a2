function [y] = get_subsignal(x,a,b)
    % GET_SUBSIGNAL return signal y that is x[a] x[a+1] ... x[b-1] x[b]. If a < 0 or
    % b >= length(x), puts 0s for these indices (assumes signal is 0 outside of
    % defined interval).
    L = length(x);
    lbound = a;
    lpad = [];
    rbound = b;
    rpad = [];
    if (a < 0)
        lbound = 0;
        lpad = zeros(1,-a);
    end
    if (b >= L)
        rbound = L - 1;
        rpad = zeros(1, b - rbound);
    end
    lbound += 1; % for MATLAB indexing
    rbound += 1;
    y = horzcat(horzcat(lpad,x(lbound:rbound),rpad));
endfunction
