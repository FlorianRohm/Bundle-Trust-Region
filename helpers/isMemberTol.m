function [ ismember, index ] = isMemberTol( A, b, tol )
%ISMEMBERTOL Summary of this function goes here
%   Detailed explanation goes here
ismember = false;
index = 0;

cols = size(A,2);

for i=1:cols
    %col = A(:,i);
    %diff = abs(col-b);
    
    if(abs(A(:,i)-b) <= tol)
        ismember = true;
        index= i;
        break;
    end
end

end

