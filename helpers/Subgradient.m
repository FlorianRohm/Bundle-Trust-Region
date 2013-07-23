function subgradient = Subgradient(funct, xToEvaluate)
% gehts one subgradient of a given function at a given point.
% Needs 2*dimension function calls
% Adopted from http://www.matrixlab-examples.com/gradient.html

delta = 1e-12;

global functionCalls;
global sgradCalls;
%preallocating
subgradient = zeros(length(xToEvaluate),1);

for i = 1 : length(xToEvaluate)
    deltaX = xToEvaluate;                     
    
    deltaX(i) = xToEvaluate(i) + delta;
    f1 = funct( deltaX );
    
    deltaX(i) = xToEvaluate(i) - delta;
    f2 = funct( deltaX );      
    
    subgradient(i,1) = (f1 - f2) / (2 * delta);  

    functionCalls = functionCalls - 2;
end

sgradCalls = sgradCalls + 1;
end