classdef Wolfe < a2DFunction
    
    properties (Constant)
        startPoint = [4 ;5];
        optimalPoint = [-1; 0];
        optimalValue = -8;
        name = 'wolfe';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            value = 0;
            y = x(2);
            x = x(1);
            
            mask1 = x<=0;
            mask2 = x >= abs(y);
            mask3 = ~(mask1 | mask2) ;
            value(mask1) = 9*x(mask1) + 16*abs(y(mask1)) - x(mask1).^9;
            value(mask2) = 5* sqrt(9 * x(mask2).^2 + 16*y(mask2).^2 );
            value(mask3) = 9*x(mask3) + 16*abs(y(mask3));
        end
        
        function value = getValueForPlot(~,x,y)
            value = zeros(size(x));
            
            mask1 = x<=0;
            mask2 = x >= abs(y);
            mask3 = ~(mask1 | mask2) ;
            value(mask1) = 9*x(mask1) + 16*abs(y(mask1)) - x(mask1).^9;
            value(mask2) = 5* sqrt(9 * x(mask2).^2 + 16*y(mask2).^2 );
            value(mask3) = 9*x(mask3) + 16*abs(y(mask3));
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
