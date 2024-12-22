function [x,Fval,ii,flag,search_history]=grad_search(x0,F,gradF,options)
% простой оптимизатор методом градиентного поиска
% входные аргументы:
%                   x0 - стартовая точка
%                   F - указатель на скалярную функцию векторного аргумента
%                   gradF - указатель на функцию расчета градиента функции
%                           F
%                   Опциональные аргументы в формате имя-значение
%                   mu (optional)- амплитудный коэффициент, длина шага 
%                   N (optional)- ограничение на число итераций
%                   tol (optional)- точность (относительное изменение для
%                   двух последовательных итераций)
% выходные аргументы:
%                   x - оптимальное значение вектора параметров оптимизации
%                   (минимизатор)
%                   Fval - значение функции для найденного минимизатора
%                   ii - число вычислений функции и ее градиента
%                   flag - флажок критериев сходимости
%                   search_history - матрица, у которой столбцы -
%                   координаты в пространстве оптимизации, по которым ходил
%                   алгоритм
%                   
    arguments
        x0 double
        F function_handle
        gradF function_handle
        options.mu (1,1) double =1e-2
        options.N (1,1) double =10000
        options.tol (1,1)double =1e-6
    end
    ii=1;
    x=x0(:);mu = options.mu;N = options.N;tol = options.tol;
    flag=[true true];
    Fval=F(x0);
    is_return_search_history = false;
    if nargout==5 % так как хранение всех точек может быть тяжелым
        is_return_search_history =true;% если число выходных аргументов равно пяти, то значит нужно сохранить историю
        search_history = NaN(numel(x),N);% резервируем память под все точки алгоритма
        search_history(:,1) = x0;
    end
    while ii<N && all(flag) % условием остановки служит достидение заданного числа итераций и проверка сходимости
        x_previous=x;F_previous = Fval; % значения коордианты и функции на предыдущей итерации
        grad_value = gradF(x); % рассчитываем градиент функции
        if norm(grad_value)==0
            return
        end
        grad_direction = grad_value/norm(grad_value); % используем только направление градиента
        x= x - mu*grad_direction(:);% рассчитываем координату для следующей точки
        Fval=F(x); % рассчитываем значение функции для этой координаты
        if is_return_search_history
            search_history(:,ii+1) = x;% если нужны промежуточные точки - добавляем
        end
        % флажок проверки сходимости
        flag = [norm(Fval-F_previous)>tol ...%  изменение значения функции
            norm(x_previous-x)>tol]; %  изменение координаты
        ii=ii+1; 
    end
    if is_return_search_history
        search_history = search_history(:,1:ii);
    end
end
