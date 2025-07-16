function val = fib_mem(N)
    persistent M
    if isempty(M)
        M = Dict();
    end
    if N<=2
        val = 1;
        M.add(N,val);
        return
    end
    if M.haskey(N)
        val = M.get(N);
        return 
    end
    val  = fib_mem(N-1) + fib_mem(N-2);
    M.add(N,val);
end