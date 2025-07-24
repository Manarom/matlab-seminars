function s = functional_example(input_array)
    s = sum_fun(1,input_array,0);
end

function s = sum_fun(i,a,s)
    if i<=numel(a)
        s = s+a(i);
        i = i+1;
        s = sum_fun(i,a,s);
    else
        return
    end
        
end