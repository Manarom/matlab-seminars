classdef NumVectors<VectorSpace
    properties
        v double
    end
    
    methods
        function obj = NumVectors(v)
            
            obj.v=v;
        end
        function v3 = plus(v1,v2)
            v3 = NumVectors(v1.v + v2.v);
        end
        function v3 = times(v,a)
            v3 = NumVectors(v.v*a);
        end
        function disp(obj)
            disp("Вектор с координатами " + join(string(obj.v),", "))
        end
    end
end

