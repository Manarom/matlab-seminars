function s = funfunfun(varargin)
    arguments (Repeating)
        varargin string
    end
    s = "";
    for si = varargin
        s = s + si;
    end
end

