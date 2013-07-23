function [ xStar, Xs, asCounter, nsCounter ] = BundleTrustRegion( funct, xk,  params )
%BundleTrustRegion A Bundle Trust Region Algorithm to find the minimum of a
%nonsmooth, convex function

m1 = params(1);
m2 = params(2);
m3 = params(3);
T = params(5);
maxBundleSize = params(8);

global functionCalls;
global sgradCalls;

%Helpers

k = 1;
Xs(:,k) = xk;
nsCounter = 0;
asCounter = 0;

%initial steps
s1 = Subgradient(funct , xk);
Bundle(:,1) = s1;
Alphas = 0;
skTildeMinus1 = s1;
alphakTildeMinus1 = 0;
maxIter = 300;


[ tk, xPlus, sPlus, alphaPlus, outcome, fxdMinusfx ] = Schrittweite622( funct, xk, -s1, [T*m3 m1 m2] );
[Bundle, Alphas] = UpdateBundlePlus (Bundle, Alphas, outcome, fxdMinusfx, -tk*s1, sPlus, alphaPlus);
if outcome == 1
    xk = xPlus;
end

TrustRegionFunctionCalls = functionCalls
TrustRegionSubgradientCalls = sgradCalls

consecutive = 0;
%run main loop
while k < maxIter
    [ tk, vk, dt, skTilde, alphakTilde, skPlus, alphakPlus, outcome, fxdMinusfx ] = Verfahren842( funct, xk, tk, Bundle, Alphas, skTildeMinus1, alphakTildeMinus1, params );
    if outcome == 0
        xStar = xk;
        break;
    end
    
    if outcome == 1
        xkPlus = xk + dt;
        asCounter = asCounter + 1;
        consecutive = UpdateConsecutiveInDescend(consecutive);
    else
        xkPlus = xk;
        
        consecutive = UpdateConsecutiveInNulls(consecutive);
        nsCounter = nsCounter + 1;
    end
    
    
    %update Bundle
    [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, outcome, maxBundleSize, fxdMinusfx, dt, skTilde, alphakTilde, skPlus, alphakPlus);

    xk = xkPlus;
    tk = ChooseNewT(tk, fxdMinusfx, vk, outcome, skTilde, alphakTilde, alphakPlus);
    
    skTildeMinus1 = skTilde;
    alphakTildeMinus1 = alphakTilde;
    k = k+1;
    xStar = xk;
    Xs(:,k) = xk;
end

    function nullschritte = UpdateConsecutiveInDescend(nullschritte)
        if nullschritte < 0
            nullschritte = -nullschritte
            nullschritte = 1;
            
            TrustRegionFunctionCalls = functionCalls
            TrustRegionSubgradientCalls = sgradCalls
        else
            nullschritte = nullschritte + 1;
        end
    end

    function abstiegsschritte = UpdateConsecutiveInNulls(abstiegsschritte)
        if abstiegsschritte > 0
            abstiegsschritte
            abstiegsschritte = -1;
            
            TrustRegionFunctionCalls = functionCalls
            TrustRegionSubgradientCalls = sgradCalls
        else
            abstiegsschritte = abstiegsschritte - 1;
        end
    end
    function tNew = ChooseNewT(tk,fxdMinusfx, vk, outcome, skTilde, alphakTilde, alphakPlus)
        persistent i;
        if isempty(i)
            i = 0;
        end
        persistent epsilon;
        if isempty(epsilon)
            epsilon = Inf;
        end
        
        uk = 1/tk;
        u = uk;
        uInt = 2*u*(1-fxdMinusfx)/vk;
       
        mR = 0.5;
        uMin = 1e-10;
        
        if outcome == 1
            if (fxdMinusfx <= mR * vk) && (i > 0)
                u = uInt;
            else
                if i >3
                    u = uk/2;
                end
            end
            %e
            ukPlus = max([u, uk/10, uMin]);
            epsilon = max ([epsilon, -2*vk]);
            i = max([i+1,1]);
            if ukPlus == uk
                i=1;
            end
            
        else
            epsilon = min([epsilon, norm(skTilde) + alphakTilde]);
            if ( alphakPlus > max([epsilon, -10*vk]) ) && (i<-3)
                u=uInt;
            end
            ukPlus = min([u, 10*uk]);
            i = min([i-1,-1]);
            
            if ukPlus == uk
                i=-1;
            end
        end
        
        tNew = 1/ukPlus;
    end


end


