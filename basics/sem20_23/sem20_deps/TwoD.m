classdef TwoD < OneD % имя суперкласса
    % Второй класс
    properties
        y double {mustBeScalarOrEmpty} =[]
    end
    methods % по сути это обычные функции, котрые сгруппированы в один файл
        function obj = TwoD(arg1,arg2)
            % Функция с тем же именем, что и класс - конструктор объекта
            obj@OneD(arg1) % o
            obj.y = arg2;
        end
        function o3 = plus(o1,o2)
            o3 = TwoD(o1.x + o2.x,o1.y + o2.y);
        end
    end
end