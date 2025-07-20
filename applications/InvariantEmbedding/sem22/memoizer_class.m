classdef memoizer_class<handle
    % позволяет имитировать паттерн closure для рекурсивной 
    % функции, которая принимает функцию в качестве второго аргумента
    % f = @(x,f) f(N-2)+ f(N-1)  - например для последоватлеьности
    % Фибоначчи
    properties (SetAccess=private)
        d Dict
        f function_handle
    end
    methods
        function obj = memoizer_class(f,init_keys,init_vals)
            arguments
                f function_handle
                init_keys double=[]
                init_vals double=[]
            end
            obj.d = Dict();
            if ~isempty(init_keys)
                arrayfun(@(i)add(obj.d,init_keys(i),init_vals(i)),1:length(init_keys));
            end
            obj.f = f;
        end
        function val = fun(obj,N)
            if obj.d.haskey(N)
                val = obj.d.get(N);
            else
                val = obj.f(N,@obj.fun);
                obj.d.add(N,val)
            end
        end
    end
end

