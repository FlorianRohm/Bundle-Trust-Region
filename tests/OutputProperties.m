classdef OutputProperties < handle
    
    properties
        plot2D = true
        errorInFiber = false
        errorInValue = true
        printConsecutive = false
        printAnalysis = true
        showTauJ = false
        innerIteration = false;
        preMainLoop = true;
        header = true;
    end
    methods
        function allFalse(this)
            this.plot2D = false;
            this.errorInFiber = false;
            this.errorInValue = false;
            this.printConsecutive = false;
            this.printAnalysis = false;
            this.showTauJ = false;
            this.innerIteration = false;
            this.preMainLoop = false;
            this.header = false;
        end
        function allTrue(this)
            this.plot2D = true;
            this.errorInFiber = true;
            this.errorInValue = true;
            this.printConsecutive = true;
            this.printAnalysis = true;
            this.showTauJ = true;
            this.innerIteration = true;
            this.preMainLoop = true;
            this.header = true;
        end
    end
end