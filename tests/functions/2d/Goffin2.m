classdef Goffin2 < a2DFunction
    
    properties (Constant)
        startPoint = [25 ;-25.5];
        optimalPoint = [0;0];
        optimalValue = 0;
        name = 'Goffin2';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            
            value = 2*max(x)-sum(x);
        end
        
        function value = getValueForPlot(~,x,y)
            
            value = 2*max(x,y) - x-y;
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
