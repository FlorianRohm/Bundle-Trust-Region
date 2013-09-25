function [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, outcome, parameterObj, fxdMinusfd, dt, sTildeK, alphaTildeK, skPlus, alphakPlus)
%Updates the current Bundle, considering the result of the attempted step

currentSize = size(Bundle);
currentSize = currentSize(2); % sadly no chaining :(

maxBundleSize = parameterObj.maxBundleSize;
update = parameterObj.bundleUpdate;

sizeAfterUpdate = currentSize + 2;
tooMuch = sizeAfterUpdate - maxBundleSize;

if tooMuch >= 1
    switch update
        case 'greatest error'
           [~,index] = max(Alphas);
           Bundle(:,index) = [];
           Alphas(index) = [];
           currentSize = currentSize-1;
           if tooMuch == 2
               [~,index2] = max(Alphas);
               Bundle(:,index2) = [];
               Alphas(index2) = [];
               currentSize = currentSize-1;
           end

        case 'fifo'
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
        otherwise
            error('Update nicht unterstützt.');
    end
end

        

%Update of Alphas
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

end

