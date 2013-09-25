classdef CB2 < a2DFunction
    
    properties (Constant)
        startPoint = [1 ;-.1];
        optimalPoint = [1.1390;0.8996];
        optimalValue = 1.952;
        name = 'CB2';
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
            
            anOne = ones(size(x));
            
            value = max(x.^2 + y.^4 , (2*anOne-x).^2 + (2*anOne-y).^2 );
            value = max(value, 2*exp(-x+y));
        end
        
        function value = getValueForPlot(~,x,y)
            anOne = ones(size(x));
            
            value = max(x.^2 + y.^4 , (2*anOne-x).^2 + (2*anOne-y).^2 );
            value = max(value, 2*exp(-x+y));
        end
        
        function value = getSubgradientAt(obj, x)
            obj.subgradientCalls = obj.subgradientCalls + 1;
            reset = obj.functionCalls;
            value = Subgradient(@obj.getValueAt, x);
            obj.functionCalls = reset;
        end 
    end
end
