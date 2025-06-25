classdef StatefulIteratorPlus<StatefulIterator
    % итератор  - это объект, хранит состояние массива и 
    % применяет к элементу массива action_function
    properties
        action_function function_handle
    end
    methods
        function obj = StatefulIteratorPlus(collection,action_function)
            arguments
                collection
                action_function function_handle = @plus
            end
            obj@StatefulIterator(collection); % вызываем конструктор суперкласса
            obj.action_function = action_function;
        end
        function refresh_value(obj,a_next)
            obj.value = obj.action_function(obj.value,a_next);
        end
    end
end

