classdef FileReader < Collection %& matlab.mixin.indexing.RedefinesParen
    properties  %(SetAccess = private)
        filename  %double {mustBePositive}
        lines_number
    end
    methods
        function obj = FileReader(filename)
            if ~isfile(filename)
                error("Not a file")
            end
            fid = fopen(filename);
            oncl = onCleanup(@()fclose(fid));
            n = 0;
            while ~feof(fid)
                fgetl(fid);
                n=n+1;
            end
            obj.lines_number = n;
            obj.filename = filename;
        end

        function out = get_index(obj,i)
            out = [];
            if i>obj.lines_number
                error("out of bounds")
            end
            fid = fopen(obj.filename);
            oncl = onCleanup(@()fclose(fid));
            n = 0;
            while ~feof(fid) && n<=i
                out = fgetl(fid);
                n=n+1;
            end

        end
        function out = length(obj)
            out= obj.lines_number;
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