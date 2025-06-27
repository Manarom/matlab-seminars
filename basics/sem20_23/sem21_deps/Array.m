classdef Array < Collection %& matlab.mixin.indexing.RedefinesParen
    properties (SetAccess=private) %(SetAccess = private)
        array  %double {mustBePositive}
    end
    methods
        function obj = Array(array)
            obj.array = array;
        end

        function out = get_index(obj,varargin)
            out = obj.array(varargin{:});
        end
        function out = length(obj)
            out= length(obj.array);
        end
        function set_index(obj,i,v)
            if i>length(obj) || i<=0
                error("Out of bounds")
            end
            obj.array(i) =v;
        end
    end
    % собственное индексирование
    %{
    methods (Access = protected)
        function v = parenReference(obj, i)
            if  i.Type == matlab.indexing.IndexingOperationType.Paren  
                v = obj.array(i.Indices{:});
            else
                error("This type of indexing is not supported")
            end
        end

        function obj = parenAssign(obj,i,v)
           if  i.Type == matlab.indexing.IndexingOperationType.Paren  
                obj.array(i.Indices{:}) = v;
            else
                error("This type of indexing is not supported")
            end
        end
        function parenListLength(obj,varargin)
            disp(varargin)
        end
        function parenDelete(obj,varargin)
          disp(varargin)
        end

    end
    methods (Access=public)
        function v = size(obj)
            v = size(obj.array);
        end
        function cat(obj,varargin)
            disp(varargin)
        end
    end
    methods (Static)
        function obj = empty()
            obj = Array([]);
        end
    end
    %}
end
%  matlab.mixin.indexing.RedefinesParen
%       cat             - Concatenate objects
%       empty           - Create empty object of this class
%       parenAssign     - Overload parentheses indexed assignment
%       parenDelete     - Overload parentheses indexed deletion
%       parenListLength - Length of comma-separated list for parentheses
%                         indexing
%       parenReference  - Overload parentheses indexed reference
%       size            - Size of the object