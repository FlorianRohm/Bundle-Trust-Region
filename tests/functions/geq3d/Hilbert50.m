classdef  Hilbert50 < aFunction
    
    properties (Constant)
        startPoint = zeros(50,1);
        optimalPoint = ones(50,1);
        optimalValue = 0;
        name = 'Hilbert';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            
            aOne= ones(size(x));
            H = hilb(50);
            value = dot(x-aOne ,H*(x-aOne) );
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
