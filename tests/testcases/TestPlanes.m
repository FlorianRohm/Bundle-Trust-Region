clc
clear
close all;

parameterObj1 = Parameters;
parameterObj1.m1 = 0.1;
parameterObj1.m2 = 0.9;
parameterObj1.m3 = 0.1;
parameterObj1.eta = 1e-4;
parameterObj1.T = 1; %max{ 0.1(fx1-fopt),1}
parameterObj1.gammaI = 0.1;
parameterObj1.thresholdT = .001;
parameterObj1.maxBundleSize = 15;
parameterObj1.manualTk = 0; %0 for linesearch 
parameterObj1.bundleUpdate = 'fifo'; 
%available: 'fifo', 'largest error', 'random'
parameterObj1.breakCondition ='test v';
parameterObj1.maxIter = 1000;

outputProperties = OutputProperties;
outputProperties.printConsecutive = true;
outputProperties.showTauJ = true;
outputProperties.innerIteration = true;

%Ausgabe der Parameter
fprintf('Startparameter:\n');
fprintf('m1: %.2f\n', parameterObj1.m1);
fprintf('m2: %.2f\n', parameterObj1.m2);
fprintf('m3: %.2f\n', parameterObj1.m3);
fprintf('Abbruchschranke: %.1e\n', parameterObj1.eta);
fprintf('Maximale Bundlegröße: %d\n', parameterObj1.maxBundleSize)
fprintf('gamma_I: %.2f\n', parameterObj1.gammaI);
fprintf('Schwelle für T: %.2f\n', parameterObj1.thresholdT);
if parameterObj1.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', parameterObj1.manualTk);
end



%---------------2D Section----------------
[meshX,meshY] = meshgrid(-5:0.01:5.2,-2:0.01:2);
planes = Planes;
Tester2D( planes, parameterObj1, meshX, meshY, outputProperties );