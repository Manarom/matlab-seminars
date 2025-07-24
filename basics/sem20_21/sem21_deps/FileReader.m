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
end