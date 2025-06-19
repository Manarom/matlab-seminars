function s = functional_example_persistent(input_array)
    s = sum_fun(input_array);
end

function sm = sum_fun(a)
    persistent s
    persistent i
    if isempty(i)
        i=2;
        s = a(1);
        sm = sum_fun(a);
    end
    if i<=numel(a)
        s = s+a(i);
        i = i+1;
        sm=sum_fun(a);
    elseif ~isempty(s)
        sm = s;
        i = [];
        s = [];
        return
    else
        return
    end
        
end