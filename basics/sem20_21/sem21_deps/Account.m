classdef Account<AttributesToy
    properties (Dependent) % атрибут dependent означает, что свойство не хранится в объекте,
        % а рассчитывается при его запросе
        last_operation
    end
    methods
        function obj = Account(name,password)
            obj@AttributesToy(name,password);
        end
        function add_percent()
    end
end