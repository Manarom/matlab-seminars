function s = iterator_plus_example(input_array,fun)
arguments
    input_array double
    fun function_handle =@plus
end
    iterator = StatefulIteratorPlus(fun);

    while iterator.iterate(input_array) ~= -1 end

    s = iterator.value;
end

