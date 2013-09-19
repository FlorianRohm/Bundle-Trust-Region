function [ output ] = Vector2String( vector, format )
%Converts a Vector to a string with a given format
str = strcat(format, ', ');
s = repmat(str,1,length(vector));
s(end)=[]; %Remove trailing comma

output = sprintf(['[' s ']'], vector);

end

