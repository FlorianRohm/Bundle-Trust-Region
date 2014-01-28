clc
clear
close all;

baseParameters = Parameters;
baseParameters.eta = 1e-4;
baseParameters.bundleUpdate = 'largest error';
%set Up Bundle sizes
bundleSizes = 3:1:60;

outputProperties = OutputProperties;
outputProperties.allFalse;

%Ausgabe der Parameter
fprintf('Startparameter:\n');
fprintf('m1: %.2f\n', baseParameters.m1);
fprintf('m2: %.2f\n', baseParameters.m2);
fprintf('m3: %.2f\n', baseParameters.m3);
fprintf('Abbruchschranke: %.1e\n', baseParameters.eta);
fprintf('Maximale Bundlegrößen: %s\n', Vector2String(bundleSizes, '%d'))
fprintf('gamma_I: %.2f\n', baseParameters.gammaI);
fprintf('Schwelle für T: %.2f\n', baseParameters.thresholdT);
if baseParameters.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', baseParameters.manualTk);
end

% set which function to test
% CB2, Wolfe, RosenSuzuki, Maxq20, Maxl20, Hilbert50, Goffin50
TestFunction = Maxq20;
errorHistoriesValue = [];
errorHistoriesFiber = [];

%Iterate the Parameters
for i = 1:size(bundleSizes,2)
    bundleSize = bundleSizes(i);
    fprintf('Aktuelle Bundlegröße: %d\n', bundleSize);
    currentParameter = baseParameters;
    currentParameter.maxBundleSize = bundleSize;
    [Xs, FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCall, subgradCall] = ...
   Tester ( TestFunction, currentParameter, outputProperties);
    errors(:,i) = error;
    errorValues(:,i) = errorValue;
    funcCalls(:,i) = funcCall;
    subgradCalls(:,i) = subgradCall;
    errorHistoriesValue = AddVector2Matrix(errorHistoriesValue,errorHistoryValue');
    errorHistoriesFiber = AddVector2Matrix(errorHistoriesFiber,errorHistoryFiber');
end

%plotting Section

figure;
plotValue = errorHistoriesValue(:,1)';
plotValue = plotValue(~isnan(plotValue));
semilogy(plotValue, 'DisplayName', sprintf('%d', bundleSizes(1)));
hold on;
for ii = 2:size(errorHistoriesValue,2)
    plotValue = errorHistoriesValue(:,ii)';
    plotValue = plotValue(~isnan(plotValue));
    semilogy(plotValue, 'DisplayName', sprintf('%d', bundleSizes(ii)));
end
hold off;

figure('Name','FehlerPlot','NumberTitle','off');
semilogy(bundleSizes,errorValues);
figure('Name','Funktionsaufrufe','NumberTitle','off');
plot(bundleSizes,funcCalls);
figure('Name','Subgradientenauswertungen','NumberTitle','off');
plot(bundleSizes,subgradCalls);
%now, having some fun :)
%figure('Name','Fehler pro Funktionsauswertung','NumberTitle','off');
%semilogy(bundleSizes,errorValues./funcCalls);
%figure('Name','Fehler pro Subgradientenauswertung','NumberTitle','off');
%semilogy(bundleSizes,subgradCalls./funcCalls);


%---------------Available Functions----------------
% [meshX,meshY] = meshgrid(0:0.01:2.5,-0.5:0.01:1.5);
% cb2 = CB2;
% Tester2D( cb2, parameterObj1, meshX, meshY, outputProperties );
% 
% [meshX,meshY] = meshgrid(-1.6:0.1:6,-5:0.1:5);
% wolfe = Wolfe;
% Tester2D( wolfe, parameterObj1, meshX, meshY, outputProperties );

% [meshX,meshY] = meshgrid(-1:0.01:2,-1:0.01:3);
% rosenSuzuki2 = RosenSuzuki2;
% Tester2D( rosenSuzuki2, parameterObj1, meshX, meshY, outputProperties);
% 
% %------------Higher Dimensions------------
% rosenSuzuki = RosenSuzuki;
% Tester( rosenSuzuki, parameterObj1, outputProperties);
% 
% maxq20 = Maxq20;
% Tester(maxq20, parameterObj1, outputProperties);
% 
% maxl20 = Maxl20;
% Tester(maxl20, parameterObj1, outputProperties);
% 
% hilbert50 = Hilbert50;
% Tester(hilbert50, parameterObj1, outputProperties);
% 
% goffin50 = Goffin50;
% Tester(goffin50, parameterObj1, outputProperties);