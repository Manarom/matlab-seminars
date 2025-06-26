classdef MapIterator<Iterator
    %iterator which maps collection to another collection
    
    properties
        func function_handle
        iter Iterator
    end
    
    methods
        function obj = MapIterator(func,iter)
            arguments
                func function_handle
                iter Iterator
            end
            obj@Iterator(iter.collection,iter.state,iter.max_state)
            obj.func = func;
            obj.iter = iter;
        end
        
        function [state,val] = iterate(obj)
             [state, val] = iterate(obj.iter);
             val = obj.func(val);
        end
    end
end

