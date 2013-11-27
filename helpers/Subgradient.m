function subgradient = Subgradient(funct, xToEvaluate)
% gets one subgradient of a given function at a given point.
% Needs 2*dimension function calls
% Adopted from http://www.matrixlab-examples.com/gradient.html

delta = 1e-10*xToEvaluate;

%preallocating
subgradient = zeros(length(xToEvaluate),1);

for i = 1 : length(xToEvaluate)
     if xToEvaluate(i) == 0
        delta(i) = 1e-12;       
    end
     deltaX = xToEvaluate;                     

     deltaX(i) = xToEvaluate(i) + delta(i);
     f1 = funct( deltaX );

     deltaX(i) = xToEvaluate(i) - delta(i);
     f2 = funct( deltaX );      

    subgradient(i,1) = (f1 - f2) / (2 * delta(i));  
end

end