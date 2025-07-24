classdef CircVectorSpace<VectorSpace
    properties
        r double
    end
    
    methods
        function obj = CircVectorSpace(r)
            arguments
                r {mustBePositive}
            end
            obj.r=floor(r);
        end
        function s = area(c)
            s = pi*(c.r)^2;
        end
        function c3 = plus(c1,c2)
            c3 = CircVectorSpace(sqrt((area(c1) + area(c2))/pi));
        end
        function v3 = times(v,a)
            v3 = CircVectorSpace(sqrt(area(v)*a/pi));
        end
        function disp(obj)
            disp("Круг с радиусом "+ obj.r + " площадью " + area(obj))
        end
        function scene = show(obj)
            if obj.r < 100
                scene = zeros(100,100);
            else
                scene = zeros(floor(1.5*obj.r),floor(1.5*obj.r));
            end
            center = floor(size(scene)/2);
            for j =1:size(scene,2)
                for i = 1:size(scene,1)
                     if sqrt( (i - center(1))^2 + (j - center(2))^2 ) <=obj.r
                         scene(i,j) = 255;
                     end
                end
            end
        end
    end
end

