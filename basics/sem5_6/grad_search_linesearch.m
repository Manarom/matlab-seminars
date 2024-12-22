function [x,Fval,ii,flag,search_history]=grad_search_linesearch(x0,F,gradF,options)
% простой оптимизатор методом градиентного спуска с линейным поиском
% параметры см GRAD_SEARCH
    arguments
        x0 double
        F function_handle
        gradF function_handle
        options.mu (1,1) double =1e-2
        options.N (1,1) double =10000
        options.tol (1,1)double =1e-6
    end
    is_return_search_history = false;x=x0(:);ii=1;mu = options.mu;N = options.N;tol = options.tol;flag=[true true];
    if nargout==5 % так как хранение всех точек может быть тяжелым
        is_return_search_history =true;% если число выходных аргументов равно пяти, то значит нужно сохранить историю
        search_history = NaN(numel(x),N);% резервируем память под все точки алгоритма
        search_history(:,1) = x0;
    end
    
    Fval=F(x0);
    while ii<N && all(flag) % условием остановки служит достидение заданного числа итераций и проверка сходимости
        x_previous=x;
        F_previous = Fval; % рассчитываем значение функции
        grad_value = gradF(x); % рассчитываем градиент функции
        grad_direction = grad_value/norm(grad_value); % используем только направление градиента
        grad_direction = grad_direction(:);
        jj=1;% счетчик триальных итераций
        Fval_trial=Fval; mu_trial=mu;% стартовые 
        while (ii<N) && (jj<=10)% в этом цикле производим варьирования длины шага вдоль градиента
                %x_previous_trial=x_trial;
                Ftrial_previous = Fval_trial; % сохраняем значения с предыдущего шага
                x_trial= x - mu_trial*grad_direction; % рассчитываем координату для следующей пробной точки
                Fval_trial=F(x_trial);% рассчитываем значение функции для это пробной точки
                % флажок проверки сходимости, определяется изменением функции на 
                % последовательных итерациях
                if is_return_search_history
                    search_history(:,ii+1) = x_trial;
                end
                if Fval_trial<Ftrial_previous
                    mu_trial = mu_trial*2;
                else
                    mu_trial = mu_trial/2;
                    break
                end
                jj=jj+1;ii=ii+1;
        end
        mu=mu_trial;
        x= x - mu*grad_direction;
        Fval=F(x);ii=ii+1;
        flag = [norm(Fval-F_previous)>tol ...
            norm(x_previous-x)>tol]; 
        
    end
    if is_return_search_history
        search_history = search_history(:,1:ii);
    end
end
