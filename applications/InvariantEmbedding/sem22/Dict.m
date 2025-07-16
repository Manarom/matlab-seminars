classdef Dict< handle
    % обертка вокруг стандартного словаря (dictionary) чтобы передавать его
    % по указателю (pass-by-handle)
    properties
        d % стандартный словарь
    end
    %events
    %    new_element
    %end
    methods
        function obj = Dict()
            obj.d = dictionary;
        end
        function f = haskey(obj,k)
           f = obj.d.isConfigured && obj.d.isKey(k);
        end
        function add(obj,key,val)
            obj.d = insert(obj.d,key,val);
            %notify(obj,"new_element")
        end
        function val = get(obj,key)
            val = obj.d(key);
        end
    end
end