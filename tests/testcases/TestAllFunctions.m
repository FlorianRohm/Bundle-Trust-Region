clc
clear
close all;

parameterObj1 = Parameters;
parameterObj1.m1 = 0.1;
parameterObj1.m2 = 0.2;
parameterObj1.m3 = 0.1;
parameterObj1.eta = 1e-4;
parameterObj1.T = 3; %max{ 0.1(fx1-fopt),1}
parameterObj1.gammaI = 0.1;
parameterObj1.thresholdT = 0.1;
parameterObj1.maxBundleSize = 3;
parameterObj1.manualTk = 0; %0 for linesearch 
parameterObj1.bundleUpdate = 'largest error'; 
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
fprintf('Maximale Bundlegr��e: %d\n', parameterObj1.maxBundleSize)
fprintf('gamma_I: %.2f\n', parameterObj1.gammaI);
fprintf('Schwelle f�r T: %.2f\n', parameterObj1.thresholdT);
if parameterObj1.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter �ber Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', parameterObj1.manualTk);
end



% %---------------2D Section----------------
% [meshX,meshY] = meshgrid(0:0.01:2.5,-0.5:0.01:1.5);
% cb2 = CB2;
% Tester2D( cb2, parameterObj1, meshX, meshY, outputProperties );
% 
% [meshX,meshY] = meshgrid(-10:0.5:30,-30:0.5:10);
% goffin2 = Goffin2;
% Tester2D( goffin2, parameterObj1, meshX, meshY, outputProperties );

% [meshX,meshY] = meshgrid(-1.6:0.1:6,-5:0.1:5);
% wolfe = Wolfe;
% Tester2D( wolfe, parameterObj1, meshX, meshY, outputProperties );

% [meshX,meshY] = meshgrid(-1:0.01:2,-1:0.01:3);
% rosenSuzuki2 = RosenSuzuki2;
% Tester2D( rosenSuzuki2, parameterObj1, meshX, meshY, outputProperties);
% 
% %------------Higher Dimensions------------
rosenSuzuki = RosenSuzuki;
Tester( rosenSuzuki, parameterObj1, outputProperties);
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