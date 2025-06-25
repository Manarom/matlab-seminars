classdef StatefulIterator<handle
    % итератор  - это объект, хранит состояние массива и 
    % применяет к элементу массива action_function
    properties
        state 
        value = []
        collection
        max_state
    end
    
    methods
        function obj = StatefulIterator(collection,initial_state,max_state)
            arguments
                collection
                initial_state = 0
                max_state double = []
            end
             obj.state = initial_state;
             obj.collection = collection;
             if isempty(max_state)
                 obj.max_state = numel(collection);
             else
                obj.max_state = max_state;
             end
        end
        function next_state = iterate(obj)
            next_state = -1;
            if obj.has_next_state()
                return
            end
            obj.state = obj.state + 1;
            next_state = obj.state;
            if isempty(obj.value)
                obj.value = obj.collection(obj.state);
                return
            end
            obj.refresh_value(obj.collection(obj.state)); % функция, которая обновляет переменную, хранящую значения
        end
        function flag = has_next_state(obj)
            flag = (obj.state+1)>obj.max_state; % можно ускорить запомнив число элементов 
        end
        function refresh_value(obj,a_next)
            obj.value = obj.value + a_next;
        end
    end
end

