classdef a2DFunction < aFunction
    properties (Abstract,Constant) 
        startPoint
        optimalPoint
        optimalValue
    end
    properties (Abstract, SetAccess = 'private')
        functionCalls
        subgradientCalls
    end
    
    methods (Abstract)
        getValueAt(obj, x);
        getValueForPlot(x,y);
        getSubgradientAt(obj, x);
        resetCounters(obj);    
    end
end