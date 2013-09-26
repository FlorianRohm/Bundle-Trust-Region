function out = AddVector2Matrix(matrix, vector)

    diff = size(matrix,1) - size(vector,1);
    if diff > 0
        vector = [vector; nan(diff, 1)];
    else
        matrix = [matrix,; nan(-diff, size(matrix,2))];
    end

    out = [matrix,vector];
end

