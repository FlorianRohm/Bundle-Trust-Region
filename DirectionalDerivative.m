function [ derivat ] = DirectionalDerivative( funct, x, d )
%Directional Derivativ of function

fx = funct(x);
precision = 1e-12 * fx;
fxd = funct(x+precision*d);

derivat = (fxd-fx)/precision;

end

