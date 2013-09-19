function [ z ] = CB2( x,varargin )
%CB2 function to test Bundle Trust Region, 2D
%   Recommendet start point: (1,-.1)
%   optimum -1.952 at (1.1390,0.8996)

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
anOne = ones(size(x));

z = max(x.^2 + y.^4 , (2*anOne-x).^2 + (2*anOne-y).^2 );
z = max(z, 2*exp(-x+y));
end

