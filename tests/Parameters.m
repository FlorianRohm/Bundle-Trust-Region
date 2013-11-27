classdef Parameters < handle
    
    properties
        m1 = 0.1
        m2 = 0.2
        m3 = 0.1
        eta = 1e-4
        T = 3 %max{ 0.1(fx1-fopt),1}
        gammaI = 0.1
        thresholdT = 0.1
        maxBundleSize = 15
        manualTk = 0 %0 for linesearch 
        bundleUpdate = 'fifo'
        %available: 'fifo', 'largest error', 'random'
        breakCondition = 'test v'
        %available: 'test v', 'test alpha'
        auxTol = 1e-8;
        auxRound = false;
        maxIter = 200;
        minimalTrustRegion = 0;
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