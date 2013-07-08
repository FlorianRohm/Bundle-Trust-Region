function [ xk, Xs, asCounter, nsCounter ] = Bundle( funct, x0, params )
% Bundle Algorithm to solve nonsmooth, convex problem
% params include in this order
%
% Stepsize parameters
% 0 < m1 < m2 < 1
% 0 < m3 < 1
% 
% Break conditions
% 0 < epsilonLow
% 0 < eta
%
% Maximal size of bundle
% 3 < bundleMaxSize
%
% Page 128

m1 = params(1);
m2 = params(2);
m3 = params(3);

epsilonLow = params(4);
eta = params(5);

bundleMaxSize = params(6);
maxSteps = params(7);

% assuming f(xStar) is somewhere near zero
epsilonHigh = 2;

Bundle = Subgradient(funct, x0);
Alphas = 0;
k = 1;
xk = x0;

Xs(:,k) = xk;
nsCounter = 0;
asCounter = 0;

epsilonK = epsilonHigh;

%First Iteration

    dk = -Bundle; %s1
    [tk, ykPlus, skPlus, alphakPlus, outcome, fxdMinusfx] = Schrittweite622(funct, xk, dk, [epsilonK*m3 m1 m2]);
    
    if outcome == 1
        xkNext = ykPlus;
        epsilonK = ChooseNextEpsilon(epsilonK);
        asCounter = asCounter + 1;
    else
        xkNext = xk;
        nsCounter = nsCounter + 1;
    end
    
    [Bundle, Alphas] = UpdateBundlePlus(Bundle, Alphas, outcome, fxdMinusfx, tk*dk, skPlus, alphakPlus);
    
    k = k+1;
    xk = xkNext;
    Xs(:,k) = xk;

while k < maxSteps
    %1
    epsilonK = ClipTo(epsilonK, epsilonLow, epsilonHigh);
    
    %2
    [betaTilde] = SolveQS(epsilonK, Bundle, Alphas);
    
    sTildeK = Bundle * betaTilde;
    alphaTildeK = dot(betaTilde, Alphas);
    
    %3
    if( norm(sTildeK) <= eta)
        if(alphaTildeK <= epsilonLow )
            break;
        else
            epsilonHigh = max(0.1*alphaTildeK, epsilonLow);
            continue;
        end
    end
    
    %4
    dk = -sTildeK;
    [tk, ykPlus, skPlus, alphakPlus, outcome, fxdMinusfx] = Schrittweite622(funct, xk, dk, [epsilonK*m3 m1 m2]);
    
    if outcome == 1
        xkNext = ykPlus;
        epsilonK = ChooseNextEpsilon(epsilonK);
        asCounter = asCounter + 1;
    else
        xkNext = xk;
        nsCounter = nsCounter + 1;
    end
    
    %5
    [Bundle, Alphas] = UpdateBundleFull(Bundle, Alphas, outcome, bundleMaxSize, fxdMinusfx, tk*dk,  sTildeK, alphaTildeK, skPlus, alphakPlus);
    
    %6
    k = k+1;
    xk = xkNext;
    
    Xs(:,k) = xk;
end

%subprocedures
    function clip = ClipTo(x, low, high)
        if x < low;
            clip = low;
        elseif x>high
            clip = high;
        else
            clip = x;
        end
    end

    function new = ChooseNextEpsilon(old)
        new = 0.1*old;
    end

end

