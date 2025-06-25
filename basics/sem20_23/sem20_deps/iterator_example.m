function s = iterator_example(a)
iterator = StatefulIterator(a);

    while iterator.iterate() ~= -1 end

    s = iterator.value;
end

