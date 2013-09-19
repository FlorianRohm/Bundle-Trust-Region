function [Xs] = Tester( funct, start, minimum, params )
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable

global functionCalls;
global sgradCalls;

functionCalls =0;
sgradCalls = 0;

fprintf('------------------- Untersuche Funktion: %s -------------------\n\n',func2str(funct));

[xStar, Xs, advanceSteps, nullSteps] = BundleTrustRegion(funct, start, params);

fprintf(strcat('\nStartpunkt:',Vector2String(start, '%.4f'), '\n' ));
fprintf(strcat('Endpunkt:  ',Vector2String(xStar, '%.4f'), '\n\n' ));

error = xStar - minimum;

fprintf(strcat('Fehler:  ',Vector2String(error, '%.4e'), '\n' ));
fprintf('Fehlernorm: %.3e\n', norm(error) );

subgradientAtxStar = Subgradient(funct,xStar);

fprintf(strcat('Ein Subgradient im approx. Optimum: ',Vector2String(subgradientAtxStar, '%.4f'), '\n\n' ));

fprintf('Funktionsaufrufe:          %d\n', functionCalls);
fprintf('Subgradientenauswertungen: %d\n\n', sgradCalls);

fprintf('Abstiegsschritte gesamt:   %d\n', advanceSteps);
fprintf('Nullschritte gesamt:       %d\n\n', nullSteps);

functionCalls = 0;
sgradCalls = 0;
end