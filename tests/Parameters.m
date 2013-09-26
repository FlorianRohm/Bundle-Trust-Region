classdef Parameters < handle
    
    properties
        m1 = 0.1
        m2 = 0.2
        m3 = 0.1
        eta = 1e-4
        T = 3
        gammaI = 0.1
        thresholdT = 0.1
        maxBundleSize = 15
        manualTk = 0
        bundleUpdate = 'fifo'
    end   
    methods
        function new = copy(this)
            new = feval(class(this));
            p = properties(this);
            for i = 1:length(p)
                new.(p{i}) = this.(p{i});
            end
        end
    end
end