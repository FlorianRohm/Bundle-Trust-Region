function [ Bundle, Alphas ] = UpdateBundlePlus(Bundle, Alphas, outcome, fxdMinusfx, actualStep, skPlus, alphakPlus)
%Updates the current Bundle, considering the result of the attempted step

currentSize = size(Bundle);
currentSize = currentSize(2); % sadly no chaining :(

if outcome == -1
    
    Bundle(:,currentSize+1) = skPlus;
    Alphas(currentSize+1) = alphakPlus;
else
    Alphas = Alphas + repmat(fxdMinusfx,1,currentSize) - actualStep' * Bundle;
    
    Bundle(:,currentSize+1) = skPlus;
    Alphas(currentSize+1) = 0;
end

end

