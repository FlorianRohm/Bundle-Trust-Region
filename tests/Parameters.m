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
        bundleUpdate = 'greatest error'
    end   
end