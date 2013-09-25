function [Xs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistory, funcCalls, subgradCalls] = ...
    Tester( functionObject, parameterObject )
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable

fprintf('------------------- Untersuche Funktion: %s -------------------\n\n',functionObject.name);

[xStar, Xs, advanceSteps, nullSteps] = BundleTrustRegion(functionObject, parameterObject);

fprintf(strcat('\nStartpunkt:',Vector2String(functionObject.startPoint, '%.4f'), '\n' ));
fprintf(strcat('Endpunkt:  ',Vector2String(xStar, '%.4f'), '\n\n' ));

error = xStar - functionObject.optimalPoint;

fprintf(strcat('Fehler:  ',Vector2String(error, '%.4e'), '\n' ));
fprintf('Fehlernorm: %.3e\n', norm(error) );

errorValue = functionObject.getValueAt(xStar) - functionObject.optimalValue;

fprintf('Fehlernorm der Funktionswerte: %.3e\n', norm(errorValue) );

subgradientAtxStar = functionObject.getSubgradientAt(xStar);

fprintf(strcat('Ein Subgradient im approx. Optimum: ',Vector2String(subgradientAtxStar, '%.4f'), '\n\n' ));

fprintf('Funktionsaufrufe:          %d\n', functionObject.functionCalls-1);
fprintf('Subgradientenauswertungen: %d\n\n', functionObject.subgradientCalls);

fprintf('Abstiegsschritte gesamt:   %d\n', advanceSteps);
fprintf('Nullschritte gesamt:       %d\n\n', nullSteps);

funcCalls = functionObject.functionCalls-1;
subgradCalls = functionObject.subgradientCalls;

errorHistory = sqrt(sum(Xs.^2,1));
errorHistory = abs(errorHistory - norm(functionObject.optimalPoint));


figure('Name',strcat('Fehlerverlauf bei ', functionObject.name),'NumberTitle','off')
semilogy(errorHistory,'-*');

end