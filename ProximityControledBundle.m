function [ xStar, Xs, asCounter, nsCounter]  = ProximityControledBundle( funct, xk, params )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
finalAccuracy = params(1);
mL = params(2);
mR = params(3);
minWeight = params(4);
maxBundleSize = params(5);

%Counters
mainIterator = 1;
seriousSteps = 0;
variationEst = Inf;

Bundle = Subgradient(funct,xk);
Alphas = 0;

%
weigth = 0.5; %ToDo
currentFunctionValue = funct(xk);

while mainIterator < maxIter

    [descendEstimate, direction, multiplier] = solveDP(1/weigth, Bundle, Alphas, tol);
    
    alphakTilde = Alphas * multiplier;
    skTilde = Bundle * multiplier;
    
    if StoppingCondition()
        break;
    end
    
    %descent test
    newPoint = xk + direction;
    fAtNewPoint = funct(newPoint);
    descendReal = fAtNewPoint - currentFunctionValue;
    
    skPlus = Subgradient(funct, newPoint);
    
    if EnoughDescend(fAtNewPoint,currentFunctionValue, descendEstimate, mL)
        descendIndicator = 1;
        currentFunctionValue = fAtNewPoint;
        
        alphakPlus = - descendReal + dot(skPlus,direction);
        [ Bundle, Alphas ]  = UpdateBundlePlus(Bundle, Alphas, 1, maxBundleSize, descendReal, direction, skPlus, alphakPlus)
    else
        descendIndicator = 0;
        [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, -1, maxBundleSize, descendReal, direction, skTilde, alphakTilde, skPlus, alphakPlus);
    
    end
    
    
    
mainIterator = mainIterator + 1;
end


end


function cond = StoppingCondition()
    cond = (descendEst >= finalAccuracy);
end

function cond = EnoughDescend(fAtNewPoint, currentFunctionValue, descendEst, mL)
    cond = (fAtNewPoint <= currentFunctionValue + mL*descendEst);
end

