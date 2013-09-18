function [ z ] = wolfe( x, varargin )
%WOLFE Wolfe-function to test nonlinear convex algorithms
global functionCalls;
functionCalls = functionCalls + 1;

if nargin == 2
    z = zeros(size(x));
    y = varargin{1};
else
    z = 0;
    y = x(2);
    x = x(1);
end
mask1 = x<=0;
mask2 = x >= abs(y);
mask3 = ~(mask1 | mask2) ;
z(mask1) = 9*x(mask1) + 16*abs(y(mask1)) - x(mask1).^9;
z(mask2) = 5* sqrt(9 * x(mask2).^2 + 16*y(mask2).^2 );
z(mask3) = 9*x(mask3) + 16*abs(y(mask3));
end