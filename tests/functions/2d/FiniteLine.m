classdef FiniteLine < a2DFunction
    
    properties (Constant)
        startPoint = [4 ;1.5];
        optimalPoint = [0;0]; 
        % this function won't produce 
        % right fiber error plots off the shelf
        optimalValue = 0;
        name = 'finiteLine';
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
            
            mask = (x.^2)>1;
            value = 10*y.^2;
            value(mask) = value(mask) + (x(mask).^2)-1;
        end
        
        function value = getValueForPlot(~,x,y)
        
            
            mask = (x.^2)>1;
            value = 10*y.^2;
            value(mask) = value(mask) + (x(mask).^2)-1;
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
