function [ tk, vTauJ, dTauJ, skTilde, alphakTilde, skPlus, alphakPlus, outcome, fxdMinusfx, fx ] = Verfahren842( functionObject, xk, tkMinus1, Bundle, Alphas, skTildeMinus1, alphakTildeMinus1, parameterObject, outputPropertiesObj )
%Computes a trust region Parameter for Bundle Trust Region
funct = @functionObject.getValueAt;
fx = funct(xk);
tauLeft = 0;
tauRight = parameterObject.T;

maxIter = 100;
j=0;
tauJ = tkMinus1;

while j < maxIter
    j = j+1;
    %Step1
    [vTauJ, dTauJ, betaTauJ] = solveDP(tauJ, Bundle, Alphas, 1e-8);
    
    fxd = funct(xk + dTauJ);
    fxdMinusfx = fxd - fx;
    
    ykPlus = xk + dTauJ;
    skPlus = functionObject.getSubgradientAt(ykPlus);

    alphakTilde = Alphas * betaTauJ;
    skTilde = Bundle * betaTauJ;

    %Step2
    if Abbruchkriterium814()
        outcome = 0;
        tk = 0;
        vTauJ = 0;
        dTauJ = 0;
        alphakPlus = 0;
        break;
    end
    
    %Step3
    if Abstiegsbedingung815()
        if Abstiegsbedingung817()
            tk = tauJ;
            alphakPlus = 0;
            outcome = 1;
            break;
        else
            %Step4
            %tauJ too small, rise it
            tauLeft = tauJ;
            if tauRight == parameterObject.T
                tauJ = Extrapol(tauJ, parameterObject.T);
            else
                tauJ = Interpol(tauLeft, tauRight, parameterObject.gammaI);
            end
            continue;
        end
    end
    
    %Step5 now 815 is surely false, otherwise loop would have been
    %terminated
    
    alphakPlus = - fxdMinusfx + dot(skPlus,dTauJ);
    if Abstiegsbedingung822()
        tk = tauJ;
        outcome = -1;
        break;
    end
    
    %Step6 tauJ was too big, lower it
    tauRight = tauJ;
    tauJ = Interpol(tauLeft, tauRight, parameterObject.gammaI);
    
    outcome = -1; %maxiter equivalent to nullstep?
    tk = tauJ;
end
if outputPropertiesObj.innerIteration
    fprintf('Innere Iteration nach %d Iterationen mit %.3e TrustRegion Parameter verlassen\n', j,tk);
end
    function test814 = Abbruchkriterium814()
        test814 = (alphakTilde <= parameterObject.eta) && (dot(skTilde, skTilde) <= parameterObject.eta*parameterObject.eta);
    end

    function test815 = Abstiegsbedingung815()
        test815 =  fxd - fx< parameterObject.m1 * vTauJ;
    end
    function test817 = Abstiegsbedingung817()
        test817 = (dot(skPlus,dTauJ) >= parameterObject.m2 * vTauJ) || (tauJ >= parameterObject.T - parameterObject.thresholdT)  ;
    end
    function test822 = Abstiegsbedingung822()
        b1 = alphakPlus <= parameterObject.m3* alphakTilde;
        b2 = -fxdMinusfx <= norm(skTildeMinus1) + alphakTildeMinus1;
        test822 = b1 || b2;
    end
    
    function res = Extrapol(tauJ,T)
        res = (tauJ + T)*0.5;
    end
    
    function res = Interpol(left, right, bias)
        res = left + bias *(right-left);
    end

end

