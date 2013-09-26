function [Xs,FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCalls, subgradCalls] = ...
    Tester( functionObject, parameterObject , outputPropertiesObj)
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable

if outputPropertiesObj.header
    fprintf('------------------- Untersuche Funktion: %s -------------------\n\n',functionObject.name);
end
[xStar, Xs,FXs, advanceSteps, nullSteps] = BundleTrustRegion(functionObject, parameterObject, outputPropertiesObj);

funcCalls = functionObject.functionCalls;
subgradCalls = functionObject.subgradientCalls;

error = xStar - functionObject.optimalPoint;
errorValue = functionObject.getValueAt(xStar) - functionObject.optimalValue;
subgradientAtxStar = functionObject.getSubgradientAt(xStar);

errorHistoryFiber = sqrt(sum(Xs.^2,1));
errorHistoryFiber = abs(errorHistoryFiber - norm(functionObject.optimalPoint));
errorHistoryValue = sqrt(sum(FXs.^2,1));
errorHistoryValue = abs(errorHistoryValue - norm(functionObject.optimalValue));

if outputPropertiesObj.printAnalysis
    fprintf(strcat('\nStartpunkt:',Vector2String(functionObject.startPoint, '%.4f'), '\n' ));
    fprintf(strcat('Endpunkt:  ',Vector2String(xStar, '%.4f'), '\n\n' ));

    fprintf(strcat('Fehler:  ',Vector2String(error, '%.4e'), '\n' ));
    fprintf('Fehlernorm: %.3e\n', norm(error) );
    fprintf('Fehlernorm der Funktionswerte: %.3e\n', norm(errorValue) );
    fprintf(strcat('Ein Subgradient im approx. Optimum: ',Vector2String(subgradientAtxStar, '%.4f'), '\n\n' ));

    fprintf('Funktionsaufrufe:          %d\n', funcCalls);
    fprintf('Subgradientenauswertungen: %d\n\n', subgradCalls);

    fprintf('Abstiegsschritte gesamt:   %d\n', advanceSteps);
    fprintf('Nullschritte gesamt:       %d\n\n', nullSteps);
end

if outputPropertiesObj.errorInFiber
    figure('Name',['Fehlerverlauf im Urbild bei ', functionObject.name],'NumberTitle','off')
    semilogy(errorHistoryFiber,'-*');
end

if outputPropertiesObj.errorInValue
    figure('Name',['Fehlerverlauf der Funktionswerte bei ', functionObject.name],'NumberTitle','off')
    semilogy(errorHistoryValue,'-*');
end


end