classdef TwoD < OneD
    % Второй класс
    properties
        y double {mustBeScalarOrEmpty} =[]
    end
    methods % по сути это обычные функции, котрые сгруппированы в один файл
        function obj = TwoD(arg1,arg2)
            % Функция с тем же именем, что и класс - конструктор объекта
            obj@OneD(arg1)
            obj.y = arg2;
        end
    end
end

