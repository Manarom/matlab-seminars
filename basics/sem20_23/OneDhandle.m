classdef OneDhandle<handle
    % Первый класс
    properties
        x double {mustBeScalarOrEmpty} =[]
    end
    methods % по сути это обычные функции, котрые сгруппированы в один файл, но !
        function obj = OneDhandle(input_arg)
            % Функция с тем же именем, что и класс - конструктор объекта
            arguments
                input_arg = 0
            end
            obj.x = input_arg;
        end
        function out = plus(o1,o2)
            out = OneD(o1.x + o2.x);
        end
        function out = sum(o)
            out = OneD();
            for i = 1:numel(o)
                out = out + o(i);
            end
        end
    end
end

