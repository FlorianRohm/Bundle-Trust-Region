classdef Bathtub < a2DFunction
    
    properties (Constant)
        startPoint = [5 ;2];
        optimalPoint = [0;0];
        optimalValue = 0;
        name = 'bathtub';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            
            y = x(2);
            x = x(1);
            
            mask = (x.^2 + 10*y.^2)>1;
            value = zeros(size(x));
            value(mask) = (sqrt(x(mask).^2+10*y(mask).^2)-1).^2;
        end
        
        function value = getValueForPlot(~,x,y)
            
            mask = (x.^2 + 10*y.^2)>1;
            value = zeros(size(x));
            value(mask) = (sqrt(x(mask).^2+10*y(mask).^2)-1).^2;
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
