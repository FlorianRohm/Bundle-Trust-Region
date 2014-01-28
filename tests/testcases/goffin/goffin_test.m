clc
clear
close all;

parameterObj = Parameters;
parameterObj.m1 = 0.05;
parameterObj.m2 = 0.1;
parameterObj.m3 = 0.95;
parameterObj.eta = 1e-4;
parameterObj.T = 0.1; %max{ 0.1(fx1-fopt),1}
parameterObj.gammaI = 0.1;
parameterObj.thresholdT = 0.001;
parameterObj.maxBundleSize = 25;
parameterObj.manualTk = 0; %0 for linesearch 
parameterObj.bundleUpdate = 'fifo'; 
%available: 'fifo', 'largest error', 'random'
parameterObj.auxRound = true;
parameterObj.auxTol = 1e-6;
parameterObj.breakCondition ='test v';
        %available: 'test v', 'test alpha'
parameterObj.maxIter = 1000;

outputProperties = OutputProperties;
allTrue(outputProperties);
outputProperties.innerIteration = false;

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

 
goffin50 = Goffin50;
[Xs, FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCalls, subgradCalls] = ...
    Tester(goffin50, parameterObj, outputProperties);

%optimal line
n=ones(50,1);
n=n/norm(n);
err = zeros(size(Xs,2),1);
for i = 1:length(err)
    p = Xs(:,i);
    err(i)= norm(p - dot(p, n)*n);
end
  
figure('Name','Echter Fehlerverlauf im Urbild bei Goffin','NumberTitle','off');
semilogy(err,'-*');