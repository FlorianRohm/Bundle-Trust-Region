classdef  Goffin50 < aFunction
    
    properties (Constant)
        startPoint = linspace(1,50,50)' - repmat(25.5,50,1);
        optimalPoint = [linspace(-12,1,14)'; repmat(2,36,1)];
        optimalValue = 0;
        name = 'Goffin';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            value = 50*max(x) - sum(x);
        end
        
        function value = getSubgradientAt(obj, x)
            obj.subgradientCalls = obj.subgradientCalls + 1;
            reset = obj.functionCalls;
            value = Subgradient(@obj.getValueAt, x);
            obj.functionCalls = reset;
        end
        
        function resetCounters(obj)
            obj.functionCalls = 0;
            obj.subgradientCalls = 0;
        end    
    end
end
