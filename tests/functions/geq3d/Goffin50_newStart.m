classdef  Goffin50_newStart < aFunction
    
    properties (Constant)
        startPoint = [-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0169,-0.0181,-0.0169]';
        optimalPoint = zeros(50,1);
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
