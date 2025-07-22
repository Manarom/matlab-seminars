classdef CircArray<Array

    methods
        function obj = CircArray(c)
            obj@Array(c)
        end

        function out = get_index(obj,i)
            out = area(obj.array(i));
        end
    end
end