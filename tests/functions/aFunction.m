classdef aFunction < handle
    properties (Abstract,Constant) 
        startPoint
        optimalPoint
        optimalValue
        name
    end
    properties (Abstract, SetAccess = 'private')
        functionCalls
        subgradientCalls
    end
    
    methods (Abstract)
        getValueAt(obj, x);
        getSubgradientAt(obj, x);
        resetCounters(obj);
    end
end