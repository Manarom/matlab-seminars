function s = iterator_example(a)
iterator = StatefulIterator();

    while iterator.iterate(a) ~= -1 end

    s = iterator.value;
end

