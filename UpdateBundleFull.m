function [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, outcome, parameterObj, fxdMinusfd, dt, sTildeK, alphaTildeK, skPlus, alphakPlus)
%Updates the current Bundle, considering the result of the attempted step

currentSize = size(Bundle);
currentSize = currentSize(2); % sadly no chaining :(

maxBundleSize = parameterObj.maxBundleSize;
update = parameterObj.bundleUpdate;

sizeAfterUpdate = currentSize + 2;
tooMuch = sizeAfterUpdate - maxBundleSize;

protected = 0;
for i = currentSize:-1:1
    if Alphas(i) == 0
        protected = i;
        break;
    end
end

%Update of Alphas
currentSize = size(Bundle);
currentSize = currentSize(2);
if outcome == -1
    
    Bundle(:,currentSize+1) = sTildeK;
    Bundle(:,currentSize+2) = skPlus;
    Alphas(currentSize+1) = alphaTildeK;
    Alphas(currentSize+2) = alphakPlus;
else
    Bundle(:,currentSize+1) = sTildeK;
    Alphas(currentSize+1) = alphaTildeK;
    Alpha1 = repmat(fxdMinusfd,1,currentSize+1);
    Alpha2 = -dt' * Bundle;
    Alphas = Alphas + Alpha1 + Alpha2;
    
    Bundle(:,currentSize+2) = skPlus;
    Alphas(currentSize+2) = 0;
end

if tooMuch >= 1
    switch update
        case 'largest error'
           AValidToDelete = Alphas(1:currentSize);
           [~,index] = max(AValidToDelete);
           Bundle(:,index) = [];
           Alphas(index) = [];
           AValidToDelete(index) = [];
           if tooMuch == 2
               [~,index2] = max(AValidToDelete);
               Bundle(:,index2) = [];
               Alphas(index2) = [];
           end

        case 'fifo'
            for i = 1:tooMuch
                if 1 ~= protected
                    Bundle(:,1) = [];
                    Alphas(1) = [];
                else
                    Bundle(:,2) = [];
                    Alphas(2) = [];
                end
            end
        case 'random'
            r = getNonProtectedInt(currentSize, protected);
            
            Bundle(:,r) = [];
            Alphas(r) = [];
            
            if tooMuch == 2
                r = getNonProtectedInt(currentSize-1, protected);
            
                Bundle(:,r) = [];
                Alphas(r) = [];
            end
        otherwise
            error('Update nicht unterstützt.');
    end
end

end

function r = getNonProtectedInt(max,protected)
    r = randi(max,1);
    while r == protected
        r = randi(max,1);
    end
end

