classdef Iterator<handle
    properties
        state 
        collection
        max_state
    end
    
    methods
        function obj = Iterator(collection,initial_state,max_state)
            arguments
                collection Collection
                initial_state = 1
                max_state double = []
            end
             obj.state = initial_state;
             obj.collection = collection;
             if isempty(max_state)
                 obj.max_state = length(collection);
             else
                obj.max_state = max_state;
             end
        end
        function [next_state,value] = iterate(obj)
            next_state = -1;
            value = obj.collection.get_index(obj.state);
            if ~obj.has_next_state()
                return
            end
            obj.state = obj.state + 1;
            next_state = obj.state;
        end
        function flag = has_next_state(obj)
            flag = (obj.state+1)<=obj.max_state; % можно ускорить запомнив число элементов 
        end
        function val = collect(obj)
            N = obj.max_state;
            i0 = obj.state;% начальное состояние
            val = NaN(N,1);% резервируем память под выходной массив
            % constructor = str2func(class(obj.collection))
            while true
                [i,v] = obj.iterate();
                val(i0) = v;
                if i>0
                    i0 = i;
                else
                    val = val(~isnan(val));
                    return
                end
            end
        end
    end
end

