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
        function o1 = plus(o1,o2)
            o1.x = o1.x + o2.x;
        end
        function o1 = triplus(o1,o2,o3)
            disp("OneDhandle method called")
            o1.x = o1.x + o2.x + o3.x;
        end
        function out = sum(o)
            out = OneDhandle();
            for i = 1:numel(o)
                plus(out,o(i));
            end
        end
    end
end

