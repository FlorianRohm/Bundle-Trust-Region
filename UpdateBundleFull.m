function [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, outcome, maxBundleSize, fxdMinusfd, dt, sTildeK, alphaTildeK, skPlus, alphakPlus)
%Updates the current Bundle, considering the result of the attempted step

currentSize = size(Bundle);
currentSize = currentSize(2); % sadly no chaining :(

Bundle(:,currentSize+1) = sTildeK;

if outcome == -1
    
    Bundle(:,currentSize+2) = skPlus;
    Alphas(currentSize+1) = alphaTildeK;
    Alphas(currentSize+2) = alphakPlus;
else
    Alphas(currentSize+1) = alphaTildeK;
    Alphas = Alphas + repmat(fxdMinusfd,1,currentSize+1) - dt' * Bundle;
    
    Bundle(:,currentSize+2) = skPlus;
    Alphas(currentSize+2) = 0;
end

sizeAfterUpdate = currentSize + 2;
tooMuch = sizeAfterUpdate - maxBundleSize;

if tooMuch > 0
    protected = 0;
    for i = currentSize:-1:1
        if Alphas(i) == 0
            protected = i;
            break;
        end
    end
    
    for i = 1:tooMuch
        if 1 ~= protected
            Bundle(:,1) = [];
            Alphas(1) = [];
        else
            Bundle(:,2) = [];
            Alphas(2) = [];
        end
    end
    
end

end

