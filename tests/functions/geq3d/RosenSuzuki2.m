classdef RosenSuzuki2 < aFunction
    
    properties (Constant)
        startPoint = [0 ; 0];
        optimalPoint = [1.1707;1.7402];
        optimalValue = -44;
        name = 'Rosen/Suzuki2';
    end
    
    properties(SetAccess = 'private')
        functionCalls = 0;
        subgradientCalls = 0;
    end
    
    methods 
        function value = getValueAt(obj,x)
            obj.functionCalls = obj.functionCalls + 1;
            
            x1 = x(1);
            x2 = x(2);

            f1 = x1^2 + x2^2 - 5*x1 - 5*x2;
            f2 = x1^2 + x2^2+ x1 - x2 - 8;
            f3 = x1^2 + 2*x2^2 - x1 - 10;
            f4 = x1^2 + x2^2 + 2*x1 - x2 - 5;

            value = max ([f1,f1 + 10*f2,f1 + 10*f3,f1 + 10*f4]);
        end
        
        function value = getValueForPlot(~,x1,x2)
            
            f1 = x1.^2 + x2.^2 - 5*x1 - 5*x2;
            f2 = x1.^2 + x2.^2+ x1 - x2 - 8;
            f3 = x1.^2 + 2*x2.^2 - x1 - 10;
            f4 = x1.^2 + x2.^2 + 2*x1 - x2 - 5;

            value = max(f1,max(f1 + 10*f2, max(f1 + 10*f3,f1 + 10*f4)));
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
