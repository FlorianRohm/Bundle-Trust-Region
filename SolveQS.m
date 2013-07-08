function beta = SolveQS(epsilon, Bundle, Alphas)
    dimensionOfBeta = length(Alphas);
    A = Alphas;
    b = epsilon;
    Aeq = ones(1,dimensionOfBeta);
    beq = 1;
    lb = zeros(dimensionOfBeta,1);
    ub = Inf(dimensionOfBeta,1);
    
    %Start Value
    startValue = repmat(1/dimensionOfBeta,dimensionOfBeta,1);
    
    options = optimoptions('fmincon','Algorithm','active-set', 'TolCon', 1e-12, 'TolFun', 1e-12, 'Display', 'off');
    beta = fmincon(@QS_Problem, startValue, A, b, Aeq, beq, lb, ub, [], options);

    function value = QS_Problem(beta)
        vector = Bundle*beta;
        value = 0.5* dot(vector,vector);
    end
end