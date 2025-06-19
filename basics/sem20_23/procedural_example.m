function s = procedural_example(input_array)
    s = 0;
    for i =1:numel(input_array)
        s = s + input_array(i);
    end
end

