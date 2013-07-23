function [ tk, vTauJ, dTauJ, skTilde, alphakTilde, skPlus, alphakPlus, outcome, fxdMinusfx ] = Verfahren842( funct, xk, tkMinus1, Bundle, Alphas, skTildeMinus1, alphakTildeMinus1, params )
%Computes a trust region Parameter for Bundle Trust Region


m1 = params(1);
m2 = params(2);
m3 = params(3);
eta = params(4);
T = params(5);
gammaI = params(6);
thresholdT = params(7);

fx = funct(xk);
tauLeft = 0;
tauRight = T;

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
    skPlus = Subgradient(funct, ykPlus);

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
            if tauRight == T
                tauJ = Extrapol(tauJ, T);
            else
                tauJ = Interpol(tauLeft, tauRight, gammaI);
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
    tauJ = Interpol(tauLeft, tauRight, gammaI);
    
    
    outcome = -1; %maxiter equivalent to nullstep?
    tk = tauJ;
end

    function test814 = Abbruchkriterium814()
        test814 = (alphakTilde <= eta) && (dot(skTilde, skTilde) <= eta*eta);
    end

    function test815 = Abstiegsbedingung815()
        test815 =  fxd - fx< m1 * vTauJ;
    end
    function test817 = Abstiegsbedingung817()
        test817 = (dot(skPlus,dTauJ) >= m2 * vTauJ) || (tauJ >= T - thresholdT)  ;
    end
    function test822 = Abstiegsbedingung822()
        b1 = alphakPlus <= m3* alphakTilde;
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

