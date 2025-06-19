classdef OneD
    % Первый класс
    properties
        x double {mustBeScalarOrEmpty} =[]
    end
    methods % по сути это обычные функции, котрые сгруппированы в один файл
        function o = OneD(input_arg)
            arguments
                input_arg = 0
            end
            % Функция с тем же именем, что и класс - конструктор объекта
            o.x = input_arg;
        end
        function o3 = plus(o1,o2)
            o3 = OneD(o1.x + o2.x);
        end
        function o4 = triplus(o1,o2,o3)
            disp("OneD method called") 
            o4 = OneD(o1.x + o2.x + o3.x);
        end
        function s = sum(oo)
            s = oo(1); % double 
            for i=2:numel(oo)
                s = s + oo(i);
            end
        end
    end
end