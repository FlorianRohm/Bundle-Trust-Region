classdef  Maxq20 < aFunction
    
    properties (Constant)
        startPoint = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; -1; -2; -3; -4; -5; -6; -7; -8; -9; -10];
        optimalPoint = zeros(20,1);
        optimalValue = 0;
        name = 'Maxquad dim 20';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            
            value = max(x.^2);
        end
        
        function value = getSubgradientAt(obj, x)
            obj.subgradientCalls = obj.subgradientCalls + 1;
            reset = obj.functionCalls;
            value = Subgradient(@obj.getValueAt, x);
            obj.functionCalls = reset;
        end 
    end
end
