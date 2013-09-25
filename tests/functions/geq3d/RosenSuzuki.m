classdef RosenSuzuki < aFunction
    
    properties (Constant)
        startPoint = [0 ; 0; 0; 0];
        optimalPoint = [0; 1; 2; -1];
        optimalValue = -44;
        name = 'Rosen/Suzuki';
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
            x3 = x(3);
            x4 = x(4);

            f1 = x1^2 + x2^2 + 2*x3^2 + x4^2 - 5*x1 - 5*x2 - 21*x3 + 7*x4;
            f2 = x1^2 + x2^2 + x3^2 + x4^2 + x1 - x2 + x3 - x4 - 8;
            f3 = x1^2 + 2*x2^2 + x3^2 + 2*x4^2 - x1 - x4 - 10;
            f4 = x1^2 + x2^2 + x3^2 + 2*x1 - x2 - x4 - 5;

            value = max ([f1,f1 + 10*f2,f1 + 10*f3,f1 + 10*f4]);
        end
        
        function value = getSubgradientAt(obj, x)
            obj.subgradientCalls = obj.subgradientCalls + 1;
            reset = obj.functionCalls;
            value = Subgradient(@obj.getValueAt, x);
            obj.functionCalls = reset;
        end 
    end
end
