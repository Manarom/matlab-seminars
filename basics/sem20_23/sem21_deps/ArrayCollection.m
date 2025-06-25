classdef ArrayCollection<Collection
    properties
        array double
    end
    methods
        function obj = ArrayCollection(array)
            obj.array = array;
        end

        function out = get_index(obj,i)
            out = obj.array(i);
        end
        function out = length(obj)
            out= length(obj.array);
        end
    end
end