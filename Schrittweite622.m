function [ tauJ, xPlus, sPlus, alphaPlus, outcome, fxdMinusfx ] = Schrittweite622( funct, x, d, params )

    %Page 111

epsilonTilde = params(1);
m1 = params(2);
m2 = params(3);

%ToDo: what to do with v?
v = DirectionalDerivative(funct,x,d);
if v >= 0
    v = -v;
end

tauLow = 0;
tauHigh = Inf;
tauJ = 1;
j=0;
maxIter = 30;

while j < maxIter
    %LS1
    xPlus = x + tauJ*d;
    
    fx = funct(x);
    fxd = funct(xPlus);
    fxdMinusfx = fxd - fx;
    
    sPlus = Subgradient (funct, xPlus);
    alphaPlus = - fxdMinusfx + dot(sPlus, tauJ*d);
    
    %LS2
    if dot(sPlus, d) >= m2*v && alphaPlus <= epsilonTilde
        outcome = -1;
        break;
    end
    
    %LS3
    if dot(sPlus, d) >= m2*v && fxdMinusfx <= m1*tauJ*v
        outcome = 1;
        break;
    end
    
    %LS4
    if fxdMinusfx >= m1*tauJ*v
        tauHigh = tauJ;
        tauJ = Interpol(tauLow, tauHigh);
    else
        tauLow = tauJ;
        if tauHigh == Inf
            tauJ = Extrapol(tauJ);
        else
            tauJ = Interpol(tauLow, tauHigh);
        end
    end
    
fprintf('Tauj: %.3e\n', tauJ);
    %LS5
    j=j+1;
    
end
    % Subprocedures

    function res = Interpol(x,y)
        res = (x+y)*0.5;
    end

    function res = Extrapol(x)
        res = 2*x;
    end
end

