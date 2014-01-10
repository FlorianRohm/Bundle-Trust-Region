clc
clear
close all;

%No rounding error anymore...
parameterObj = Parameters;
parameterObj.m1 = 0.1;
parameterObj.m2 = 0.2;
parameterObj.m3 = 0.1;
parameterObj.eta = 1e-4;
parameterObj.T = 3; %max{ 0.1(fx1-fopt),1}
parameterObj.gammaI = 0.1;
parameterObj.thresholdT = 0.1;
parameterObj.maxBundleSize = 15;
parameterObj.manualTk = 0; %0 for linesearch 
parameterObj.bundleUpdate = 'fifo'; 
%available: 'fifo', 'largest error', 'random'
parameterObj.auxRound = false;
parameterObj.auxTol = 1e-8;
parameterObj.breakCondition ='test v';
parameterObj.maxIter = 300;

outputProperties = OutputProperties;
allTrue(outputProperties);

%Ausgabe der Parameter
fprintf('Startparameter:\n');
fprintf('m1: %.2f\n', parameterObj.m1);
fprintf('m2: %.2f\n', parameterObj.m2);
fprintf('m3: %.2f\n', parameterObj.m3);
fprintf('Abbruchschranke: %.1e\n', parameterObj.eta);
fprintf('Maximale Bundlegröße: %d\n', parameterObj.maxBundleSize)
fprintf('gamma_I: %.2f\n', parameterObj.gammaI);
fprintf('Schwelle für T: %.2f\n', parameterObj.thresholdT);
if parameterObj.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', parameterObj.manualTk);
end



% %---------------2D Section----------------
% [meshX,meshY] = meshgrid(0:0.01:2.5,-0.5:0.01:1.5);
% cb2 = CB2;
% Tester2D( cb2, parameterObj1, meshX, meshY, outputProperties );
% 
% [meshX,meshY] = meshgrid(-10:0.5:30,-30:0.5:10);
% goffin2 = Goffin2;
% Tester2D( goffin2, parameterObj1, meshX, meshY, outputProperties );

[meshX,meshY] = meshgrid(-1.6:0.1:6,-5:0.1:5);
wolfe = Wolfe;
Tester2D( wolfe, parameterObj, meshX, meshY, outputProperties );

% [meshX,meshY] = meshgrid(-1:0.01:2,-1:0.01:3);
% rosenSuzuki2 = RosenSuzuki2;
% Tester2D( rosenSuzuki2, parameterObj1, meshX, meshY, outputProperties);
% 
% %------------Higher Dimensions------------
% rosenSuzuki = RosenSuzuki;
% Tester( rosenSuzuki, parameterObj, outputProperties);
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