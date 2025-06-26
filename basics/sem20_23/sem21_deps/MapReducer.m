classdef MapReducer<Iterator
    % итератор  - это объект, хранит состояние массива и 
    % применяет к элементу массива action_function
    properties
        reduce_fun
        mapper MapIterator
    end
    
    methods
        function obj = MapReducer(reduce_fun,el_fun,iter)
            arguments
                reduce_fun function_handle
                el_fun function_handle
                iter Iterator
            end
                
             obj.state = initial_state;
             obj.collection = collection;
             if isempty(max_state)
                 obj.max_state = numel(collection);
             else
                obj.max_state = max_state;
             end
        end
        
    end
end

