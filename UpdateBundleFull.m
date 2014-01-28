function [ Bundle, Alphas ] = UpdateBundleFull(Bundle, Alphas, outcome, parameterObj, fxdMinusfd, dt, sTildeK, alphaTildeK, skPlus, alphakPlus)
%Updates the current Bundle, considering the result of the attempted step

currentSize = size(Bundle);
currentSize = currentSize(2); % sadly no chaining :(

maxBundleSize = parameterObj.maxBundleSize;
update = parameterObj.bundleUpdate;


protected = 0;
for i = currentSize:-1:1
    if Alphas(i) == 0
        protected = i;
        break;
    end
end

%Update of Alphas
currentSize = size(Bundle,2);

%[ismem1, ind1] = isMemberTol(Bundle, sTildeK, 1e-6);
%[ismem2, ind2] = isMemberTol(Bundle, skPlus, 1e-6);
ismem1 = false;
ismem2 = false;

if outcome == -1
    if (~ismem1)
        Bundle(:,currentSize+1) = sTildeK;
        Alphas(currentSize+1) = alphaTildeK;
    else
        Bundle(:,ind1) = sTildeK;
        Alphas(ind1) = alphaTildeK;
    end
    if (~ismem2)
        Bundle(:,currentSize+2) = skPlus;
        Alphas(currentSize+2) = alphakPlus;
    else
        Bundle(:,ind2) = skPlus;
        Alphas(ind2) = alphakPlus;
    end
    
else
    
    if (~ismem1)
        Bundle(:,currentSize+1) = sTildeK;
        Alphas(currentSize+1) = alphaTildeK;
    else
        Bundle(:,ind1) = sTildeK;
        Alphas(ind1) = alphaTildeK;
    end
    Alpha1 = repmat(fxdMinusfd,1,size(Bundle,2));
    Alpha2 = -dt' * Bundle;
    Alphas = Alphas + Alpha1 + Alpha2;
    
    if (~ismem2)
        Bundle(:,currentSize+2) = skPlus;
        Alphas(currentSize+2) = 0;
    else
        Bundle(:,ind2) = skPlus;
        Alphas(ind2) = 0;
    end
end

sizeAfterUpdate = size(Bundle,2);
tooMuch = sizeAfterUpdate - maxBundleSize;

if tooMuch >= 1
    switch update
        case 'largest error'
           AValidToDelete = Alphas(1:currentSize);
           % prevents the deletion of the newly added
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

