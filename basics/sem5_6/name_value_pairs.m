function out = name_value_pairs(options)
% Важно при написании функций делать к ним хорошую документацию. 
% Блок arguments можно рассматривать как часть документации, так как информация о типах, 
% структуре и области определения входных аргументов функции многое говорит о функции
    arguments 
        options.A (1,1) {mustBeInteger,mustBePositive} = 3 % означает, что аргументы должен быть целым
        options.B (1,:)  double {mustBeFromPitoPi} = linspace(-pi,pi,100) % дополнительно указан тип аргумента, также размерность указана частично!
        options.C (1,1) string {mustBeMember(options.C,["sin" "cos" "tan"])} ="sin" % 
    end
    out = repmat(transpose(options.B),[1 options.A]);
    fun_handle = str2func(options.C);
    for i = 1:options.A
        out = fun_handle(out);
    end
end
function mustBeFromPitoPi(x)
% самодельный валидатор
        try
            tf = (x<=pi)&&(x>=-pi);
        catch me %#ok<NASGU>
            tf = false;
        end
        
        if ~tf
            throwAsCaller(MException('MyComponent:noSuchVariable',"Value must be from -pi to pi"));
        end
end