function [ derivat ] = DirectionalDerivative( funct, x, d )
%Directional Derivativ of function

fx = funct(x);
precision = max (1e-12, 1e-12 * abs(fx));
fxd = funct(x+precision*d);

derivat = (fxd-fx)/precision;

end

