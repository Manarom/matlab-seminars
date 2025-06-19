classdef VectorSpace
    
    methods (Abstract)
        plus
        times
        disp
    end
    methods
        % дефолтный метод абстрактного класса
        function v = sum(varargin)
            arguments (Repeating)
                varargin VectorSpace
            end
            v = varargin{1};
            for vi = varargin(2:end)
                v = plus(v,vi{1});
            end
        end
    end
end

