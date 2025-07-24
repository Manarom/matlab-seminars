using BenchmarkTools

function fib(N) 
    return N<=2 ? 1 : fib(N-2) + fib(N-1)
end
@benchmark fib(45)
# fib(45) = 3.54 s
const D = Ref(Dict{Int,Int}())
function fib_mem(N)
    !haskey(D[],N) || return D[][N] 
    push!(D[],N=> N<=2 ? 1 : fib_mem(N-2) + fib_mem(N-1))
    return D[][N] 
end
# fibonacci with memoization
@benchmark fib_mem(45)

# memoization with closure pattern
function memoize(f)
    D = Dict{Int,Int}()
    N-> begin 
        !haskey(D,N) || return D[N]
            push!(D,N=> f(N))
        return D[N]
    end
end

f = N-> N<=2 ? 1 : f(N-1) + f(N-2) 

f = memoize(f)

@benchmark f(45)
