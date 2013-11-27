clc
clear
close all;

baseParam = Parameters;
baseParam.maxBundleSize = 20;
baseParam.eta = 1e-6;
baseParam.breakCondition = 'test v';
baseParam.auxTol = 1e-8;

%Ausgabe der Parameter
fprintf('Startparameter:\n');
fprintf('m1: %.2f\n', baseParam.m1);
fprintf('m2: %.2f\n', baseParam.m2);
fprintf('m3: %.2f\n', baseParam.m3);
fprintf('Abbruchschranke: %.1e\n', baseParam.eta);
fprintf('Maximale Bundlegröße: %d\n', baseParam.maxBundleSize)
fprintf('gamma_I: %.2f\n', baseParam.gammaI);
fprintf('Schwelle für T: %.2f\n', baseParam.thresholdT);
if baseParam.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', baseParam.manualTk);
end

exact = true;
round = true;
% %---------------2D Section----------------

% goffin2 = Goffin2;
% BundleUpdateTestForFunction(goffin2, baseParam, exact, round);

% cb2 = CB2;
% BundleUpdateTestForFunction(cb2, baseParam, exact, round);
% 
% wolfe = Wolfe;
% BundleUpdateTestForFunction(wolfe, baseParam, exact, round);
% 
% rosenSuzuki = RosenSuzuki;
% BundleUpdateTestForFunction(rosenSuzuki, baseParam, exact, round);
% 
% maxq20 = Maxq20;
% BundleUpdateTestForFunction(maxq20, baseParam, exact, round);
% 
% maxl20 = Maxl20;
% BundleUpdateTestForFunction(maxl20, baseParam, exact, round);
% 
% hilbert50 = Hilbert50;
% BundleUpdateTestForFunction(hilbert50, baseParam, exact, round);

goffin50 = Goffin50;
BundleUpdateTestForFunction(goffin50, baseParam, exact, round);





