classdef AttributesToy<handle
    properties (SetAccess = protected)
        name (1,1) string
    end
    properties (Access=protected)
        transactions_history disctionary
    end
    properties (Access = private)
        secret_key  (1,1) string%= "afsjdf@4537484hjhf"
        all_your_money %= 0
        
    end
    methods (Access = public)
        function obj = AttributesToy(name,secret)
            arguments
                name (1,1) string
                secret (1,1) string
            end
            obj.name = name;
            set_secret_key(obj,secret);
        end
        function add_money(obj,value,password)
            arguments
                obj
                value (1,1) double {mustBePositive}
                password (1,1) string
            end
            change_ammount(obj,value,password)
        end
        function get_money(obj,value,password)
            arguments
                obj
                value (1,1) double {mustBePositive}
                password (1,1) string
            end
            change_ammount(obj,-value,password)
        end
        function val = balance(obj,password)
            is_ok = check_password(obj,password);
            if ~is_ok
                val = "wrong password";
                return
            end
            val = obj.all_your_money;
        end
        function authorized_action(obj,action_name,password)
            
        end
    end
    methods (Access=private,Sealed) % sealed означает, что свойство или метод не могут быть переопределены
        function set_secret_key(obj,k)
            obj.secret_key = k;
        end
        function is_ok = check_password(obj,password)
            is_ok = strcmp(password,obj.secret_key);
        end
        function is_ok = change_ammount(obj,value,password)
            is_ok = check_password(obj,password);
            if is_ok  
                obj.all_your_money = obj.all_your_money + value;
                obj.transactions_history(now()) = value;
            else
                display("wrong password")
            end
        end
    end
   
end

