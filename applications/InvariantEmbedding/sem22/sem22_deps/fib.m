function out = fib(N)
    if N<=2
        out=1;
        return
    end
    out = fib(N-2) + fib(N-1);
end