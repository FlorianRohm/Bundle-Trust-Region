function [ xStar, Xs,FXs, asCounter, nsCounter ] = ...
    BundleTrustRegion( functionObject, parameterObject )
%BundleTrustRegion A Bundle Trust Region Algorithm to find the minimum of a
%nonsmooth, convex function


%Helpers
k = 1;
Xs(:,k) = functionObject.startPoint;
FXs(1,k) = functionObject.getValueAt(functionObject.startPoint);
functionObject.resetCounters();

nsCounter = 0;
asCounter = 0;

%initial steps
s1 = functionObject.getSubgradientAt(functionObject.startPoint);
Bundle(:,1) = s1;
Alphas = 0;
skTildeMinus1 = s1;
alphakTildeMinus1 = 0;
xk = functionObject.startPoint;
maxIter = 300;

if parameterObject.manualTk == 0
    [ tk, xPlus, sPlus, alphaPlus, outcome, fxdMinusfx ] = ...
        Schrittweite622( functionObject, ...
                         functionObject.startPoint, ...
                         -s1, ...
                         [parameterObject.T*parameterObject.m3, ...
                         parameterObject.m1 ... 
                         parameterObject.m2] );
    [Bundle, Alphas] = ...
        UpdateBundlePlus (Bundle, ...
                          Alphas, ...
                          outcome, ...
                          fxdMinusfx, ...
                          -tk*s1, ...
                          sPlus, ...
                          alphaPlus);
    if outcome == 1
        xk = xPlus;
    end
else
   tk = parameterObject.manualTk;
end

fprintf('Funktionsaufrufe vor Hauptschleife:          %d\n', functionObject.functionCalls);
fprintf('Subgradientenauswertungen vor Hauptschleife: %d\n\n', functionObject.subgradientCalls);

consecutive = 0;
%run main loop
while k < maxIter
    [ tk, vk, dt, skTilde, alphakTilde, skPlus, alphakPlus, outcome, fxdMinusfx, fx ] = ...
        Verfahren842( functionObject, xk, tk, Bundle, Alphas, skTildeMinus1, alphakTildeMinus1, parameterObject );
    if outcome == 0
        xStar = xk;
        break;
    end
    
    if outcome == 1 %step was a descendand step
        xkPlus = xk + dt;
        asCounter = asCounter + 1;
        consecutive = UpdateConsecutiveInDescend(consecutive);
    else %step was null step
        xkPlus = xk;
        consecutive = UpdateConsecutiveInNulls(consecutive);
        nsCounter = nsCounter + 1;
    end
    
    tk = GetNewTk(tk, consecutive, fxdMinusfx, vk);
    
    %update Bundle
    [ Bundle, Alphas ] = ...
        UpdateBundleFull(Bundle, Alphas, outcome, parameterObject, fxdMinusfx, dt, skTilde, alphakTilde, skPlus, alphakPlus);

    xk = xkPlus;
    skTildeMinus1 = skTilde;
    alphakTildeMinus1 = alphakTilde;
    k = k+1;
    xStar = xk;
    Xs(:,k) = xk;
    FXs(1,k) = fx;
end
if consecutive <0
    fprintf('Aufeinanderfolgende Nullschritte:     %d\n', -consecutive);
else
    fprintf('Aufeinanderfolgende Absteigsschritte: %d\n', consecutive);
end

    function tNew = GetNewTk(tOld, consecutive, diff, v)
       tNew = tOld;
       if (diff <= 0.7*v) || consecutive >= 3
           tNew = 3.2*tOld;
       else
           if consecutive <= -3
               tNew = 0.2*tOld;
           end
       end
    end

    function nullschritte = UpdateConsecutiveInDescend(nullschritte)
        if nullschritte < 0 %we get a descend
            fprintf('Aufeinanderfolgende Nullschritte:     %d\n', -nullschritte);
            nullschritte = 1;
        else
            nullschritte = nullschritte + 1;
        end
    end

    function abstiegsschritte = UpdateConsecutiveInNulls(abstiegsschritte)
        if abstiegsschritte > 0
            fprintf('Aufeinanderfolgende Absteigsschritte: %d\n', abstiegsschritte);
            abstiegsschritte = -1;
            
        else
            abstiegsschritte = abstiegsschritte - 1;
        end
    end 
end