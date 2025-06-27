classdef MapReducer<Iterator
    % итератор  - это объект, хранит состояние массива и 
    % применяет к элементу массива action_function
    % например:
    
    properties
        double_fun % функция двух аргументов 
        mapper MapIterator
        value
    end
    
    methods
        function obj = MapReducer(double_fun,el_fun,iter)
            arguments
                double_fun function_handle % функция двух аргументов, возвращающая одно значение
                el_fun function_handle % функция которая вызывается на элементе коллекции
                iter Iterator
            end
             obj@Iterator(iter.collection,iter.state,iter.max_state)   
             obj.double_fun = double_fun;
             obj.mapper = MapIterator(el_fun,iter);
        end
        function [state,val] = iterate(obj)
             [state, val] = iterate(obj.mapper);

             if ~isempty(obj.value)
                 obj.value =obj.double_fun(obj.value,val);
             else
                 obj.value =val;
             end
             val = obj.value;
        end

    end
end

