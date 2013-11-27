function  TestPositive( Alphas )

lowest = min(Alphas);
if lowest < 0
    fprintf('Negative alpha value: %.2e\n', lowest);
end
end

