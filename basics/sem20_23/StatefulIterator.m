classdef StatefulIterator<handle
    % итератор  - это объект, хранит состояние массива и 
    % применяет к элементу массива action_function
    properties
        state = 0
        value = []
    end
    
    methods
        % function obj = StatefulIterator()
        %     obj.state = 0;
        % end
        function next_state = iterate(obj,a)
            next_state = -1;
            if obj.has_next_state(a)
                return
            end
            obj.state = obj.state + 1;
            next_state = obj.state;
            if isempty(obj.value)
                obj.value = a(obj.state);
                return
            end
            obj.refresh_value(a(obj.state)); % функция, которая обновляет переменную, хранящую значения
        end
        function flag = has_next_state(obj,a)
            flag = (obj.state+1)>numel(a); % можно ускорить запомним число элементов 
        end
        function refresh_value(obj,a_next)
            obj.value = obj.value + a_next;
        end
    end
end

